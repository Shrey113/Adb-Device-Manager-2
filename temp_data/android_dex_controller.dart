// android_dex_controller.dart
// FULL DEBUG PRINT VERSION (every step logged)

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:adb_devices/main_storage_manager/All_data.dart';
import 'package:adb_devices/main_system_services/Data_class/Device_class.dart';
import 'package:adb_devices/main_system_services/Hotkey_Manager/All_hot_key.dart';
import 'package:adb_devices/main_system_services/Hotkey_Manager/_hotkey_manager.dart';
import 'package:adb_devices/main_server_part/Socke_3_Android_Dex.dart';
import 'package:adb_devices/main_storage_manager/redux_device_manager.dart';

import 'package:hotkey_manager/hotkey_manager.dart';

/// ---------------------------------------------------------------------------
/// ANDROID DEX CONTROLLER
/// ---------------------------------------------------------------------------

class AndroidDexController extends ChangeNotifier {
  AndroidDexController._();
  static final AndroidDexController instance = AndroidDexController._();

  // ---------------------------------------------------------------------------
  // STATE
  // ---------------------------------------------------------------------------

  bool isInstalled = false;
  bool isInstalling = false;
  bool isRunning = false;

  bool usbMode = false;
  bool isCheckingUsb = false;

  String selectedMode = "Normal";
  String ip = "";
  String name = "";

  Process? _proc;

  static const pkg = "com.example.android_clone";
  static const apkPath = "All helper/android_clone.apk";

  // ---------------------------------------------------------------------------
  // STATE SETTERS
  // ---------------------------------------------------------------------------

  void setUsbMode(bool v) {
    usbMode = v;
    notifyListeners();
  }

  void setCheckingUsb(bool v) {
    isCheckingUsb = v;
    notifyListeners();
  }

