import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../constants/app_strings.dart';

class BackupResult {
  const BackupResult({
    required this.path,
    required this.message,
  });

  final String path;
  final String message;
}

class RestoreResult {
  const RestoreResult({
    required this.message,
    required this.usedBackupPath,
  });

  final String message;
  final String usedBackupPath;
}

class BackupFileEntry {
  const BackupFileEntry({
    required this.path,
    required this.name,
    required this.sizeBytes,
    required this.modifiedAt,
  });

  final String path;
  final String name;
  final int sizeBytes;
  final DateTime modifiedAt;
}

class BackupRestoreService {
  const BackupRestoreService();

  static const _databaseFileName = 'groupparcel.sqlite';
  static const _legacyDatabaseFileName = 'group.sqlite';
  static const _imageDirectoryName = 'parcel_images';
  static const _backupFolderName = 'Group Parcel Backups';
  static const _legacyBackupFolderName = 'Group Backups';

  Future<BackupResult> createFullBackup() async {
    final databaseFile = await _databaseFile();
    final outputDirectory = await _backupOutputDirectory();
    await outputDirectory.create(recursive: true);

    final archive = Archive();
    archive.addFile(
      ArchiveFile(
        _databaseFileName,
        databaseFile.lengthSync(),
        await databaseFile.readAsBytes(),
      ),
    );

    final imageDirectory = await _parcelImageDirectory();
    if (await imageDirectory.exists()) {
      await for (final entity in imageDirectory.list(recursive: true)) {
        if (entity is! File) {
          continue;
        }
        final relativePath = path.relative(entity.path, from: imageDirectory.path);
        archive.addFile(
          ArchiveFile(
            path.join(_imageDirectoryName, relativePath),
            entity.lengthSync(),
            await entity.readAsBytes(),
          ),
        );
      }
    }

    final timestamp = _timestamp();
    final outputPath = path.join(
      outputDirectory.path,
      'groupparcel_full_$timestamp.zip',
    );
    final outputStream = OutputFileStream(outputPath);
    ZipEncoder().encodeStream(archive, outputStream);
    outputStream.close();

    return BackupResult(
      path: outputPath,
      message: AppStrings.fullBackupCreated,
    );
  }

  Future<BackupResult> createLightBackup() async {
    final databaseFile = await _databaseFile();
    final outputDirectory = await _backupOutputDirectory();
    await outputDirectory.create(recursive: true);

    final timestamp = _timestamp();
    final outputPath = path.join(
      outputDirectory.path,
      'groupparcel_light_$timestamp.sqlite',
    );
    await databaseFile.copy(outputPath);

    return BackupResult(
      path: outputPath,
      message: AppStrings.lightBackupCreated,
    );
  }

  Future<List<BackupFileEntry>> listAvailableRestoreFiles() async {
    final entries = <BackupFileEntry>[];
    final seenPaths = <String>{};

    for (final directory in await _candidateBackupDirectories()) {
      if (!await directory.exists()) {
        continue;
      }

      await for (final entity in directory.list()) {
        if (entity is! File) {
          continue;
        }

        final extension = path.extension(entity.path).toLowerCase();
        if (extension != '.zip' && extension != '.sqlite' && extension != '.db') {
          continue;
        }
        if (!seenPaths.add(entity.path)) {
          continue;
        }

        final stat = await entity.stat();
        entries.add(
          BackupFileEntry(
            path: entity.path,
            name: path.basename(entity.path),
            sizeBytes: stat.size,
            modifiedAt: stat.modified,
          ),
        );
      }
    }

    entries.sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
    return entries;
  }

  Future<RestoreResult> restoreBackup(String backupPath) async {
    final sourceFile = File(backupPath);
    if (!await sourceFile.exists()) {
      throw StateError(AppStrings.backupFileMissing);
    }

    final extension = path.extension(sourceFile.path).toLowerCase();
    if (extension == '.zip') {
      return _restoreFromZip(sourceFile);
    }
    if (extension == '.sqlite' || extension == '.db') {
      await _replaceDatabaseFile(sourceFile);
      return RestoreResult(
        message: AppStrings.databaseRestored,
        usedBackupPath: sourceFile.path,
      );
    }

    throw StateError(AppStrings.unsupportedBackupFormat);
  }

