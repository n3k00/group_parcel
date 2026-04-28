import 'package:flutter_test/flutter_test.dart';
import 'package:group_mobile/core/services/printer_observer_service.dart';
import 'package:pos_printer_kit/pos_printer_kit.dart';

void main() {
  test('printer observer keeps only the latest logs', () {
    final service = PrinterObserverService(maxLogs: 2);

    service.recordLog('first');
    service.recordLog('second');
    service.recordLog('third');

    expect(service.snapshot.logs, ['second', 'third']);
  });

  test('printer observer starts with idle snapshot', () {
    final service = PrinterObserverService();

    expect(service.snapshot.connectionState.stage, PrinterConnectionStage.idle);
    expect(service.snapshot.printProgress, isNull);
    expect(service.snapshot.latestError, isNull);
  });
}
