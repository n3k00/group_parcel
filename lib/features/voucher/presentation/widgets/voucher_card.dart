import 'package:flutter/material.dart';

import '../../../../core/constants/receipt_strings.dart';
import '../../../../core/constants/voucher_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/parcel.dart';
import '../../../../shared/models/app_setup_config.dart';
import 'voucher_qr_view.dart';

class VoucherCard extends StatelessWidget {
  const VoucherCard({
    super.key,
    required this.parcel,
    required this.qrPayload,
    required this.setup,
    this.isPrintable = false,
  });

  final ParcelModel parcel;
  final String qrPayload;
  final AppSetupConfig setup;
  final bool isPrintable;

  @override
  Widget build(BuildContext context) {
    final width = isPrintable
        ? VoucherLayout.printableWidth.toDouble()
        : VoucherLayout.previewPaperWidth;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          vertical: BorderSide(color: AppColors.divider),
        ),
        boxShadow: isPrintable
            ? null
            : const [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          isPrintable ? setup.receiptPaddingLeft : 14,
          isPrintable ? setup.receiptPaddingTop : 14,
          isPrintable ? setup.receiptPaddingRight : 14,
          isPrintable ? setup.receiptPaddingBottom : 18,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ReceiptHeader(setup: setup, isPrintable: isPrintable),
            SizedBox(height: isPrintable ? 14 : 12),
            const _DashedDivider(),
            SizedBox(height: isPrintable ? 14 : 12),
            _MetaRow(
              label: ReceiptStrings.trackingIdLabel,
              value: parcel.trackingId,
              setup: setup,
              isPrintable: isPrintable,
            ),
            SizedBox(height: isPrintable ? 14 : 10),
            _MetaRow(
              label: ReceiptStrings.createdAtLabel,
              value: _formatDateTime(parcel.createdAt),
              setup: setup,
              isPrintable: isPrintable,
            ),
            SizedBox(height: isPrintable ? 14 : 12),
            const _DashedDivider(),
            SizedBox(height: isPrintable ? 14 : 12),
            _TownRow(
              fromTown: parcel.fromTown,
              toTown: parcel.toTown,
              setup: setup,
              isPrintable: isPrintable,
            ),
            SizedBox(height: isPrintable ? 14 : 12),
            const _DashedDivider(),
            SizedBox(height: isPrintable ? 14 : 12),
            _PartyRow(
              leftLabel: ReceiptStrings.senderNameLabel,
              leftPrimary: parcel.senderName,
              leftSecondary: parcel.senderPhone,
              rightLabel: ReceiptStrings.receiverNameLabel,
              rightPrimary: parcel.receiverName,
              rightSecondary: parcel.receiverPhone,
              setup: setup,
              isPrintable: isPrintable,
            ),
            SizedBox(height: isPrintable ? 16 : 14),
            const _DashedDivider(),
            SizedBox(height: isPrintable ? 14 : 12),
            _LabelValueRow(
              label: ReceiptStrings.parcelTypeLabel,
              value: parcel.parcelType,
              setup: setup,
              isPrintable: isPrintable,
            ),
            SizedBox(height: isPrintable ? 16 : 10),
            _LabelValueRow(
              label: ReceiptStrings.parcelCountLabel,
              value: parcel.numberOfParcels.toString(),
              setup: setup,
              isPrintable: isPrintable,
            ),
            SizedBox(height: isPrintable ? 16 : 14),
            const _DashedDivider(),
            SizedBox(height: isPrintable ? 14 : 12),
            _LabelValueRow(
              label: ReceiptStrings.totalChargesLabel,
              value: _formatAmount(parcel.totalCharges),
              setup: setup,
              isPrintable: isPrintable,
            ),
            SizedBox(height: isPrintable ? 16 : 10),
            _LabelValueRow(
              label: ReceiptStrings.paymentStatusLabel,
              value: parcel.paymentStatus.receiptLabel,
              setup: setup,
              isPrintable: isPrintable,
            ),
            SizedBox(height: isPrintable ? 16 : 10),
            _LabelValueRow(
              label: ReceiptStrings.cashAdvanceLabel,
              value: _formatAmount(parcel.cashAdvance),
              setup: setup,
              isPrintable: isPrintable,
            ),
            if ((parcel.remark ?? '').trim().isNotEmpty) ...[
              SizedBox(height: isPrintable ? 16 : 10),
              _LabelValueRow(
                label: ReceiptStrings.remarkLabel,
                value: parcel.remark!.trim(),
                setup: setup,
                isPrintable: isPrintable,
              ),
            ],
            SizedBox(height: isPrintable ? 18 : 14),
            const _DashedDivider(),
            SizedBox(height: isPrintable ? 18 : 14),
            Center(
              child: VoucherQrView(
                payload: qrPayload,
                size: isPrintable ? 148 : 116,
              ),
            ),
            SizedBox(height: isPrintable ? 18 : 12),
            Text(
              (setup.footerMessage ?? '').trim().isEmpty
                  ? ReceiptStrings.thankYou
                  : setup.footerMessage!.trim(),
              textAlign: TextAlign.center,
              style: _ReceiptStyles.footer(isPrintable),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(double value) {
    return value.truncateToDouble() == value
        ? value.toStringAsFixed(1)
        : value.toStringAsFixed(2);
  }

  String _formatDateTime(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final year = value.year.toString();
    final hour = value.hour == 0
        ? 12
        : (value.hour > 12 ? value.hour - 12 : value.hour);
    final minute = value.minute.toString().padLeft(2, '0');
    final period = value.hour >= 12 ? 'PM' : 'AM';
    return '$day-$month-$year ${hour.toString().padLeft(2, '0')}:$minute $period';
  }
}

class _ReceiptHeader extends StatelessWidget {
  const _ReceiptHeader({required this.setup, required this.isPrintable});

  final AppSetupConfig setup;
  final bool isPrintable;

  @override
  Widget build(BuildContext context) {
    final subtitle = setup.businessSubtitle.trim();
    final address = setup.businessAddress.trim();
    final phone = setup.businessPhone.trim();

    return Column(
      children: [
        Text(
          setup.businessName,
          textAlign: TextAlign.center,
          style: _ReceiptStyles.businessName(setup, isPrintable),
        ),
        if (subtitle.isNotEmpty) ...[
          SizedBox(height: isPrintable ? 12 : 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: _ReceiptStyles.subtitle(setup, isPrintable),
          ),
        ],
        if (address.isNotEmpty) ...[
          SizedBox(height: isPrintable ? 20 : 16),
          Text(
            address,
            textAlign: TextAlign.center,
            style: _ReceiptStyles.address(setup, isPrintable),
          ),
        ],
        if (phone.isNotEmpty) ...[
          SizedBox(height: isPrintable ? 14 : 10),
          Text(
            phone,
            textAlign: TextAlign.center,
            style: _ReceiptStyles.phone(setup, isPrintable),
          ),
        ],
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.label,
    required this.value,
    required this.setup,
    required this.isPrintable,
  });

  final String label;
  final String value;
  final AppSetupConfig setup;
  final bool isPrintable;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: _ReceiptStyles.label(setup, isPrintable)),
        ),
        SizedBox(width: isPrintable ? 16 : 12),
        Expanded(
          flex: 3,
          child: Text(value, style: _ReceiptStyles.value(setup, isPrintable)),
        ),
      ],
    );
  }
}

