import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_printer_kit/pos_printer_kit.dart';

import '../constants/voucher_layout.dart';

class PrintService {
  const PrintService();

  PrinterPrintConfig defaultVoucherConfig({
    int copies = 1,
    int width = VoucherLayout.printableWidth,
  }) {
    return PrinterPrintConfig.label(width: width, copies: copies);
  }

  Future<Uint8List> captureWidgetAsPng(
    GlobalKey boundaryKey, {
    double pixelRatio = 2.2,
  }) async {
    final context = boundaryKey.currentContext;
    if (context == null) {
      throw StateError('Printable voucher is not ready yet.');
    }

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderRepaintBoundary) {
      throw StateError('Printable voucher boundary was not found.');
    }

    final image = await renderObject.toImage(pixelRatio: pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw StateError('Could not render voucher image.');
    }

    return byteData.buffer.asUint8List();
  }
}
