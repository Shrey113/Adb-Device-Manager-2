# Transparency Report

> ADB Device Manager — Data Collection & Privacy Transparency

---

## 1. Data Collection Summary

ADB Device Manager is committed to complete transparency about data practices. This section provides a clear overview of what data is accessed, where it is stored, and whether it is ever transmitted externally.

### Our Commitment

- **No Cloud Services** — We do not operate or connect to any cloud servers
- **No Analytics** — We do not collect usage statistics or behavioral data
- **No Telemetry** — We do not monitor how you use the application
- **No User Tracking** — We do not track users across sessions or devices

### Data Access Overview

| Data Type | Used? | Where Stored | Sent to Server? |
|-----------|-------|--------------|-----------------|
| Notifications | Yes | Local temporary (memory) | No |
| SMS | Yes | Not stored | No |
| Call Logs | Yes | Not stored | No |
| Contacts | Yes | Not stored | No |
| Files | Yes | Stored locally on your devices | No |
| Device Info | Yes | Local configuration only | No |
| Premium License | Yes | Local validation only | No |

### Explanation of Each Data Type

- **Notifications** — Read from your Android device and displayed temporarily on your Windows PC. Stored only in memory while displayed; never saved to disk or transmitted.

- **SMS** — Accessed on-demand when you view messages. Content is displayed on Windows but never stored by our application or sent anywhere.

- **Call Logs** — Shown only when you access the call history feature. Not stored or cached by the application.

- **Contacts** — Read only to display caller names for incoming calls. Contact data is not copied, stored, or exported.

- **Files** — Transferred directly between your devices using local connection (USB or WiFi). Files are saved only to locations you choose on your own devices.

- **Device Info** — Basic device identifiers (device name, model) used for display purposes and connection management. Stored locally in app configuration.

- **Premium License** — License keys are validated locally. No personal information is associated with or required for licensing.

---

## 2. Permissions Transparency

The Android companion app requests specific permissions to enable its features. Below is a complete list with explanations.

### Permission Details

| Permission | Why It's Required |
|------------|-------------------|
| **Notification Access** | Required to read your notifications and display them on Windows |
| **SMS (Read)** | Required to show your text messages on the Windows app |
| **SMS (Send)** | Required to send text message replies from the Windows app |
| **Call Log Access** | Required to display your recent calls and call history |
| **Contacts Access** | Required to show caller names instead of just phone numbers |
| **Phone State** | Required to detect when you receive incoming calls |
| **Microphone** | Required for audio forwarding during screen mirroring |
| **Storage (Read)** | Required to browse and select files for transfer |
| **Storage (Write)** | Required to save files received from Windows |
| **Internet** | Required for local WiFi communication (does not access external internet) |
| **Network State** | Required to check if you're connected to a network |
| **WiFi State** | Required to identify your local network for device discovery |
| **Foreground Service** | Required to maintain connection while app is in background |
| **Boot Completed** | Optional; allows auto-start after device restart |

### Permission Guarantees

- All permissions are used **exclusively** for local device-to-device features
- No permission is used to collect, analyze, or transmit data externally
- You can review and revoke any permission in Android Settings at any time

---

## 3. Communication Transparency

ADB Device Manager uses two methods to connect your Windows PC and Android device. Both are strictly local.

### USB Connection (ADB Mode)

| Aspect | Details |
|--------|---------|
| **Type** | Direct USB cable connection |
| **Protocol** | Android Debug Bridge (ADB) |
| **Network Traffic** | None — all data travels through the USB cable |
| **External Communication** | Impossible — USB cannot reach the internet |
| **Tracking** | None |

### WiFi Connection (App Mode)

| Aspect | Details |
|--------|---------|
| **Type** | Local Area Network (WiFi or Hotspot) |
| **Protocol** | WebSocket / HTTP |
| **Network Traffic** | Local network only (never leaves your router) |
| **External Communication** | None — traffic stays within your home/office network |
| **Tracking** | None |

### Communication Guarantees

