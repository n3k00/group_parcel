import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_mobile/core/theme/app_theme.dart';
import 'package:group_mobile/data/models/town.dart';
import 'package:group_mobile/features/settings/presentation/providers/town_settings_provider.dart';
import 'package:group_mobile/features/settings/presentation/screens/to_town_settings_screen.dart';

class _FakeTownSettingsNotifier extends TownSettingsNotifier {
  _FakeTownSettingsNotifier(this._initialState);

  final TownSettingsState _initialState;

  @override
  Future<TownSettingsState> build() async => _initialState;

  @override
  Future<void> addDestinationTown({required String townName}) async {
    final current = state.asData?.value ?? _initialState;
    state = AsyncData(
      current.copyWith(
        destinationTowns: [
          ...current.destinationTowns,
          TownModel(
            id: current.destinationTowns.length + 10,
            townName: townName,
            type: TownType.destination,
          ),
        ],
      ),
    );
  }

  @override
  Future<void> deleteTown(int id) async {
    final current = state.asData?.value ?? _initialState;
    state = AsyncData(
      current.copyWith(
        destinationTowns: current.destinationTowns
            .where((town) => town.id != id)
            .toList(),
      ),
    );
  }
}

void main() {
  const initialState = TownSettingsState(
    sourceTowns: [],
    destinationTowns: [
      TownModel(id: 1, townName: 'မူဆယ်', type: TownType.destination),
    ],
  );

  testWidgets('delete asks confirmation before removing town', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          townSettingsProvider.overrideWith(
            () => _FakeTownSettingsNotifier(initialState),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const ToTownSettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('မူဆယ်'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Delete To Town'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('မူဆယ်'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('မူဆယ်'), findsNothing);
  });
}