  void setSelectedMode(String mode) {
    selectedMode = mode;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // CONFIGURE DEVICE
  // ---------------------------------------------------------------------------
  void configure({required String deviceIp, required String deviceName}) {
    ip = deviceIp;
    name = deviceName;
    setUsbMode(false);
    checkInstalled();
  }

  // ---------------------------------------------------------------------------
  // CHECK HELPER INSTALL
  // ---------------------------------------------------------------------------
  Future<bool> checkInstalled() async {
    try {
      // Build final command as ONE clean adb command
      final args =
          usbMode
              ? ["-d", "shell", "cmd", "package", "resolve-activity", pkg]
              : [
                "-s",
                "$ip:5555",
                "shell",
                "cmd",
                "package",
                "resolve-activity",
                pkg,
              ];

      final process = await Process.start(adb_path, args);

      // Read ALL output
      final output = await process.stdout.transform(const Utf8Decoder()).join();
      final error = await process.stderr.transform(const Utf8Decoder()).join();

      if (error.isNotEmpty) File_Log("ADB Error: $error");

      final bool newState =
          output.contains("ActivityInfo") &&
          !output.contains("No activity found");

      if (newState != isInstalled) {
        isInstalled = newState;
        notifyListeners();
      }

      return newState;
    } catch (e) {
      File_Log("CHECK INSTALL ERROR: $e");
      isInstalled = false;
      notifyListeners();
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // VERIFY USB DEVICE
  // ---------------------------------------------------------------------------
  Future<bool> verifyUsbDevice() async {
    try {
      final res = await Process.run(adb_path, ["-d", "get-state"]);
      final out = res.stdout.toString().trim();

      File_Log("USB get-state output: [$out]");

      if (out == "device") return true;
      if (out.toLowerCase().contains("device")) return true;

      return false;
    } catch (e) {
      File_Log("verifyUsbDevice failed: $e");
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // INSTALL HELPER APP
  // ---------------------------------------------------------------------------
  Future<void> installHelperApp() async {
    isInstalling = true;
    notifyListeners();

    try {
      final path = File(apkPath).absolute.path.replaceAll("/", "\\");

      final args =
          usbMode
              ? ["-d", "install", "-g", path]
              : ["-s", "$ip:5555", "install", "-g", path];

      final r = await Process.run(adb_path, args);

      File_Log("Install STDOUT: ${r.stdout}");
      File_Log("Install STDERR: ${r.stderr}");
    } catch (e) {
      File_Log("Install FAILED: $e");
    }

    isInstalling = false;
    await checkInstalled();
    notifyListeners();
  }

  Future<void> _setAccessibilityEnabled(bool enable) async {
    try {
      final service = "$pkg/$pkg.GlobalTouchService";
      final value = enable ? service : "";

      final adbArgs =
          usbMode
              ? [
                "-d",
                "shell",
                "settings",
                "put",
                "secure",
                "enabled_accessibility_services",
                value,
              ]
              : [
                "-s",
                ip,
                "shell",
                "settings",
                "put",
                "secure",
                "enabled_accessibility_services",
                value,
              ];

      await Process.run(adb_path, adbArgs);
    } catch (e) {
      File_Log("Accessibility FAILED: $e");
    }
  }

  // ---------------------------------------------------------------------------
  // SCRCPY START
  // ---------------------------------------------------------------------------
  Future<void> scrcpy_start_setup() async {
    await hotKeyManager.unregister(hotKeyGoHome);
    await hotKeyManager.unregister(hotKeyGoBack);
    await hotKeyManager.unregister(hotKeyRecentApps);

    await hotKeyManager.register(
      hotKey_AndroidDex_GoBack,
      keyDownHandler: (_) => AdbTcpServer.broadcast("go back"),
    );

    await hotKeyManager.register(
      hotKey_AndroidDex_Gohome,
      keyDownHandler: (_) => AdbTcpServer.broadcast("go home"),
    );

    await hotKeyManager.register(
      hotKey_AndroidDex_RecentApps,
      keyDownHandler: (_) => AdbTcpServer.broadcast("go recent"),
    );

    // enable accessibility
    _setAccessibilityEnabled(true);
  }

  Future<void> startScrcpy() async {
    isRunning = true;
    notifyListeners();

    // scrcpy args
    List<String> args = _buildScrcpyArgs();

    if (usbMode) {
      args.insert(0, "-d");
    } else {
      args.add("--tcpip=$ip");
      File_Log("SCRCPY using IP: $ip");
    }

    // --------------------------------------
    // START SCRCPY PROCESS
    // --------------------------------------
    try {
      await Process.run("adb", [
        "connect",
        "$ip:5555",
      ]); // Connect to the device
      _proc = await Process.start(scrcpy_path, args);

      _proc!.stdout
          .transform(utf8.decoder)
          .listen((d) => File_Log("SCRCPY OUT: $d"));

      _proc!.stderr
          .transform(utf8.decoder)
          .listen((d) => File_Log("SCRCPY ERR: $d"));

      await scrcpy_start_setup();
    } catch (e) {
      File_Log("SCRCPY START FAILED: $e");
    }

    _proc!.exitCode.then((code) {
      File_Log("SCRCPY exited with code: $code");
      _onScrcpyExit();
    });
  }

  // ---------------------------------------------------------------------------
  // EXIT CLEANUP
  // ---------------------------------------------------------------------------
  Future<void> _onScrcpyExit() async {
    isRunning = false;
    _proc = null;
    notifyListeners();

    try {
      final killArgs =
          usbMode
              ? ["-d", "shell", "am", "force-stop", pkg]
              : ["-s", "$ip:5555", "shell", "am", "force-stop", pkg];

      await Process.run(adb_path, killArgs);

      await hotKeyManager.unregister(hotKey_AndroidDex_GoBack);
      await hotKeyManager.unregister(hotKey_AndroidDex_Gohome);
      await hotKeyManager.unregister(hotKey_AndroidDex_RecentApps);

      // restore default hotkeys
      Device? d = getDeviceByIp(ip);
      if (d != null) {
        initHotkeys(d);
      }
    } catch (e) {
      File_Log("SCRCPY Exit cleanup failed: $e");
    }
  }

  // ---------------------------------------------------------------------------
  // SCRCPY STOP
  // ---------------------------------------------------------------------------
  Future<void> stopScrcpy() async {
    try {
      _proc?.kill();
    } catch (e) {
      File_Log("SCRCPY Kill failed: $e");
    }

    _proc = null;
    isRunning = false;

    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // SCRCPY ARG BUILDER
  // ---------------------------------------------------------------------------
  List<String> _buildScrcpyArgs() {
    switch (selectedMode) {
      case "Fast":
        return [
          "--new-display=1920x1080/280",
          "--video-codec=h264",
          "--video-bit-rate=4M",
          "--max-fps=60",
          "--video-buffer=0",
          "--display-ime-policy=local",
          "--start-app=$pkg",
          "--no-audio",
          "--no-vd-system-decorations",
          "-f",
          "--shortcut-mod=lctrl",
          "--window-title=AndroidDex",
        ];

      case "High":
        return [
          "--new-display=1920x1080/280",
          "--video-codec=h265",
          "--video-bit-rate=40M",
          "--max-fps=120",
          "--display-ime-policy=local",
          "--start-app=$pkg",
          "--no-audio",
          "--no-vd-system-decorations",
          "-f",
          "--shortcut-mod=lctrl",
          "--window-title=AndroidDex",
        ];

      default:
        return [
          "--new-display=1920x1080/280",
          "--max-fps=90",
          "--display-ime-policy=local",
          "--start-app=$pkg",
          "--no-audio",
          "--no-vd-system-decorations",
          "-f",
          "--shortcut-mod=lctrl",
          "--window-title=AndroidDex",
        ];
    }
  }
}
