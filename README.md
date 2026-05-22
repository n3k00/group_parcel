# Group

Offline-first Flutter Android app scaffolded from the production architecture of `TKT Parcel` and rebranded for `Group`.

## Current Architecture

- `app/`: application bootstrap and route generation
- `core/`: config, constants, theme, layout, services, and low-level helpers
- `data/`: Drift database, DAOs, mappers, models, repositories, and preferences
- `features/`: parcel-style business flows, voucher preview, printing, sync, and settings
- `shared/`: reusable widgets and shared app models
- `test/`: repository, provider, and widget coverage for core offline flows

## Core Entities And Tables

- `ParcelModel`: the current core business record used for create, list, detail, preview, save, and reprint
- `TownModel`: source and destination town master data
- `AppSetupConfig`: lightweight settings persisted with `SharedPreferences`
- Drift tables:
  - `parcels`
  - `parcel_events`
  - `towns`

## Critical Flows

- create parcel -> validate form -> build preview snapshot -> save exact preview payload -> print/reprint
- watch parcel list from Drift -> search/filter locally -> open detail/reprint
- manage receipt and business settings -> persist through `SharedPreferences` -> immediately affect preview/printing behavior
- full backup -> bundle SQLite database and local parcel images -> restore for full local recovery

## Product Risks / Open Decisions

- The app is fully rebranded as `Group`, but the core business entity is still parcel-oriented because the new domain record schema was not specified.
- If `Group` should not use parcel fields, the next iteration should rename the domain objects and adjust the Drift schema before production data exists.
- Bluetooth printer support remains parcel-style. If `Group` needs Android system printing or PDF output instead, the printing layer should be changed explicitly.

## Run

### Dev

```powershell
flutter run --flavor dev -t lib/main_dev.dart
```

### Prod

```powershell
flutter run --flavor prod -t lib/main_prod.dart
```

## Build

### Dev APK

```powershell
flutter build apk --debug --flavor dev -t lib/main_dev.dart
```

### Prod APK

```powershell
flutter build apk --release --flavor prod -t lib/main_prod.dart
```

## Release Signing

1. Create a release keystore:

```powershell
keytool -genkeypair -v -keystore keystores\\group-release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias grouprelease
```

2. Copy [key.properties.example](/C:/projects/group/group_mobile/android/key.properties.example) to `android/key.properties`

3. Fill in the real signing values:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=grouprelease
storeFile=../../keystores/group-release.jks
```

4. Keep `android/key.properties` and the keystore file private. Release builds fall back to debug signing when the file is missing.

## Verification

```powershell
flutter analyze
flutter test
```

## Firestore Rules

This project includes a locked-down Firestore rules file:

- [firestore.rules](/C:/projects/group/group_mobile/firestore.rules)
- [firebase.json](/C:/projects/group/group_mobile/firebase.json)

Current policy:

- authenticated users can read/write `parcels`
- authenticated users can read/write `users`
- everything else is denied by default

This matches the current product decision:

- every signed-in user can see all synced parcel data
- public unauthenticated access is blocked
- disabled-user strategy will be handled in a later phase

### Deploy Rules

```powershell
firebase login
firebase use <your-firebase-project-id>
firebase deploy --only firestore:rules
```
