import '../../data/models/enums/payment_status.dart';

abstract final class ReceiptStrings {
  static const defaultBusinessName = 'Group';
  static const defaultBusinessSubtitle = 'ကုန်စည်ပို့ဆောင်ရေး';
  static const defaultBusinessAddress = 'Offline-first Android operations';
  static const defaultBusinessPhone = '';
  static const defaultFooter = '';
  static const thankYou = 'ကျေးဇူးတင်ပါသည်';

  static const trackingIdLabel = 'ဘောင်ချာနံပါတ်';
  static const createdAtLabel = 'အချိန်နှင့် ရက်စွဲ';
  static const fromTownLabel = 'လက်ခံသည့် မြို့';
  static const toTownLabel = 'ပို့မည့် မြို့';
  static const senderNameLabel = 'ပေးပို့သူအမည်';
  static const receiverNameLabel = 'လက်ခံသူအမည်';
  static const ledgerIdLabel = 'Ledger ID';
  static const parcelTypeLabel = 'အမျိုးအစား';
  static const parcelCountLabel = 'အရေအတွက်';
  static const totalChargesLabel = 'ပို့ဆောင်ခ';
  static const paymentStatusLabel = 'ငွေပေးချေမှု';
  static const cashAdvanceLabel = 'စိုက်ငွေ';
  static const remarkLabel = 'မှတ်ချက်';
  static const paidLabel = 'ငွေရှင်းပြီး';
  static const unpaidLabel = 'ငွေတောင်းရန်';

  static const sampleTrackingId = 'TGI-A1-260319-0003';
  static const sampleFromTown = 'တောင်ကြီး';
  static const sampleToTown = 'တာချီလိတ်';
  static const sampleSenderName = 'နန္ဒာလှ';
  static const sampleSenderPhone = '52388';
  static const sampleReceiverName = 'မအမာ';
  static const sampleReceiverPhone = '8368';
  static const sampleParcelType = 'အကြီး';
  static const sampleQrPayload = sampleTrackingId;
}

extension ReceiptPaymentStatusX on PaymentStatus {
  String get receiptLabel {
    switch (this) {
      case PaymentStatus.paid:
        return ReceiptStrings.paidLabel;
      case PaymentStatus.unpaid:
        return ReceiptStrings.unpaidLabel;
    }
  }
}
