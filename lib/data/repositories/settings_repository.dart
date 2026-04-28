import '../../core/constants/receipt_strings.dart';
import '../../shared/models/app_setup_config.dart';
import '../local/preferences/app_preferences.dart';

class SettingsRepository {
  SettingsRepository(this._preferences);

  static const _defaultCityCode = 'TGI';
  static const _defaultAccountCode = 'A1';
  static const _defaultBusinessName = ReceiptStrings.defaultBusinessName;
  static const _defaultBusinessSubtitle = ReceiptStrings.defaultBusinessSubtitle;
  static const _defaultBusinessAddress = ReceiptStrings.defaultBusinessAddress;
  static const _defaultBusinessPhone = ReceiptStrings.defaultBusinessPhone;
  static const _defaultBusinessNameFontSize = 60.0;
  static const _defaultBusinessSubtitleFontSize = 28.0;
  static const _defaultBusinessAddressFontSize = 22.0;
  static const _defaultBusinessPhoneFontSize = 20.0;
  static const _defaultReceiptLabelFontSize = 28.0;
  static const _defaultReceiptValueFontSize = 30.0;
  static const _defaultReceiptPaddingTop = 20.0;
  static const _defaultReceiptPaddingLeft = 24.0;
  static const _defaultReceiptPaddingRight = 24.0;
  static const _defaultReceiptPaddingBottom = 40.0;
  static const _defaultFooterMessage = ReceiptStrings.defaultFooter;
  static const _defaultPrinterPreset = 'balanced';

  final AppPreferences _preferences;

  Future<AppSetupConfig> getAppSetup() async {
    final cityCode = _preferences.getCityCode() ?? _defaultCityCode;
    final accountCode = _preferences.getAccountCode() ?? _defaultAccountCode;

    return AppSetupConfig(
      cityCode: cityCode.toUpperCase(),
      accountCode: accountCode.toUpperCase(),
      businessName: _preferences.getBusinessName() ?? _defaultBusinessName,
      businessSubtitle:
          _preferences.getBusinessSubtitle() ?? _defaultBusinessSubtitle,
      businessAddress:
          _preferences.getBusinessAddress() ?? _defaultBusinessAddress,
      businessPhone: _preferences.getBusinessPhone() ?? _defaultBusinessPhone,
      businessNameFontSize:
          _preferences.getBusinessNameFontSize() ?? _defaultBusinessNameFontSize,
      businessSubtitleFontSize:
          _preferences.getBusinessSubtitleFontSize() ??
          _defaultBusinessSubtitleFontSize,
      businessAddressFontSize:
          _preferences.getBusinessAddressFontSize() ??
          _defaultBusinessAddressFontSize,
      businessPhoneFontSize:
          _preferences.getBusinessPhoneFontSize() ??
          _defaultBusinessPhoneFontSize,
      receiptLabelFontSize:
          _preferences.getReceiptLabelFontSize() ?? _defaultReceiptLabelFontSize,
      receiptValueFontSize:
          _preferences.getReceiptValueFontSize() ?? _defaultReceiptValueFontSize,
      receiptPaddingTop:
          _preferences.getReceiptPaddingTop() ?? _defaultReceiptPaddingTop,
      receiptPaddingLeft:
          _preferences.getReceiptPaddingLeft() ?? _defaultReceiptPaddingLeft,
      receiptPaddingRight:
          _preferences.getReceiptPaddingRight() ?? _defaultReceiptPaddingRight,
      receiptPaddingBottom:
          _preferences.getReceiptPaddingBottom() ?? _defaultReceiptPaddingBottom,
      footerMessage: _preferences.getFooterMessage() ?? _defaultFooterMessage,
    );
  }

  Future<void> saveAppSetup(AppSetupConfig config) async {
    await _preferences.setCityCode(config.cityCode.toUpperCase());
    await _preferences.setAccountCode(config.accountCode.toUpperCase());
    await _preferences.setBusinessName(config.businessName.trim());
    await _preferences.setBusinessSubtitle(config.businessSubtitle.trim());
    await _preferences.setBusinessAddress(config.businessAddress.trim());
    await _preferences.setBusinessPhone(config.businessPhone.trim());
    await _preferences.setBusinessNameFontSize(config.businessNameFontSize);
    await _preferences.setBusinessSubtitleFontSize(
      config.businessSubtitleFontSize,
    );
    await _preferences.setBusinessAddressFontSize(config.businessAddressFontSize);
    await _preferences.setBusinessPhoneFontSize(config.businessPhoneFontSize);
    await _preferences.setReceiptLabelFontSize(config.receiptLabelFontSize);
    await _preferences.setReceiptValueFontSize(config.receiptValueFontSize);
    await _preferences.setReceiptPaddingTop(config.receiptPaddingTop);
    await _preferences.setReceiptPaddingLeft(config.receiptPaddingLeft);
    await _preferences.setReceiptPaddingRight(config.receiptPaddingRight);
    await _preferences.setReceiptPaddingBottom(config.receiptPaddingBottom);
    await _preferences.setFooterMessage((config.footerMessage ?? '').trim());
  }

  Future<String?> getDefaultSourceTownName() async {
    final townName = _preferences.getDefaultSourceTownName();
    if (townName == null || townName.trim().isEmpty) {
      return null;
    }
    return townName.trim();
  }

  Future<void> saveDefaultSourceTownName(String townName) async {
    await _preferences.setDefaultSourceTownName(townName.trim());
  }

  Future<String> getPrinterPreset() async {
    final preset = _preferences.getPrinterPreset();
    if (preset == null || preset.trim().isEmpty) {
      return _defaultPrinterPreset;
    }
    return preset.trim().toLowerCase();
  }

  Future<void> savePrinterPreset(String preset) async {
    await _preferences.setPrinterPreset(preset.trim().toLowerCase());
  }
}
