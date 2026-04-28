import 'dart:typed_data';

import 'package:pos_printer_kit/pos_printer_kit.dart';

class PrinterService {
  PrinterService(this.core);

  final PrinterCore core;

  Stream<PrinterConnectionState> get onStateChanged => core.onStateChanged;

  Stream<PrinterPrintProgress> get onPrintProgress => core.onPrintProgress;

  Stream<PrinterOperationException> get onError => core.onError;

  Future<void> startScan() => core.startScan();

  Future<void> stopScan() => core.stopScan();

  Future<void> connect(PrinterDevice device) => core.connect(device);

  Future<void> disconnect() => core.disconnect();

  Future<bool> printImage(
    Uint8List imageBytes, {
    PrinterPrintConfig config = const PrinterPrintConfig(),
  }) {
    return core.printImage(imageBytes, config: config);
  }

  Future<bool> testPrint() => core.printDemoImage();

  bool get hasConnectedPrinter => core.hasConnectedPrinter;
}
