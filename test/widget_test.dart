import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_mobile/core/constants/parcel_strings.dart';
import 'package:group_mobile/core/theme/app_theme.dart';
import 'package:group_mobile/features/parcel/presentation/providers/parcel_list_provider.dart';
import 'package:group_mobile/features/parcel/presentation/screens/parcel_list_screen.dart';

Widget _buildTestApp() {
  return ProviderScope(
    overrides: [
      parcelListProvider.overrideWith((ref) => Stream.value(const [])),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      home: const ParcelListScreen(),
    ),
  );
}

void main() {
  testWidgets('parcel list screen renders app shell', (tester) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.pump();

    expect(find.text(ParcelStrings.parcelListTitle), findsOneWidget);
  });

  testWidgets('parcel list screen shows menu icon instead of bluetooth', (
    tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.pump();

    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
    expect(find.byIcon(Icons.bluetooth_disabled), findsNothing);
  });

  testWidgets('parcel list screen does not show bluetooth action', (
    tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.pump();

    expect(find.byKey(const Key('home-printer-action')), findsNothing);
  });
}