- **No Remote Servers** — We do not operate servers that your devices connect to
- **No External API Calls** — The application does not call any external web APIs
- **No Tracking Pixels or Beacons** — No hidden tracking mechanisms exist
- **No Background Internet Usage** — The app does not use your internet connection for any purpose

---

## 4. Subscription Transparency

ADB Device Manager offers a premium plan with additional features. Here's exactly how it works:

### What Premium Requires

| Requirement | Status |
|-------------|--------|
| Account/Login | **Not required** |
| Email Address | **Not required** |
| Cloud Connection | **Not required** |
| Personal Information | **Not required** |

### How Premium Licensing Works

1. **Purchase** — You purchase a license through the official website
2. **Receive Key** — You receive a license key
3. **Enter Key** — You enter the key in the Windows application
4. **Local Validation** — The key is validated locally using cryptographic checks
5. **Activation Complete** — Premium features are unlocked; no internet needed

### Privacy Promises for Premium Users

- Your license key is **not linked** to your email, name, or any personal identifier
- License validation happens **entirely on your device** — no server calls
- We cannot track which features you use or how often
- Premium status is stored locally and never synced to any cloud

---

## 5. Third-Party Dependencies

ADB Device Manager uses the following third-party components to provide its functionality:

### Core Dependencies

| Component | Purpose | Data Sent Externally? |
|-----------|---------|----------------------|
| **ADB (Android Debug Bridge)** | Device communication over USB | No |
| **scrcpy** | Screen mirroring and audio capture | No |
| **Flutter** | Application framework (Windows & Android) | No |
| **Windows Native APIs** | System integration on Windows | No |

### Detailed Explanations

- **ADB (Android Debug Bridge)** — Open-source tool by Google for communicating with Android devices over USB. Runs entirely locally; does not transmit data externally.

- **scrcpy** — Open-source screen mirroring tool. The scrcpy server runs on your Android device and sends video/audio directly to your Windows PC. No data is sent to external servers.

- **Flutter** — Google's open-source UI framework. Used to build the application interface. Does not include analytics or telemetry in our build.

- **Windows Native Components** — Standard Windows APIs for system tray, notifications, and window management. No external communication.

### Third-Party Guarantees

- All third-party components are **open-source** and publicly auditable
- None of the components we use send data to external servers
- We do not include any advertising SDKs, analytics libraries, or tracking frameworks

---

## 6. Disclosure of Non-Collection

To be absolutely clear, ADB Device Manager does **NOT** engage in any of the following practices:

### We Do Not Collect

| Practice | Status |
|----------|--------|
| Telemetry Data | ❌ Not collected |
| Usage Analytics | ❌ Not collected |
| Crash Reports | ❌ Not collected automatically |
| User Behavior Tracking | ❌ Not collected |
| Device Fingerprinting | ❌ Not performed |
| User Profiling | ❌ Not performed |
| Advertising IDs | ❌ Not accessed |
| Location Data | ❌ Not accessed |

### We Do Not Perform

- **No User Data Uploads** — Your notifications, messages, calls, contacts, and files are never uploaded anywhere
- **No Background Data Collection** — The app does not collect data when you're not actively using it
- **No Cross-Device Tracking** — We do not track you across multiple devices or sessions
- **No Data Sales** — We do not sell, share, or monetize any user data
- **No Advertising** — The application contains no ads and no advertising SDKs
- **No Third-Party Data Sharing** — We do not share any data with any third parties

### Our Promise

ADB Device Manager is designed as a **local utility tool**. Its only purpose is to help you connect and control your Android device from your Windows PC. We have made deliberate technical choices to ensure your privacy:

- No cloud infrastructure to maintain or breach
- No user accounts to compromise
- No data collection to exploit
- No tracking to monetize

Your data stays on your devices — exactly where it belongs.

---

## Document Information

| | |
|---|---|
| **Last Updated** | December 2024 |
| **Version** | 1.0 |
| **Applies To** | ADB Device Manager (Windows & Android) |

---

*This document provides transparency about data practices for ADB Device Manager. For technical security details, see [SECURITY_MODEL.md](SECURITY_MODEL.md).*
