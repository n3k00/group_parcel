# TKT Parcel Printer Test Plan

## Strategy Summary

- Unit tests: small deterministic logic such as observer/log buffering and print config defaults.
- Widget tests: Riverpod-driven UI states like Bluetooth icon state, navigation to connect page, retry/reprint button visibility.
- Integration tests: app-level preview to print flow with fake providers where Bluetooth hardware is not required.
- Manual device tests: real Bluetooth and real thermal printer behavior.

## Coverage Matrix

| Case | Recommended Type | Mocked / Real | Expected Result |
| --- | --- | --- | --- |
| Bluetooth off error | Manual device test + optional integration smoke | Real device | User sees Bluetooth-off failure message and cannot print until Bluetooth is enabled. |
| No connected printer | Widget test | Mocked provider state | Preview or print action routes user to connect flow or shows a connect prompt. |
| Successful connect | Manual device test | Real device | Connect page shows connected state and Home screen icon updates after returning. |
| Successful `printImage(...)` | Manual device test + integration smoke | Real printer for final validation | Voucher image prints successfully and app shows success feedback. |
| Disconnected during print | Manual device test | Real printer | App reports failure, exposes latest error, and keeps retry action available. |
| Retry after failure | Widget test + manual device test | Mocked state for UI, real device for final validation | Retry button is shown after failure and user can print again. |
| Reprint | Widget test + manual device test | Mocked state for UI, real device for final validation | Last voucher image can be sent again without rebuilding the voucher. |
| Myanmar text image print | Manual device test | Real printer | Myanmar text remains readable because image-based print path is used. |

## UI States To Assert In Widget Tests

- Bluetooth icon disconnected state
- Bluetooth icon connected state
- Navigation to printer connect page
- Retry button visible only when there is a failed print with cached image bytes
- Reprint button visible when previous printable image bytes exist
- Printer status summary shows current connection stage / latest error text

## Riverpod Test Setup

- Override `parcelListProvider` with a simple `Stream.value(...)`
- Override `printerStateProvider` with a fake notifier returning deterministic `PrinterState`
- For widget tests, do not instantiate real `PrinterCore`
- For manual tests, use production providers unchanged

## Mocking / Faking Guidance

- Mocked / faked:
  - `PrinterState`
  - Riverpod notifier outputs for widget tests
  - image bytes presence for retry/reprint UI states
- Real hardware required:
  - Bluetooth on/off behavior
  - connect success
  - disconnect during print
  - actual `printImage(...)` output
  - Myanmar text print quality
