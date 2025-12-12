# Security Model

> ADB Device Manager — Security Architecture & Data Protection

---

## 1. Overview

ADB Device Manager is built with a **security-first philosophy**. The application is designed to operate entirely on your local network or via direct USB connection, ensuring that your data never leaves your control.

**Core Security Principles:**

- **No Cloud Servers** — All communication happens locally between your Windows PC and Android device
- **No External Data Transmission** — Your personal data (notifications, SMS, calls, files) is never uploaded or sent to any remote server
- **Offline-First Design** — Full functionality is available without an internet connection
- **Minimal Data Retention** — Data is accessed in real-time and not stored persistently

---

## 2. Architecture Summary

ADB Device Manager uses a direct communication architecture between your Windows PC and Android device.

### Communication Flow

```
┌─────────────────┐                    ┌─────────────────┐
│                 │   USB / Local LAN  │                 │
│  Windows App    │◄──────────────────►│  Android App    │
│                 │                    │                 │
└─────────────────┘                    └─────────────────┘
```

**Key Characteristics:**

- **Direct Device-to-Device** — Windows communicates directly with your Android device
- **No Third-Party Servers** — No intermediary cloud services are involved
- **Network Isolation** — All traffic remains within your local network (home WiFi, hotspot, or USB)
- **No Internet Dependency** — Core features work without internet access

---

## 3. Communication Channels

### ADB Mode (USB Connection)

ADB Mode uses Android Debug Bridge (ADB) for communication over USB.

| Aspect | Description |
|--------|-------------|
| **Connection Type** | USB cable with ADB debugging enabled |
| **Protocol** | ADB commands and scrcpy server |
| **Screen Mirroring** | Local scrcpy server on device |
| **Audio Forwarding** | Captured locally via scrcpy |
| **Internet Access** | Not required; cannot reach external networks |

**How It Works:**
1. User enables USB Debugging on their Android device
2. Windows app sends ADB commands through the USB connection
3. scrcpy server runs locally on the Android device for screen/audio capture
4. All data flows through the USB cable — nothing is transmitted over the internet

### App Mode (WiFi / Hotspot Connection)

App Mode uses local network communication for wireless operation.

| Aspect | Description |
|--------|-------------|
| **Connection Type** | Local WiFi network or mobile hotspot |
| **Protocol** | WebSocket / HTTP over local network |
| **Discovery** | mDNS for local device discovery |
| **Encryption** | TLS where supported |
| **Internet Access** | Not required for core functionality |

**How It Works:**
1. Both devices connect to the same local network
2. The Android companion app broadcasts its presence via mDNS
3. Windows app discovers and connects to the Android device
4. All communication stays within the local network

---

## 4. Data Handling

ADB Device Manager accesses certain data types to provide its features. Here's how each type is handled:

### Data Access Summary

| Data Type | Access | Storage | Uploaded | Purpose |
|-----------|--------|---------|----------|---------|
| **Notifications** | Read | Temporary (memory only) | Never | Display on Windows |
| **SMS Messages** | Read | Never stored | Never | Display and respond from Windows |
| **Call Logs** | Read | Never stored | Never | Display call history and caller info |
| **Contacts** | Read | Never stored | Never | Caller identification only |
| **Files** | Read/Write | User's devices only | Never | Local file transfer between devices |
| **Device Info** | Read | Local config only | Never | Device identification and settings |

### Handling Details

- **Notifications** — Accessed in real-time via Android's Notification Listener Service. Displayed temporarily on Windows; cleared from memory when dismissed.

- **SMS/Calls** — Accessed on-demand when the user views them. Never written to disk or cached persistently.

- **Contacts** — Read-only access for identifying callers. Contact data is not stored or exported.

- **Files** — Transferred directly between devices over local connection. Files are saved only to user-specified locations on their own devices.

- **No Uploads** — Under no circumstances is any user data uploaded to external servers.

---

## 5. Permissions & Purpose

The Android companion app requests the following permissions, each for a specific purpose:

