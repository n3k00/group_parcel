import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_mobile/core/constants/receipt_strings.dart';
import 'package:group_mobile/core/theme/app_theme.dart';
import 'package:group_mobile/data/models/enums/payment_status.dart';
import 'package:group_mobile/data/models/parcel.dart';
import 'package:group_mobile/features/voucher/presentation/widgets/voucher_card.dart';
import 'package:group_mobile/shared/models/app_setup_config.dart';

void main() {
  testWidgets('renders receipt preview with key voucher details', (
    tester,
  ) async {
    final parcel = ParcelModel.create(
      trackingId: 'TGI-A1-250317-0001',
      fromTown: 'Taunggyi',
      toTown: 'Kalaw',
      cityCode: 'TGI',
      accountCode: 'A1',
      senderName: 'Ko Aung',
      senderPhone: '0912345678',
      receiverName: 'Ma Su',
      receiverPhone: '0998765432',
      ledgerId: 'LEDGER-001',
      parcelType: 'General',
      numberOfParcels: 2,
      totalCharges: 12000,
      paymentStatus: PaymentStatus.paid,
      remark: 'Fragile',
      now: DateTime(2025, 3, 17, 9, 30),
    );
    const setup = AppSetupConfig(
      cityCode: 'TGI',
      accountCode: 'A1',
      businessName: 'Group',
      businessSubtitle: ReceiptStrings.defaultBusinessSubtitle,
      businessAddress: ReceiptStrings.defaultBusinessAddress,
      businessPhone: '09-000-000000',
      businessNameFontSize: 26,
      businessSubtitleFontSize: 16,
      businessAddressFontSize: 16,
      businessPhoneFontSize: 15,
      receiptLabelFontSize: 21,
      receiptValueFontSize: 22,
      receiptPaddingTop: 18,
      receiptPaddingLeft: 2,
      receiptPaddingRight: 2,
      receiptPaddingBottom: 24,
      footerMessage: 'Handle with care',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: SingleChildScrollView(
            child: VoucherCard(
              parcel: parcel,
              qrPayload: 'TGI-A1-250317-0001',
              setup: setup,
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Group'), findsOneWidget);
    expect(find.text(ReceiptStrings.defaultBusinessSubtitle), findsOneWidget);
    expect(find.text(ReceiptStrings.trackingIdLabel), findsOneWidget);
    expect(find.text('TGI-A1-250317-0001'), findsOneWidget);
    expect(find.text(ReceiptStrings.remarkLabel), findsOneWidget);
    expect(find.text('Fragile'), findsOneWidget);
    expect(find.text(ReceiptStrings.totalChargesLabel), findsOneWidget);
    expect(find.text(ReceiptStrings.ledgerIdLabel), findsNothing);
    expect(find.text('LEDGER-001'), findsNothing);
    expect(find.text('Handle with care'), findsOneWidget);
  });
}
