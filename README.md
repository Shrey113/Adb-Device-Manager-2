<div align="center">
  <img src="images/app_png.png" alt="ADB Device Manager Logo" width="120" style="border-radius: 20%; box-shadow: 0 4px 8px rgba(0,0,0,0.15);"/>

  # ADB Device Manager

  **Connect Android & Windows into one seamless control system**

  Built for power users, developers, and Android enthusiasts to bridge the gap between desktop and mobile ecosystems.

  <!-- Tech Stack & Project Badges -->
  <p align="center">
    <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=fff" alt="Flutter" />
    <img src="https://img.shields.io/badge/Kotlin-%237F52FF.svg?style=for-the-badge&logo=kotlin&logoColor=white" alt="Kotlin" />
    <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android" />
    <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=fff" alt="Python" />
    <img src="https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows11&logoColor=white" alt="Windows" />
  </p>
  
  <p align="center">
    <a href="https://github.com/Shrey113/Adb-Device-Manager-2/releases">
      <img src="https://img.shields.io/github/v/release/Shrey113/Adb-Device-Manager-2?style=flat-square&color=33CA56" alt="Latest Release" />
    </a>
    <a href="https://github.com/Shrey113/Adb-Device-Manager-2/stargazers">
      <img src="https://img.shields.io/github/stars/Shrey113/Adb-Device-Manager-2?style=flat-square&logo=github" alt="GitHub Stars" />
    </a>
    <a href="https://github.com/Shrey113/Adb-Device-Manager-2/issues">
      <img src="https://img.shields.io/github/issues/Shrey113/Adb-Device-Manager-2?style=flat-square&color=red" alt="GitHub Issues" />
    </a>
    <a href="https://github.com/Shrey113/Adb-Device-Manager-2/blob/main/LICENSE">
      <img src="https://img.shields.io/github/license/Shrey113/Adb-Device-Manager-2?style=flat-square&color=blue" alt="License" />
    </a>
  </p>
</div>

---


