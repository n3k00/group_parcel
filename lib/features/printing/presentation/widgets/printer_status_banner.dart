import 'package:flutter/material.dart';

class PrinterStatusBanner extends StatelessWidget {
  const PrinterStatusBanner({super.key, required this.connected});

  final bool connected;

  @override
  Widget build(BuildContext context) {
    return Text(connected ? 'Printer connected' : 'Printer disconnected');
  }
}
