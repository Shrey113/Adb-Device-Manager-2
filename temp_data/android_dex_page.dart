// android_dex_page.dart

import 'package:adb_devices/main_sub_part/Batch/Beta_Features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'android_dex_controller.dart';
import 'package:adb_devices/Android_Dex/android_dex_multi_audio.dart';
import 'package:adb_devices/Android_Dex/android_dex_scrcpy_high.dart';

class AndroidDexPage extends StatelessWidget {
  const AndroidDexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = AndroidDexController.instance;

    return Container(
      padding: const EdgeInsets.only(top: 12),
      color: const Color(0xFFF4F7FC),
      child: AnimatedBuilder(
        animation: ctrl,
        builder: (context, _) {
          return _buildMainUI(context, ctrl);
        },
      ),
    );
  }

  // ===========================================================================
  // MAIN PAGE LAYOUT
  // ===========================================================================
  Widget _buildMainUI(BuildContext context, AndroidDexController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context),
        const SizedBox(height: 8),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              children: [
                if (ctrl.isInstalled) ...[
                  _usbModeCard(ctrl, context),
                  const SizedBox(height: 15),
                  _openDexShortcutCard(),

                  const SizedBox(height: 15),
                  if (!ctrl.isRunning) _performanceModeSection(ctrl, context),
                ] else ...[
                  _usbModeCard(ctrl, context),
                  const SizedBox(height: 15),
                  _statusCard(ctrl),
                  const SizedBox(height: 15),
                  IntrinsicWidth(child: _startButton(ctrl)),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 28),
        // -------- FIXED ROW (pinned bottom) --------
        if (ctrl.isInstalled)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntrinsicWidth(child: _multiDeviceAudioButton(context, ctrl)),
              const SizedBox(width: 28),
              IntrinsicWidth(child: _startButton(ctrl)),
              const SizedBox(width: 24),
            ],
          ),

        const SizedBox(height: 28),
      ],
    );
  }

  // ===========================================================================
  // HEADER
  // ===========================================================================
  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      color: const Color(0xFFF0F4FA),
      child: Row(
        children: [
          const SizedBox(width: 16),

          // Android Icon
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "img_s/_my_app/app_png.png",
              width: 52,
              height: 52,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "android clone (Android Dex)",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Control & stream your Android device",
                  style: TextStyle(fontSize: 13.5, color: Colors.black54),
                ),
              ],
            ),
          ),

          // Beta Features Pill
          BetaBadge(),
        ],
      ),
    );
  }

  void showTextMessage(
    BuildContext context, {
    required String message,
    required IconData icon,
    required bool isSuccess, // true = green, false = red
  }) {
    final Color bgColor = isSuccess ? Colors.green : Colors.red;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 2),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white, // always white text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // USB MODE SWITCH CARD
  // ===========================================================================
  Widget _usbModeCard(AndroidDexController ctrl, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12.withOpacity(.06)),
      ),
      child: Row(
        children: [
          // Icon
          Icon(Icons.usb, color: Colors.black54, size: 24),
          const SizedBox(width: 12),
          // TEXT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "USB Mode",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              if (!ctrl.usbMode) ...[
                const SizedBox(height: 4),
                Text(
                  "Using USB For Best Performance",
                  style: const TextStyle(fontSize: 13.5, color: Colors.black54),
                ),
              ],
            ],
          ),

          const Spacer(),

          // SWITCH
          Transform.scale(
            scale: 1.15,
            child: CupertinoSwitch(
              value: ctrl.usbMode,
              onChanged: (v) async {
                ctrl.setCheckingUsb(true);

                if (v == true) {
                  final found = await ctrl.verifyUsbDevice();
                  ctrl.setCheckingUsb(false);

                  if (!found) {
                    showTextMessage(
                      context,
                      message: "USB device not found",
                      icon: Icons.usb,
                      isSuccess: false,
                    );
                    ctrl.setUsbMode(false);
                  } else {
                    showTextMessage(
                      context,
                      message: "USB device found",
                      icon: Icons.usb,
                      isSuccess: true,
                    );
                    ctrl.setUsbMode(true);
                  }
                } else {
                  ctrl.setCheckingUsb(false);
                  ctrl.setUsbMode(false);
                }

                await ctrl.checkInstalled();
              },
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // STATUS CARD
  // ===========================================================================
  Widget _statusCard(AndroidDexController ctrl) {
    final borderColor =
        ctrl.isInstalled ? const Color(0xFF2ECC71) : const Color(0xFFFFC35B);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1.4),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "img_s/_my_app/app_png.png",
              width: 52,
              height: 52,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Android Clone",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ctrl.isInstalled
                      ? "Ready — helper app installed"
                      : "Required to run Android Dex",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: borderColor.withOpacity(.16),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              ctrl.isInstalled ? "Installed" : "Required",
              style: TextStyle(
                color: borderColor,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PERFORMANCE MODE SECTION
  // ===========================================================================
  Widget _performanceModeSection(
    AndroidDexController ctrl,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Row(
            children: [
              Icon(Icons.speed, size: 22, color: Colors.black87),
              SizedBox(width: 10),
              Text(
                "Performance Mode",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // The 3 mode cards
          Row(
            children: [
              Expanded(
                child: _modeCard(
                  ctrl,
                  "Fast",
                  Icons.flash_on,
                  "60 FPS",
                  "1080p",
                  context,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _modeCard(
                  ctrl,
                  "Normal",
                  Icons.check_circle,
                  "90 FPS",
                  "HD",
                  context,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _modeCard(
                  ctrl,
                  "High",
                  Icons.rocket_launch,
                  "120 FPS",
                  "4K (20Mbps)",
                  context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // SIDE-BY-SIDE MODE CARD
  Widget _modeCard(
    AndroidDexController ctrl,
    String mode,
    IconData icon,
    String fps,
    String resolution,
    BuildContext context,
  ) {
    final isSelected = ctrl.selectedMode == mode;
    final color = mode == "High" ? Colors.deepPurple : Colors.blue;

    return GestureDetector(
      onTap: () async {
        if (mode == "High") {
          final confirm = await showHighModeWarning(context);
          if (confirm == false) return;
        }
        ctrl.setSelectedMode(mode);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(.10) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // LEFT: ICON
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (isSelected ? color : Colors.black45).withOpacity(.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 26,
                color: isSelected ? color : Colors.black54,
              ),
            ),

            const SizedBox(width: 16),

            // RIGHT: TEXT + DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MODE TEXT
                  Text(
                    mode,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? color : Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // FPS + RESOLUTION
                  Row(
                    children: [
                      _pill(fps, isSelected ? color : Colors.black45),
                      const SizedBox(width: 10),
                      Text(
                        resolution,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected
                                  ? color.withOpacity(.9)
                                  : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PILL
  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  // ===========================================================================
  // OPEN DEX SHORTCUT CARD
  // ===========================================================================
  Widget _openDexShortcutCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.android, color: Colors.orange.shade600, size: 30),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              "Open Android Dex (From anywhere)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          _keyBox("Alt"),
          const SizedBox(width: 6),
          const Text("+"),
          const SizedBox(width: 6),
          _keyBox("Shift"),
          const SizedBox(width: 6),
          const Text("+"),
          const SizedBox(width: 6),
          _keyBox("D"),
        ],
      ),
    );
  }

  Widget _keyBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    );
  }

  // ===========================================================================
  // MULTI-DEVICE AUDIO REQUEST
  // ===========================================================================
  Widget _multiDeviceAudioButton(
    BuildContext context,
    AndroidDexController ctrl,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (_) => MultiAudioFocusDialog(
                ip: ctrl.ip,
                deviceName: ctrl.name,
                iconBase64: "",
                appName: "",
                packageName: "",
                isApp: false,
              ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Row(
          children: [
            Icon(
              Icons.multitrack_audio_rounded,
              color: Colors.blue.shade700,
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Manage Multi-Device Audio On Device",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.blue.shade700,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // START BUTTON
  // ===========================================================================
  Widget _startButton(AndroidDexController ctrl) {
    final bool isInstalled = ctrl.isInstalled;
    final bool isRunning = ctrl.isRunning;

    IconData icon =
        !isInstalled
            ? Icons.download_rounded
            : isRunning
            ? Icons.stop_rounded
            : Icons.play_arrow_rounded;

    String label =
        !isInstalled
            ? "Install Helper App"
            : isRunning
            ? "Stop"
            : "Start";

    Color color =
        !isInstalled
            ? const Color(0xFF6A5AE0)
            : isRunning
            ? Colors.redAccent
            : const Color(0xFF1A73E8);

    return Center(
      child: SizedBox(
        width: 340,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 5,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: () async {
            if (!isInstalled) {
              await ctrl.installHelperApp();
            } else {
              isRunning ? await ctrl.stopScrcpy() : await ctrl.startScrcpy();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (ctrl.isInstalling) ...[
                SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Installing...",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ] else ...[
                Icon(icon, size: 22, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // end
}
