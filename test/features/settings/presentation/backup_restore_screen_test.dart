import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_mobile/core/constants/app_strings.dart';
import 'package:group_mobile/core/services/backup_restore_service.dart';
import 'package:group_mobile/core/services/storage_permission_service.dart';
import 'package:group_mobile/core/theme/app_theme.dart';
import 'package:group_mobile/data/local/database/app_database.dart';
import 'package:group_mobile/features/settings/presentation/providers/settings_provider.dart';
import 'package:group_mobile/features/settings/presentation/screens/backup_restore_screen.dart';
import 'package:group_mobile/providers/database_provider.dart';

class _FakeBackupRestoreService extends BackupRestoreService {
  _FakeBackupRestoreService({
    this.files = const [],
    this.fullBackupResult = const BackupResult(
      path: 'C:/tmp/full.zip',
      message: AppStrings.fullBackupCreated,
    ),
    this.lightBackupResult = const BackupResult(
      path: 'C:/tmp/light.sqlite',
      message: AppStrings.lightBackupCreated,
    ),
  });

  final List<BackupFileEntry> files;
  final BackupResult fullBackupResult;
  final BackupResult lightBackupResult;
  String? restoredPath;

  @override
  Future<List<BackupFileEntry>> listAvailableRestoreFiles() async => files;

  @override
  Future<BackupResult> createFullBackup() async => fullBackupResult;

  @override
  Future<BackupResult> createLightBackup() async => lightBackupResult;

  @override
  Future<RestoreResult> restoreBackup(String backupPath) async {
    restoredPath = backupPath;
    return RestoreResult(
      message: AppStrings.backupRestored,
      usedBackupPath: backupPath,
    );
  }
}

class _FakeStoragePermissionService extends StoragePermissionService {
  const _FakeStoragePermissionService();

  @override
  Future<StoragePermissionResult> ensureBackupPermissions() async {
    return const StoragePermissionResult(isGranted: true);
  }
}

Widget _buildScreen({
  required BackupRestoreService service,
  Future<BackupFileEntry?> Function()? pickRestoreFileFromDevice,
}) {
  return ProviderScope(
    overrides: [
      backupRestoreServiceProvider.overrideWith((ref) => service),
      storagePermissionServiceProvider.overrideWith(
        (ref) => const _FakeStoragePermissionService(),
      ),
      databaseProvider.overrideWith(
        (ref) => AppDatabase.forTesting(NativeDatabase.memory()),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      home: BackupRestoreScreen(
        pickRestoreFileFromDevice: pickRestoreFileFromDevice,
      ),
    ),
  );
}

void main() {
  testWidgets('shows Browse Device even when backup folders are empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      _buildScreen(service: _FakeBackupRestoreService(files: const [])),
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(ListTile, AppStrings.restoreBackupTitle),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.browseDevice), findsOneWidget);
    expect(find.text(AppStrings.backupFoldersEmpty), findsOneWidget);
  });

  testWidgets('shows picked arbitrary file path in restore confirmation dialog', (
    tester,
  ) async {
    final pickedEntry = BackupFileEntry(
      path: 'C:/external/folder/external_restore.zip',
      name: 'external_restore.zip',
      sizeBytes: 3,
      modifiedAt: DateTime(2026, 4, 28, 10, 30),
    );

    await tester.pumpWidget(
      _buildScreen(
        service: _FakeBackupRestoreService(files: const []),
        pickRestoreFileFromDevice: () async => pickedEntry,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(ListTile, AppStrings.restoreBackupTitle),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.browseDevice));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.restoreBackupTitle), findsWidgets);
    expect(find.textContaining(pickedEntry.path), findsOneWidget);
  });

  testWidgets('shows full backup success message with output path', (
    tester,
  ) async {
    const result = BackupResult(
      path: 'C:/tmp/groupparcel_full.zip',
      message: AppStrings.fullBackupCreated,
    );

    await tester.pumpWidget(
      _buildScreen(
        service: _FakeBackupRestoreService(fullBackupResult: result),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, AppStrings.fullBackupTitle));
    await tester.pump();
    await tester.pump();

    expect(find.textContaining(result.message), findsOneWidget);
    expect(find.textContaining(result.path), findsOneWidget);
  });

  testWidgets('shows light backup success message with output path', (
    tester,
  ) async {
    const result = BackupResult(
      path: 'C:/tmp/groupparcel_light.sqlite',
      message: AppStrings.lightBackupCreated,
    );

    await tester.pumpWidget(
      _buildScreen(
        service: _FakeBackupRestoreService(lightBackupResult: result),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, AppStrings.lightBackupTitle));
    await tester.pump();
    await tester.pump();

    expect(find.textContaining(result.message), findsOneWidget);
    expect(find.textContaining(result.path), findsOneWidget);
  });
}
