import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VoucherQrView extends StatelessWidget {
  const VoucherQrView({super.key, required this.payload, this.size = 120});

  final String payload;
  final double size;

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: payload,
      size: size,
      backgroundColor: Colors.white,
    );
  }
}
