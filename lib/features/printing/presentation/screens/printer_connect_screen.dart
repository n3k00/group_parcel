import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_printer_kit/pos_printer_kit.dart';

import '../../../../providers/printer_provider.dart';

class PrinterConnectScreen extends ConsumerStatefulWidget {
  const PrinterConnectScreen({super.key});

  static const routeName = '/printing/connect';

  @override
  ConsumerState<PrinterConnectScreen> createState() =>
      _PrinterConnectScreenState();
}

class _PrinterConnectScreenState extends ConsumerState<PrinterConnectScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(printerCoreProvider).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final core = ref.watch(printerCoreProvider);

    return PrinterConnectPage(
      core: core,
    );
  }
}