class _LabelValueRow extends StatelessWidget {
  const _LabelValueRow({
    required this.label,
    required this.value,
    required this.setup,
    required this.isPrintable,
  });

  final String label;
  final String value;
  final AppSetupConfig setup;
  final bool isPrintable;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: _ReceiptStyles.label(setup, isPrintable)),
        ),
        SizedBox(width: isPrintable ? 16 : 12),
        Expanded(
          flex: 3,
          child: Text(value, style: _ReceiptStyles.value(setup, isPrintable)),
        ),
      ],
    );
  }
}

class _TownRow extends StatelessWidget {
  const _TownRow({
    required this.fromTown,
    required this.toTown,
    required this.setup,
    required this.isPrintable,
  });

  final String fromTown;
  final String toTown;
  final AppSetupConfig setup;
  final bool isPrintable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LabelValueRow(
          label: ReceiptStrings.fromTownLabel,
          value: fromTown,
          setup: setup,
          isPrintable: isPrintable,
        ),
        SizedBox(height: isPrintable ? 10 : 8),
        _LabelValueRow(
          label: ReceiptStrings.toTownLabel,
          value: toTown,
          setup: setup,
          isPrintable: isPrintable,
        ),
      ],
    );
  }
}

class _PartyRow extends StatelessWidget {
  const _PartyRow({
    required this.leftLabel,
    required this.leftPrimary,
    required this.leftSecondary,
    required this.rightLabel,
    required this.rightPrimary,
    required this.rightSecondary,
    required this.setup,
    required this.isPrintable,
  });

