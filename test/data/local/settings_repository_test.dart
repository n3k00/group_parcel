import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:group_mobile/core/constants/receipt_strings.dart';
import 'package:group_mobile/data/local/preferences/app_preferences.dart';
import 'package:group_mobile/data/repositories/settings_repository.dart';

void main() {
  late SettingsRepository repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await AppPreferences.create();
    repository = SettingsRepository(preferences);
  });

  test('returns balanced printer preset by default', () async {
    final preset = await repository.getPrinterPreset();

    expect(preset, 'balanced');
  });

  test('saves and loads default source town name', () async {
    await repository.saveDefaultSourceTownName('လားရှိုး');

    final value = await repository.getDefaultSourceTownName();

    expect(value, 'လားရှိုး');
  });

  test('returns default address font size in app setup', () async {
    final setup = await repository.getAppSetup();

    expect(setup.businessSubtitle, ReceiptStrings.defaultBusinessSubtitle);
    expect(setup.businessSubtitleFontSize, 28);
    expect(setup.businessAddressFontSize, 22);
    expect(setup.businessAddress, ReceiptStrings.defaultBusinessAddress);
  });

  test('loads saved subtitle settings when present', () async {
    SharedPreferences.setMockInitialValues({
      'business_subtitle': 'ကုန်စည်ပို့ဆောင်ရေး',
      'business_subtitle_font_size': 31.0,
    });
    final preferences = await AppPreferences.create();
    repository = SettingsRepository(preferences);

    final setup = await repository.getAppSetup();

    expect(setup.businessSubtitle, 'ကုန်စည်ပို့ဆောင်ရေး');
    expect(setup.businessSubtitleFontSize, 31);
  });
}
