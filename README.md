# Luna — Multiplatform Cycle Tracker

A privacy-first menstruation & ovulation tracker built with **Flutter**. It runs from a
single codebase on **iOS, Android, web, macOS, Windows and Linux**. All personal health
data stays **on-device** — there is no account and no server.

## Features

- **Modern calendar** (`table_calendar`) with custom day cells: logged period days, predicted period days, fertile window, ovulation day, today and per-day log markers, plus a cycle-status header and a selected-day detail card.
- **Ovulation & fertility prediction** from your own history (average cycle/period length, ovulation ≈ luteal-phase days before the next period, a 7-day fertile window).
- **Daily logging** of flow, symptoms, mood, notes and intimacy.
- **Insights** — average cycle/period length, regularity, a cycle-length chart (`fl_chart`) and most-common symptoms.
- **Notifications & reminders** — automatic period / fertile-window / ovulation / PMS / period-late alerts that reschedule whenever predictions change, plus custom repeating reminders (e.g. contraception).
- **App lock** — PIN (salted SHA-256 in the platform secure store) and biometric unlock, re-locking when the app is backgrounded.
- **Onboarding & settings** — first-run setup, cycle defaults, theme, JSON data export and a full data wipe.

## Architecture

Feature-first, with a pure-Dart core that's independent of Flutter and the database.

```
lib/
  core/
    cycle/         # PURE-DART prediction engine (predictor, forecast, period grouping)
    db/            # Drift database, tables, repositories, Riverpod providers
    notifications/ # NotificationService + scheduler
    security/      # PIN store, biometrics, lock state
    theme/         # Material 3 theme + shared CycleColors
    models/ utils/
  features/        # calendar, logging, insights, reminders, lock, onboarding, settings
```

- **State:** Riverpod. Reactive Drift streams flow through providers into the UI.
- **Single source of truth:** daily logs. A "period" is simply consecutive days with logged flow; `groupBleedingDays` derives period spans that feed the predictor — no separate periods table to keep in sync.
- **Database:** Drift over SQLite. On mobile/desktop the native library is the encrypted **SQLite3 Multiple Ciphers** build (selected via `hooks.user_defines` in `pubspec.yaml`); `PRAGMA key` encrypts the database with a random 256-bit key kept in the OS secure store.

## Platform notes

- **iOS, Android, macOS, Windows, Linux:** full support — encrypted database and scheduled local notifications.
- **Web:** logging, calendar and insights work, but two features differ:
  1. `flutter_local_notifications` has no web backend, so scheduled notifications are a mobile/desktop feature.
  2. SQLCipher-style at-rest encryption isn't available; web data lives in browser-sandboxed storage and uses `web/sqlite3.wasm` (sqlite3 3.3.3) and `web/drift_worker.js` (drift 2.34.0), which must be updated together with those packages.

## Running

```bash
flutter pub get
dart run build_runner build          # generates Drift code (app_database.g.dart)
flutter test                         # unit + widget tests
flutter run -d macos                 # or: -d chrome, an iOS simulator, an Android emulator
```

## Tests

- `test/cycle/` — prediction engine and period grouping (pure Dart).
- `test/data/` — Drift repositories on an in-memory database.
- `test/widget/` + `test/widget_test.dart` — app boot and the logged-period → calendar flow.

## Builds, releases and downloads

GitHub Actions builds every platform from this repository:

- **Web** — [`.github/workflows/deploy-web.yml`](.github/workflows/deploy-web.yml) runs on every push to `main` (analyze → test → `flutter build web`) and publishes to GitHub Pages at `https://abhishekkulhary.github.io/luna/`. One-time setup: *Settings → Pages → Source: GitHub Actions*.
- **Native apps** — [`.github/workflows/release.yml`](.github/workflows/release.yml) runs when a version tag is pushed and attaches the builds to a GitHub Release:

  ```bash
  git tag v1.0.0
  git push origin v1.0.0
  ```

  | Asset | Notes |
  | --- | --- |
  | `luna-android.apk` | Signed with your release key when the `ANDROID_*` secrets are set (below); otherwise a throwaway debug key. |
  | `luna-windows-x64.zip` | Includes the MSVC runtime DLLs. |
  | `luna-macos.dmg` | Universal, ad-hoc signed: allow it under *System Settings → Privacy & Security* on first launch. |
  | `luna-linux-x64.tar.gz` | Built on Ubuntu 24.04. |

  iOS is not distributed: installing outside the App Store needs an Apple developer account.

The web build has a **Get the app** button (hidden in the native apps) that lists these downloads from the latest release via the GitHub API ([`lib/features/get_the_app/`](lib/features/get_the_app/)).

### Android signing

Android only installs an update over an existing app when both are signed with the same key. Create one key per app, keep it outside the repository, and never commit it (`*.jks`, `*.keystore` and `key.properties` are git-ignored).

```bash
keytool -genkeypair -v -keystore ~/luna-release.jks -storetype PKCS12 \
  -keyalg RSA -keysize 4096 -validity 10000 -alias luna
base64 -i ~/luna-release.jks | pbcopy   # macOS; Linux: base64 -w0 …
```

Add four repository secrets under *Settings → Secrets and variables → Actions*: `ANDROID_KEYSTORE_BASE64` (the base64 text), `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS` (`luna`) and `ANDROID_KEY_PASSWORD` (same password for PKCS12). Set all four or none.

To sign local release builds too, create `android/key.properties` with `storeFile`, `storePassword`, `keyAlias` and `keyPassword`.
