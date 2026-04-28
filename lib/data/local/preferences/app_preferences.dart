import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences(this._preferences);

  static const _cityCodeKey = 'setup_city_code';
  static const _accountCodeKey = 'setup_account_code';
  static const _defaultSourceTownNameKey = 'default_source_town_name';
  static const _businessNameKey = 'business_name';
  static const _businessSubtitleKey = 'business_subtitle';
  static const _businessAddressKey = 'business_address';
  static const _businessPhoneKey = 'business_phone';
  static const _businessNameFontSizeKey = 'business_name_font_size';
  static const _businessSubtitleFontSizeKey = 'business_subtitle_font_size';
  static const _businessAddressFontSizeKey = 'business_address_font_size';
  static const _businessPhoneFontSizeKey = 'business_phone_font_size';
  static const _receiptLabelFontSizeKey = 'receipt_label_font_size';
  static const _receiptValueFontSizeKey = 'receipt_value_font_size';
  static const _receiptPaddingTopKey = 'receipt_padding_top';
  static const _receiptPaddingLeftKey = 'receipt_padding_left';
  static const _receiptPaddingRightKey = 'receipt_padding_right';
  static const _receiptPaddingBottomKey = 'receipt_padding_bottom';
  static const _footerMessageKey = 'voucher_footer_message';
  static const _printerPresetKey = 'printer_preset';
  static const _subtitleMigrationDoneKey =
      'deprecated_business_subtitle_migration_done';

  final SharedPreferences _preferences;

  static Future<AppPreferences> create() async {
    final preferences = await SharedPreferences.getInstance();
    return AppPreferences(preferences);
  }

  String? getCityCode() => _preferences.getString(_cityCodeKey);

  String? getAccountCode() => _preferences.getString(_accountCodeKey);

  String? getDefaultSourceTownName() =>
      _preferences.getString(_defaultSourceTownNameKey);

  Future<bool> setCityCode(String value) {
    return _preferences.setString(_cityCodeKey, value);
  }

  Future<bool> setAccountCode(String value) {
    return _preferences.setString(_accountCodeKey, value);
  }

  Future<bool> setDefaultSourceTownName(String value) {
    return _preferences.setString(_defaultSourceTownNameKey, value);
  }

  String? getBusinessName() => _preferences.getString(_businessNameKey);

  String? getBusinessSubtitle() => _preferences.getString(_businessSubtitleKey);

  String? getBusinessAddress() => _preferences.getString(_businessAddressKey);

  String? getBusinessPhone() => _preferences.getString(_businessPhoneKey);

  double? getBusinessNameFontSize() {
    return _preferences.getDouble(_businessNameFontSizeKey);
  }

  double? getBusinessSubtitleFontSize() {
    return _preferences.getDouble(_businessSubtitleFontSizeKey);
  }

  double? getBusinessPhoneFontSize() {
    return _preferences.getDouble(_businessPhoneFontSizeKey);
  }

  double? getBusinessAddressFontSize() {
    return _preferences.getDouble(_businessAddressFontSizeKey);
  }

  double? getReceiptLabelFontSize() {
    return _preferences.getDouble(_receiptLabelFontSizeKey);
  }

  double? getReceiptValueFontSize() {
    return _preferences.getDouble(_receiptValueFontSizeKey);
  }

  double? getReceiptPaddingTop() {
    return _preferences.getDouble(_receiptPaddingTopKey);
  }

  double? getReceiptPaddingLeft() {
    return _preferences.getDouble(_receiptPaddingLeftKey);
  }

  double? getReceiptPaddingRight() {
    return _preferences.getDouble(_receiptPaddingRightKey);
  }

  double? getReceiptPaddingBottom() {
    return _preferences.getDouble(_receiptPaddingBottomKey);
  }

  String? getFooterMessage() => _preferences.getString(_footerMessageKey);

  String? getPrinterPreset() => _preferences.getString(_printerPresetKey);

  bool getIsSubtitleMigrationDone() =>
      _preferences.getBool(_subtitleMigrationDoneKey) ?? false;

  Future<bool> setBusinessName(String value) {
    return _preferences.setString(_businessNameKey, value);
  }

  Future<bool> setBusinessSubtitle(String value) {
    return _preferences.setString(_businessSubtitleKey, value);
  }

  Future<bool> setBusinessAddress(String value) {
    return _preferences.setString(_businessAddressKey, value);
  }

  Future<bool> setBusinessPhone(String value) {
    return _preferences.setString(_businessPhoneKey, value);
  }

  Future<bool> setBusinessNameFontSize(double value) {
    return _preferences.setDouble(_businessNameFontSizeKey, value);
  }

  Future<bool> setBusinessSubtitleFontSize(double value) {
    return _preferences.setDouble(_businessSubtitleFontSizeKey, value);
  }

  Future<bool> setBusinessPhoneFontSize(double value) {
    return _preferences.setDouble(_businessPhoneFontSizeKey, value);
  }

  Future<bool> setBusinessAddressFontSize(double value) {
    return _preferences.setDouble(_businessAddressFontSizeKey, value);
  }

  Future<bool> setReceiptLabelFontSize(double value) {
    return _preferences.setDouble(_receiptLabelFontSizeKey, value);
  }

  Future<bool> setReceiptValueFontSize(double value) {
    return _preferences.setDouble(_receiptValueFontSizeKey, value);
  }

  Future<bool> setReceiptPaddingTop(double value) {
    return _preferences.setDouble(_receiptPaddingTopKey, value);
  }

  Future<bool> setReceiptPaddingLeft(double value) {
    return _preferences.setDouble(_receiptPaddingLeftKey, value);
  }

  Future<bool> setReceiptPaddingRight(double value) {
    return _preferences.setDouble(_receiptPaddingRightKey, value);
  }

  Future<bool> setReceiptPaddingBottom(double value) {
    return _preferences.setDouble(_receiptPaddingBottomKey, value);
  }

  Future<bool> setFooterMessage(String value) {
    return _preferences.setString(_footerMessageKey, value);
  }

  Future<bool> setPrinterPreset(String value) {
    return _preferences.setString(_printerPresetKey, value);
  }

  Future<bool> removeBusinessSubtitle() {
    return _preferences.remove(_businessSubtitleKey);
  }

  Future<bool> removeBusinessSubtitleFontSize() {
    return _preferences.remove(_businessSubtitleFontSizeKey);
  }

  Future<bool> setIsSubtitleMigrationDone(bool value) {
    return _preferences.setBool(_subtitleMigrationDoneKey, value);
  }
}
