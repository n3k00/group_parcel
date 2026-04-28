class AppSetupConfig {
  const AppSetupConfig({
    required this.cityCode,
    required this.accountCode,
    required this.businessName,
    required this.businessSubtitle,
    required this.businessAddress,
    required this.businessPhone,
    required this.businessNameFontSize,
    required this.businessSubtitleFontSize,
    required this.businessAddressFontSize,
    required this.businessPhoneFontSize,
    required this.receiptLabelFontSize,
    required this.receiptValueFontSize,
    required this.receiptPaddingTop,
    required this.receiptPaddingLeft,
    required this.receiptPaddingRight,
    required this.receiptPaddingBottom,
    this.footerMessage,
  });

  final String cityCode;
  final String accountCode;
  final String businessName;
  final String businessSubtitle;
  final String businessAddress;
  final String businessPhone;
  final double businessNameFontSize;
  final double businessSubtitleFontSize;
  final double businessAddressFontSize;
  final double businessPhoneFontSize;
  final double receiptLabelFontSize;
  final double receiptValueFontSize;
  final double receiptPaddingTop;
  final double receiptPaddingLeft;
  final double receiptPaddingRight;
  final double receiptPaddingBottom;
  final String? footerMessage;

  AppSetupConfig copyWith({
    String? cityCode,
    String? accountCode,
    String? businessName,
    String? businessSubtitle,
    String? businessAddress,
    String? businessPhone,
    double? businessNameFontSize,
    double? businessSubtitleFontSize,
    double? businessAddressFontSize,
    double? businessPhoneFontSize,
    double? receiptLabelFontSize,
    double? receiptValueFontSize,
    double? receiptPaddingTop,
    double? receiptPaddingLeft,
    double? receiptPaddingRight,
    double? receiptPaddingBottom,
    String? footerMessage,
    bool clearFooterMessage = false,
  }) {
    return AppSetupConfig(
      cityCode: cityCode ?? this.cityCode,
      accountCode: accountCode ?? this.accountCode,
      businessName: businessName ?? this.businessName,
      businessSubtitle: businessSubtitle ?? this.businessSubtitle,
      businessAddress: businessAddress ?? this.businessAddress,
      businessPhone: businessPhone ?? this.businessPhone,
      businessNameFontSize: businessNameFontSize ?? this.businessNameFontSize,
      businessSubtitleFontSize:
          businessSubtitleFontSize ?? this.businessSubtitleFontSize,
      businessAddressFontSize:
          businessAddressFontSize ?? this.businessAddressFontSize,
      businessPhoneFontSize:
          businessPhoneFontSize ?? this.businessPhoneFontSize,
      receiptLabelFontSize: receiptLabelFontSize ?? this.receiptLabelFontSize,
      receiptValueFontSize: receiptValueFontSize ?? this.receiptValueFontSize,
      receiptPaddingTop: receiptPaddingTop ?? this.receiptPaddingTop,
      receiptPaddingLeft: receiptPaddingLeft ?? this.receiptPaddingLeft,
      receiptPaddingRight: receiptPaddingRight ?? this.receiptPaddingRight,
      receiptPaddingBottom:
          receiptPaddingBottom ?? this.receiptPaddingBottom,
      footerMessage:
          clearFooterMessage ? null : footerMessage ?? this.footerMessage,
    );
  }
}
