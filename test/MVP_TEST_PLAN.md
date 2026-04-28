# TKT Parcel MVP Test Plan

This plan keeps automation practical for a solo Flutter developer. Pure logic, Drift persistence, and Riverpod-driven UI states should be automated first. Bluetooth and physical thermal printing should be validated with real-device manual QA.

## Test Matrix

| Scenario | Test Type | Placement | Expected Result |
| --- | --- | --- | --- |
| Parcel create with valid data | Unit test + integration test | `test/data/local/parcel_repository_test.dart`, `integration_test/offline_manual_qa.md` | Parcel saves locally with `received`, `pending`, `syncedAt = null`, and can be reopened later |
| Reject invalid form input | Widget test | `test/features/parcel/presentation/create_parcel_screen_test.dart` | Empty required fields or invalid combinations block preview/save and show validation message |
| Tracking ID generation | Unit test | `test/features/parcel/services/tracking_id_service_test.dart` | Format matches `[CityCode]-[AccountCode]-[YYMMDD]-[RunningNumber]` |
| Running number increment | Unit test | `test/features/parcel/services/tracking_id_service_test.dart` | Same-day next parcel uses incremented serial |
| Running number reset on new day | Unit test | `test/features/parcel/services/tracking_id_service_test.dart` | New date starts again at `0001` |
| SQLite insert | Unit test | `test/data/local/parcel_repository_test.dart` | New parcel row is saved and fetchable |
| SQLite update | Unit test | `test/data/local/parcel_repository_test.dart` | Edited parcel persists and `updatedAt` moves forward |
| SQLite fetch by trackingId | Unit test | `test/data/local/parcel_repository_test.dart` | Correct row is returned for an existing tracking ID |
| Parcel list load | Widget test | `test/features/parcel/presentation/parcel_list_screen_test.dart` | Local parcels render newest-first in operational list UI |
| Voucher preview render | Widget test | `test/features/voucher/presentation/voucher_card_test.dart` | Voucher shows business info, parcel data, QR area, and footer text |
| Printer connection | Widget test + manual device test | `test/widget_test.dart`, `integration_test/printer_manual_qa.md` | UI reflects connected/disconnected state; real printer can connect from plugin flow |
| Print voucher | Manual device test | `integration_test/printer_manual_qa.md` | Printable voucher image is sent with `printImage(...)` and prints successfully |
| Reprint | Widget test + manual device test | `test/features/printer/printer_preview_actions_test.dart`, `integration_test/printer_manual_qa.md` | Retry/reprint actions appear when printable bytes exist and work on real printer |
| Image attach | Unit test + manual device test | `test/data/models/parcel_model_test.dart`, `integration_test/offline_manual_qa.md` | Selected image path is stored locally in `parcelImagePath` |
| Offline create and reopen app | Integration test + manual device test | `integration_test/offline_manual_qa.md` | Saved parcel remains visible after app restart without internet |

## Automation Boundaries

- Mock or fake:
  - Riverpod provider outputs
  - `PrinterState` for widget-state tests
  - In-memory Drift database
  - Tracking ID input values (`cityCode`, `accountCode`, `runningNumber`, `date`)
- Use a real device:
  - Bluetooth on/off handling
  - Actual printer connect flow
  - Real `printImage(...)` result
  - Myanmar text print quality
  - App restart persistence verification on Android build

## Recommended Next Automated Tests

1. `test/features/parcel/presentation/create_parcel_screen_test.dart`
2. `test/features/printer/printer_preview_actions_test.dart`
3. `test/data/models/parcel_model_test.dart`
4. `integration_test/offline_create_reopen_test.dart` with a controlled Android emulator path if needed
