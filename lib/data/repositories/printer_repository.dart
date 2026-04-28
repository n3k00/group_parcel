import 'dart:typed_data';

import 'package:pos_printer_kit/pos_printer_kit.dart';

import '../../core/services/printer_service.dart';

class PrinterRepository {
  PrinterRepository(this._service);

  final PrinterService _service;

  PrinterCore get core => _service.core;

  Future<void> startScan() => _service.startScan();

  Future<void> stopScan() => _service.stopScan();

  Future<void> connect(PrinterDevice device) => _service.connect(device);

  Future<void> disconnect() => _service.disconnect();

  Future<bool> printImage(
    Uint8List imageBytes, {
    PrinterPrintConfig config = const PrinterPrintConfig(),
  }) {
    return _service.printImage(imageBytes, config: config);
  }

  Future<bool> testPrint() => _service.testPrint();

  bool get isConnected => _service.hasConnectedPrinter;
}