  Future<RestoreResult> _restoreFromZip(File zipFile) async {
    final bytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    final databaseEntry =
        archive.findFile(_databaseFileName) ??
        archive.findFile(_legacyDatabaseFileName);
    if (databaseEntry == null) {
      throw StateError(AppStrings.backupMissingDatabase);
    }

    final tempDirectory = await getTemporaryDirectory();
    final workingDirectory = Directory(
      path.join(tempDirectory.path, 'backup_restore_${DateTime.now().millisecondsSinceEpoch}'),
    );
    await workingDirectory.create(recursive: true);

    try {
      final extractedDatabase = File(path.join(workingDirectory.path, _databaseFileName));
      await extractedDatabase.writeAsBytes(_archiveBytes(databaseEntry), flush: true);
      await _replaceDatabaseFile(extractedDatabase);

      final imageEntries = archive.files
          .where((file) => !file.isDirectory && file.name.startsWith('$_imageDirectoryName/'))
          .toList();
      await _replaceParcelImages(imageEntries);

      return RestoreResult(
        message: AppStrings.backupRestored,
        usedBackupPath: zipFile.path,
      );
    } finally {
      if (await workingDirectory.exists()) {
        await workingDirectory.delete(recursive: true);
      }
    }
  }

  Future<void> _replaceDatabaseFile(File sourceDatabase) async {
    final targetDatabase = await _databaseFile();
    await targetDatabase.parent.create(recursive: true);

    final tempPath = '${targetDatabase.path}.restore';
    final tempFile = await sourceDatabase.copy(tempPath);
    if (await targetDatabase.exists()) {
      await targetDatabase.delete();
    }
    await tempFile.rename(targetDatabase.path);
  }

  Future<void> _replaceParcelImages(List<ArchiveFile> imageEntries) async {
    final targetImageDirectory = await _parcelImageDirectory();
    if (await targetImageDirectory.exists()) {
      await targetImageDirectory.delete(recursive: true);
    }
    await targetImageDirectory.create(recursive: true);

    for (final imageEntry in imageEntries) {
      final relativePath = imageEntry.name.substring(_imageDirectoryName.length + 1);
      final outputFile = File(path.join(targetImageDirectory.path, relativePath));
      await outputFile.parent.create(recursive: true);
      await outputFile.writeAsBytes(_archiveBytes(imageEntry), flush: true);
    }
  }

  Future<File> _databaseFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File(path.join(directory.path, _databaseFileName));
  }

  Future<Directory> _parcelImageDirectory() async {
    final baseDirectory = await getApplicationSupportDirectory();
    return Directory(path.join(baseDirectory.path, _imageDirectoryName));
  }

  Future<Directory> _backupOutputDirectory() async {
    if (Platform.isAndroid) {
      final downloadsDirectory = Directory('/storage/emulated/0/Download');
      if (await downloadsDirectory.exists()) {
        return Directory(path.join(downloadsDirectory.path, _backupFolderName));
      }
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    return Directory(path.join(documentsDirectory.path, _backupFolderName));
  }

  Future<List<Directory>> _candidateBackupDirectories() async {
    final directories = <Directory>[];
    final seenPaths = <String>{};

    final primaryDirectory = await _backupOutputDirectory();
    if (seenPaths.add(primaryDirectory.path)) {
      directories.add(primaryDirectory);
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final fallbackDirectory = Directory(path.join(documentsDirectory.path, _backupFolderName));
    if (seenPaths.add(fallbackDirectory.path)) {
      directories.add(fallbackDirectory);
    }

    final legacyPrimaryDirectory = Directory(
      path.join(primaryDirectory.parent.path, _legacyBackupFolderName),
    );
    if (seenPaths.add(legacyPrimaryDirectory.path)) {
      directories.add(legacyPrimaryDirectory);
    }

    final legacyFallbackDirectory = Directory(
      path.join(documentsDirectory.path, _legacyBackupFolderName),
    );
    if (seenPaths.add(legacyFallbackDirectory.path)) {
      directories.add(legacyFallbackDirectory);
    }

    return directories;
  }

  Uint8List _archiveBytes(ArchiveFile file) {
    return file.readBytes() ?? Uint8List(0);
  }

  String _timestamp() {
    final now = DateTime.now();
    final year = now.year.toString();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    return '$year$month${day}_$hour$minute$second';
  }
}