| Permission | Purpose |
|------------|---------|
| `NOTIFICATION_LISTENER` | Read and display notifications on Windows |
| `READ_SMS` | View SMS messages for display on Windows |
| `SEND_SMS` | Send SMS replies from the Windows app |
| `READ_CALL_LOG` | Display recent calls and call history |
| `READ_CONTACTS` | Identify callers by name |
| `READ_PHONE_STATE` | Detect incoming calls for notification |
| `RECORD_AUDIO` | Audio forwarding during screen mirroring |
| `READ_EXTERNAL_STORAGE` | Access files for local transfer |
| `WRITE_EXTERNAL_STORAGE` | Save received files from Windows |
| `INTERNET` | Local network communication (WiFi mode only) |
| `ACCESS_NETWORK_STATE` | Detect network availability |
| `ACCESS_WIFI_STATE` | Identify local network for connection |
| `FOREGROUND_SERVICE` | Keep connection active in background |
| `RECEIVE_BOOT_COMPLETED` | Auto-start service after device reboot (optional) |

**Important:** All permissions are used solely for local device-to-device communication. No data collected through these permissions is ever transmitted to external servers.

---

## 6. Local Storage Security

### Configuration Files

The application stores minimal configuration data locally:

| File/Data | Location | Contents | Sensitive? |
|-----------|----------|----------|------------|
| **Windows Settings** | AppData folder | Window preferences, theme, shortcuts | No |
| **Device Profiles** | AppData folder | Device names, connection preferences | No |
| **License Data** | AppData folder | License validation status | No (no personal info) |

### Security Measures

- **No Sensitive Data Storage** — The application does not store SMS content, notification history, call logs, or contact information persistently.

- **Local-Only Config** — Configuration files remain on your device and are not synced or backed up to any cloud service.

- **No Encryption Required** — Since no sensitive personal data is stored, complex encryption of config files is not necessary. However, the application uses OS-level file permissions to protect settings.

---

## 7. Premium License Security

ADB Device Manager offers a premium plan with enhanced features. The licensing system is designed with privacy in mind.

### License Validation Process

| Aspect | Implementation |
|--------|----------------|
| **Validation Type** | Local-only license key verification |
| **Account Required** | No — no user account or registration |
| **Cloud Connection** | Not required for validation |
| **Personal Data** | Not collected or linked to license |
| **License Storage** | Stored locally on user's Windows PC |

### How Licensing Works

1. User receives a license key upon purchase
2. License key is entered in the Windows application
3. Validation is performed locally using cryptographic verification
4. License status is stored locally — no server calls required
5. No personal information (email, name, device ID) is collected or linked

---

## 8. Threat Model

### What ADB Device Manager Protects Against

| Threat | Protection |
|--------|------------|
| **Cloud Data Breaches** | No cloud storage means no cloud breach risk |
| **Third-Party Data Sharing** | No data sharing with any external parties |
| **Man-in-the-Middle (Local)** | ADB mode uses USB; WiFi mode uses local network only |
| **Unauthorized Remote Access** | No internet-facing servers or ports |
| **Data Mining/Profiling** | No analytics, telemetry, or user tracking |

### What ADB Device Manager Does NOT Protect Against

| Threat | Limitation |
|--------|------------|
| **Compromised Local Device** | If your PC or phone is already compromised by malware, the attacker may access data handled by the app |
| **Physical Device Access** | If someone has physical access to your unlocked devices, they can access the same data the app can |
| **Insecure Local Network** | On public WiFi, other users on the same network could potentially intercept traffic (use ADB/USB mode in such cases) |
| **ADB Security Weaknesses** | Standard ADB security concerns apply when USB debugging is enabled |

### Security Recommendations

- Keep USB Debugging disabled when not in use
- Use ADB Mode (USB) when on untrusted networks
- Keep both Windows and Android devices updated
- Do not authorize unknown computers for ADB debugging

---

## Document Information

| | |
|---|---|
| **Last Updated** | December 2024 |
| **Version** | 1.0 |
| **Applies To** | ADB Device Manager (Windows & Android) |

---

*This document describes the security architecture of ADB Device Manager. For data transparency information, see [TRANSPARENCY_REPORT.md](TRANSPARENCY_REPORT.md).*