  final String leftLabel;
  final String leftPrimary;
  final String leftSecondary;
  final String rightLabel;
  final String rightPrimary;
  final String rightSecondary;
  final AppSetupConfig setup;
  final bool isPrintable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LabelValueRow(
          label: leftLabel,
          value: leftPrimary,
          setup: setup,
          isPrintable: isPrintable,
        ),
        SizedBox(height: isPrintable ? 10 : 8),
        _LabelValueRow(
          label: '',
          value: leftSecondary,
          setup: setup,
          isPrintable: isPrintable,
        ),
        SizedBox(height: isPrintable ? 14 : 10),
        _LabelValueRow(
          label: rightLabel,
          value: rightPrimary,
          setup: setup,
          isPrintable: isPrintable,
        ),
        SizedBox(height: isPrintable ? 10 : 8),
        _LabelValueRow(
          label: '',
          value: rightSecondary,
          setup: setup,
          isPrintable: isPrintable,
        ),
      ],
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 12.0;
        const gapWidth = 3.0;
        final count = constraints.maxWidth <= 0
            ? 0
            : (constraints.maxWidth / (dashWidth + gapWidth)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => const SizedBox(
              width: dashWidth,
              child: Divider(height: 1, thickness: 2.4, color: Colors.black87),
            ),
          ),
        );
      },
    );
  }
}

class _ReceiptStyles {
  const _ReceiptStyles._();

  static TextStyle businessName(AppSetupConfig setup, bool isPrintable) =>
      TextStyle(
        fontSize: _scale(setup.businessNameFontSize, isPrintable, 1.28),
        fontWeight: FontWeight.w700,
        height: 1.08,
        color: Colors.black,
      );

  static TextStyle address(AppSetupConfig setup, bool isPrintable) => TextStyle(
    fontSize: _scale(setup.businessAddressFontSize, isPrintable, 1.08),
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: Colors.black,
  );

  static TextStyle subtitle(AppSetupConfig setup, bool isPrintable) =>
      TextStyle(
        fontSize: _scale(setup.businessSubtitleFontSize, isPrintable, 1.08),
        fontWeight: FontWeight.w600,
        height: 1.18,
        color: Colors.black,
      );

  static TextStyle phone(AppSetupConfig setup, bool isPrintable) => TextStyle(
    fontSize: _scale(setup.businessPhoneFontSize, isPrintable, 1.18),
    fontWeight: FontWeight.w600,
    height: 1.15,
    color: Colors.black,
  );

  static TextStyle label(AppSetupConfig setup, bool isPrintable) => TextStyle(
    fontSize: isPrintable ? setup.receiptLabelFontSize : 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: Colors.black,
  );

  static TextStyle value(AppSetupConfig setup, bool isPrintable) => TextStyle(
    fontSize: isPrintable ? setup.receiptValueFontSize : 16,
    fontWeight: FontWeight.w500,
    height: 1.28,
    color: Colors.black,
  );

  static TextStyle footer(bool isPrintable) => TextStyle(
    fontSize: isPrintable ? 22 : 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: Colors.black,
  );

  static double _scale(double value, bool isPrintable, double factor) {
    return isPrintable ? value * factor : value;
  }
}
