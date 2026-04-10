# LMS Call

A Flutter app for sales and field teams that automatically tracks call logs and syncs them to your LMS (Lead Management System) backend.

---

## What it does

- Reads incoming, outgoing, missed, and rejected calls from the device
- Stores call logs locally (offline-first, works without internet)
- Syncs call logs to your LMS server in the background every 15 minutes
- Shows caller name, call duration, SIM slot, and call type
- Groups calls by contact for a clean, dialer-style view
- Notifies you when a sync succeeds or fails

---

## Features

| Feature | Details |
|---|---|
| Call log tracking | Reads last 30–180 days of device call logs |
| Offline-first | All data stored locally in SQLite; syncs when online |
| Background sync | WorkManager runs sync every 15 minutes automatically |
| OTP login | Mobile number + 6-digit OTP authentication |
| Auto logout | Redirected to login automatically on session expiry (401) |
| Search | Search call history by name or number |
| Retry failed | Reset and retry any logs that failed to sync |
| Sync notifications | Local push notification after every sync |
| Multi-SIM support | Tracks which SIM slot was used per call |
| Dark theme | Full dark UI |

---

## Tech Stack

- **Flutter** + **Dart**
- **Riverpod** — state management
- **Drift** — local SQLite database
- **Dio** — HTTP client with auth interceptor
- **WorkManager** — background sync (Android)
- **flutter_local_notifications** — sync result notifications
- **Freezed** — immutable data models
- **SharedPreferences** — auth session + user settings

---

## Getting Started

### 1. Clone and install

```bash
git clone https://github.com/rahul9492/LMS-Call-App.git
cd LMS-Call-App
flutter pub get
```

### 2. Set your API base URL

Open `lib/core/constants/app_constants.dart` and replace:

```dart
static const String baseUrl = 'https://api.example.com/v1';
```

with your actual backend URL.

### 3. Generate code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run

```bash
flutter run
```

---

## API

The app posts call logs to `POST /call-logs/sync` with the following payload:

```json
{
  "user_id": "string",
  "call_logs": [
    {
      "id": "string",
      "phone_number": "string",
      "contact_name": "string",
      "call_type": "incoming | outgoing | missed | rejected | unknown",
      "timestamp": "ISO 8601",
      "duration_seconds": 0,
      "ring_duration_seconds": 0,
      "sim_display_name": "string",
      "sim_slot": 0
    }
  ]
}
```

Expected response:

```json
{ "accepted_ids": ["id1", "id2"] }
```

---

## Permissions Required (Android)

- `READ_CALL_LOG` — read device call history
- `READ_CONTACTS` — match numbers to contact names
- `READ_PHONE_STATE` — detect SIM slot information
- `INTERNET` — sync to server
- `POST_NOTIFICATIONS` — show sync notifications

---

## Project Structure

```
lib/
├── core/
│   ├── constants/      # App constants, routes
│   ├── theme/          # Dark theme colours
│   └── utils/          # Call type helpers, intent utils
├── data/
│   ├── database/       # Drift SQLite schema and queries
│   ├── models/         # Freezed models (CallLog, AuthUser)
│   ├── repositories/   # Single source of truth for call logs
│   └── services/       # API, auth, call log, connectivity, notifications
└── features/
    ├── auth/           # Login and OTP screens
    ├── call_logs/      # Home screen, call detail, search
    ├── permissions/    # Onboarding permissions screen
    ├── settings/       # Settings screen
    └── sync/           # Sync service, background sync, providers
```

---

## Version

`1.0.0`
