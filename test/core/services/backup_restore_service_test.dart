import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_mobile/core/constants/app_strings.dart';
import 'package:group_mobile/core/services/backup_restore_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _FakePathProviderPlatform extends PathProviderPlatform {
  _FakePathProviderPlatform({
    required this.documentsPath,
    required this.supportPath,
    required this.temporaryPath,
  });

  final String documentsPath;
  final String supportPath;
  final String temporaryPath;

  @override
  Future<String?> getApplicationDocumentsPath() async => documentsPath;

  @override
  Future<String?> getApplicationSupportPath() async => supportPath;

  @override
  Future<String?> getTemporaryPath() async => temporaryPath;
}

void main() {
  late Directory tempRoot;
  late PathProviderPlatform originalPathProvider;
  const service = BackupRestoreService();

  setUp(() async {
    tempRoot = await Directory.systemTemp.createTemp('group_parcel_backup_test');
    originalPathProvider = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _FakePathProviderPlatform(
      documentsPath: p.join(tempRoot.path, 'documents'),
      supportPath: p.join(tempRoot.path, 'support'),
      temporaryPath: p.join(tempRoot.path, 'temp'),
    );

    await Directory(p.join(tempRoot.path, 'documents')).create(recursive: true);
    await Directory(p.join(tempRoot.path, 'support')).create(recursive: true);
    await Directory(p.join(tempRoot.path, 'temp')).create(recursive: true);
  });

  tearDown(() async {
    PathProviderPlatform.instance = originalPathProvider;
    if (await tempRoot.exists()) {
      await tempRoot.delete(recursive: true);
    }
  });

  test('restores legacy full backup zip and clears stale parcel images', () async {
    final zipFile = File(p.join(tempRoot.path, 'legacy_full_backup.zip'));
    final staleImage = File(
      p.join(tempRoot.path, 'support', 'parcel_images', 'stale.jpg'),
    );
    await staleImage.parent.create(recursive: true);
    await staleImage.writeAsBytes(const [9, 9, 9]);

    final archive = Archive()
      ..addFile(
        ArchiveFile(
          'group.sqlite',
          3,
          Uint8List.fromList(const [1, 2, 3]),
        ),
      );
    final encodedBytes = ZipEncoder().encode(archive);
    await zipFile.writeAsBytes(encodedBytes, flush: true);

    final result = await service.restoreBackup(zipFile.path);
    final restoredDatabase = File(
      p.join(tempRoot.path, 'documents', 'groupparcel.sqlite'),
    );
    final restoredImageDirectory = Directory(
      p.join(tempRoot.path, 'support', 'parcel_images'),
    );

    expect(result.message, AppStrings.backupRestored);
    expect(result.usedBackupPath, zipFile.path);
    expect(await restoredDatabase.exists(), isTrue);
    expect(await restoredDatabase.readAsBytes(), equals(const [1, 2, 3]));
    expect(await staleImage.exists(), isFalse);
    expect(await restoredImageDirectory.exists(), isTrue);
    expect(await restoredImageDirectory.list().isEmpty, isTrue);
  });

  test('throws a clear error when restore file is missing', () async {
    expect(
      () => service.restoreBackup(p.join(tempRoot.path, 'missing.zip')),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          AppStrings.backupFileMissing,
        ),
      ),
    );
  });

  test('throws a clear error for unsupported backup formats', () async {
    final unsupportedFile = File(p.join(tempRoot.path, 'notes.txt'));
    await unsupportedFile.writeAsString('not a backup', flush: true);

    expect(
      () => service.restoreBackup(unsupportedFile.path),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          AppStrings.unsupportedBackupFormat,
        ),
      ),
    );
  });
}
