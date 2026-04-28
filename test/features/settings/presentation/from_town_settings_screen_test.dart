import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:group_mobile/core/theme/app_theme.dart';
import 'package:group_mobile/data/local/preferences/app_preferences.dart';
import 'package:group_mobile/data/models/town.dart';
import 'package:group_mobile/data/repositories/settings_repository.dart';
import 'package:group_mobile/features/parcel/presentation/providers/town_list_provider.dart';
import 'package:group_mobile/features/settings/presentation/providers/settings_provider.dart';
import 'package:group_mobile/features/settings/presentation/screens/from_town_settings_screen.dart';
import 'package:group_mobile/providers/parcel_repository_provider.dart';

void main() {
  testWidgets('selecting from town saves default source town name', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await AppPreferences.create();
    final repository = SettingsRepository(preferences);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWith((ref) async => repository),
          sourceTownListProvider.overrideWith(
            (ref) => Stream.value(const [
              TownModel(
                id: 1,
                townName: 'တောင်ကြီး',
                type: TownType.source,
                cityCode: 'TGI',
              ),
              TownModel(
                id: 2,
                townName: 'လားရှိုး',
                type: TownType.source,
                cityCode: 'LSO',
              ),
            ]),
          ),
          defaultSourceTownNameProvider.overrideWith(
            (ref) async => 'တောင်ကြီး',
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const FromTownSettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('လားရှိုး'));
    await tester.pumpAndSettle();

    expect(await repository.getDefaultSourceTownName(), 'လားရှိုး');
    expect(find.text('Default from town updated.'), findsOneWidget);
  });
}