### Quick Start & Downloads
| Platform | Download Link | Status |
| :--- | :--- | :--- |
| Windows | [Download Installer →](https://shrey113.github.io/Adb-Device-Manager-2/windows_download.html) | Ready |
| Android | [Download APK →](https://shrey113.github.io/Adb-Device-Manager-2/android_download.html) | Ready |
| Linux | *Coming Soon* | Planning |
| macOS | *Coming Soon* | Planning |

### Official Website & Portals
| Section | Link |
| :--- | :--- |
| Virustotal Reports | [Visit Website →](https://shrey113.github.io/Adb-Device-Manager-2/pages/security_pages/virustotal_reports.html) |
| Official Website | [Visit Website →](https://shrey113.github.io/Adb-Device-Manager-2/) |
| Documentation | [Read Installation Docs →](https://shrey113.github.io/Adb-Device-Manager-2/docs/installation.html) |
| Developer Portal | [Visit Developer Hub →](https://shrey113.github.io/Adb-Device-Manager-2/pages/Developers.html) |

### Related Ecosystem Projects
| Project | Repository Link |
| :--- | :--- |
| Android-Dex | [Visit Project →](https://github.com/Shrey113/Android-Dex) |
| App-Scrcpy | [Visit Project →](https://github.com/Shrey113/App-Scrcpy) |

---

## Core Features

ADB Device Manager brings Android control directly to your desktop. Using two connection modes (ADB Mode and App Mode), you can:

*   **Mirror & Stream**: Mirror your Android screen or stream device audio directly to Windows with ultra-low latency.
*   **Control**: Control apps, notifications, answer calls, and send SMS using your PC keyboard and mouse.
*   **Transfer & Share**: Wirelessly transfer files, browse photo galleries, and manage device contacts.

---

## Deep Dive: ADB & App Modes

ADB Device Manager is designed around two modular modes that work seamlessly together or independently:

### ADB Mode
> **System-level control over USB or Wireless Debugging.**

| Feature | Description |
| :--- | :--- |
| [Screen Mirroring](docs/adb/screen-mirroring.md) | Mirror Android screen to Windows |
| [Audio Streaming](docs/adb/audio.md) | Stream device audio to PC |
| [Input Control](docs/adb/input-control.md) | Keyboard & mouse control |
| [Scrcpy Control](docs/adb/scrcpy-control.md) | Customize & manage Scrcpy commands |
| [Android Dex](docs/adb/android-dex.md) | Desktop-style experience |
| [Desktop Mode](docs/adb/desktop-mode.md) | Multi-app virtual display |
| [APK Installer](docs/adb/apk-installer.md) | Install apps via ADB |
| [Camera View](docs/adb/camera.md) | View device camera on PC |
| [Contacts](docs/adb/contacts.md) | Extract contacts via ADB |
| [Call History](docs/adb/call-history.md) | Read call logs |
| [SMS](docs/adb/sms.md) | Extract SMS messages |

---

### App Mode
> **Real-time device controls and application data synchronization running seamlessly over Local Wi-Fi/LAN.**

| Feature | Description |
| :--- | :--- |
| [Android Streaming](docs/app/android-streaming.md) | Mirror Android screen to Windows |
| [Media Control](docs/app/media-control.md) | Control music playback |
| [Notifications](docs/app/notifications.md) | Real-time notification sync |
| [Photo Gallery](docs/app/photo-gallery.md) | Browse photos wirelessly |
| [File Transfer](docs/app/file-transfer.md) | Fast LAN file transfer |
| [Contacts](docs/app/contacts.md) | Rich UI contact access |
| [Calls](docs/app/calls.md) | Manage calls from Windows |
| [SMS Messages](docs/app/sms.md) | Send/receive SMS |
| [Bluetooth](docs/app/bluetooth.md) | Bluetooth device tools |
| [TV Control](docs/app/tv-control.md) | Control Android TV & Cast Media |


---

### Windows Integration
> **Native Windows integration capabilities.**

| Feature | Description |
| :--- | :--- |
| [File Sharing](docs/windows/file-sharing.md) | Browser-based file sharing |
| [Bluetooth Pairing](docs/windows/bluetooth-pairing.md) | Stream audio to Windows |

---

## Keyboard Shortcuts

Speed up your workflow using native hotkeys:

| Shortcut | Action | Documentation |
| :---: | :--- | :---: |
| `Alt + S` | Screen Mirroring | [Mirroring Guide](docs/adb/screen-mirroring.md) |
| `Alt + A` | Audio Streaming | [Audio Guide](docs/adb/audio.md) |
| `Alt + Shift + D` | Android DeX | [DeX Guide](docs/adb/android-dex.md) |
| `Alt + F` | File Transfer | [File Sharing Guide](docs/windows/file-sharing.md) |

> See the [Full Shortcuts Reference](docs/shortcuts.md) for more options.

---

## 📊 Comparison Matrix

| Feature | ADB Device Manager | Vysor (Pro) | Link to Windows |
| :--- | :---: | :---: | :---: |
| **Screen Mirroring** | **Ultra-low latency ✅** | Slower | Good ✅ |
| **Screen Off Control** | ✅ | Limited | ❌ |
| **App-Audio-Only Mirroring** | ✅ | ❌ | ✅ |
| **Multi-App Desktop Running** | ✅ | ❌ | Limited |
| **Per-App Audio On/Off** | ✅ | ❌ | ❌ |
| **Notifications Sync** | ✅ | ❌ | ✅ |
| **Quick Access** | ✅ | ❌ | Limited |
| **SMS & Calls Sync** | ✅ | ❌ | ✅ |
| **Remote Camera** | ✅ | Limited | ❌ |
| **Bluetooth Audio Pairing** | ✅ | ❌ | ✅ |
| **Full Control Without ADB** | Limited | ❌ | ✅ |
| **Call Audio Capture** | ❌ | ❌ | ✅ |

---

## Friendly Links
*   [escrcpy](https://github.com/viarotel-org/escrcpy) - A graphical wrapper for scrcpy.

---

## Live Preview & Demos

<div align="center">

### Resizable Scrcpy
*Run Android apps in windows like desktop apps*

<img src="images/Most_imp/1_Scrcpy_resizable.gif" width="85%" alt="Resizable Scrcpy Demo" style="border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);"/>

<br><br>

### Media Sessions
*Control Android music directly from Windows media player/tray*

<img src="images/Most_imp/2_media_sessions.gif" width="85%" alt="Media Sessions Demo" style="border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);"/>

</div>

---

## Technologies & Dependencies

ADB Device Manager leverages a combination of open-source libraries and native platform frameworks:

*   **[ADB (Android Debug Bridge)](https://developer.android.com/tools/releases/platform-tools)** – Device communication, wireless pairing, and command execution.
*   **[scrcpy](https://github.com/Genymobile/scrcpy)** – Low latency display mirroring and remote input casting.
*   **[Flutter](https://flutter.dev/)** – Cross-platform UI framework for Windows and Android.
*   **[Kotlin](https://kotlinlang.org/)** – Android companion agent logic.
*   **[C#](https://learn.microsoft.com/en-us/dotnet/csharp/)** - Dekstop manager services, Tray APIs, and communication bridges.

> Special thanks to **[rom1v](https://github.com/rom1v)** for their contributions to the open-source ADB/scrcpy ecosystems, which provided critical insights for this project's architecture.

---

## Official Resources

| Category | Resource Link |
| :--- | :--- |
| Documentation | [Read Documentation](https://shrey113.github.io/Adb-Device-Manager-2/docs/Docs.html) |
| Setup Instructions | [Installation Guide](https://shrey113.github.io/Adb-Device-Manager-2/docs/installation.html) |
| FAQ | [View FAQ & Troubleshooting](https://shrey113.github.io/Adb-Device-Manager-2/docs/Docs.html#faq) |
| Security Model | [Read Security Specifications](https://shrey113.github.io/Adb-Device-Manager-2/security/security_model.html) |
| Transparency | [View Transparency Report](https://shrey113.github.io/Adb-Device-Manager-2/security/transparency_model.html) |
| Privacy Policy | [View Privacy Policy](https://shrey113.github.io/Adb-Device-Manager-2/security/privacy_policy.html) |
| Troubleshooting | [Fix Connection Issues](https://shrey113.github.io/Adb-Device-Manager-2/docs/Docs.html#troubleshooting) |

---

## Star History

<div align="center">
  <a href="https://www.star-history.com/?repos=Shrey113/Adb-Device-Manager-2&type=date&legend=top-left">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=Shrey113/Adb-Device-Manager-2&type=date&theme=dark&legend=top-left" />
      <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=Shrey113/Adb-Device-Manager-2&type=date&legend=top-left" />
      <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=Shrey113/Adb-Device-Manager-2&type=date&legend=top-left" width="85%" />
    </picture>
  </a>
</div>

---

<div align="center">

### Thanks for using ADB Device Manager! 🎉

**Made by [Shrey113](https://github.com/Shrey113)**

</div>
