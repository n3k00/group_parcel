import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImagePickerService {
  ImagePickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  static const _imageDirectoryName = 'parcel_images';
  static const _maxImageWidth = 1080;
  static const _jpegQuality = 78;

  final ImagePicker _picker;

  Future<String?> pickAndStoreImagePath({
    ImageSource source = ImageSource.gallery,
    String? previousPath,
  }) async {
    final image = await _picker.pickImage(
      source: source,
      imageQuality: 90,
    );
    if (image == null) {
      return null;
    }

    final storedPath = await _storeCompressedCopy(image);
    if (storedPath == null) {
      return null;
    }

    if (previousPath != null && previousPath.isNotEmpty) {
      await deleteStoredImage(previousPath);
    }

    return storedPath;
  }

  Future<void> deleteStoredImage(String pathValue) async {
    if (pathValue.trim().isEmpty) {
      return;
    }

    final file = File(pathValue);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<String?> _storeCompressedCopy(XFile image) async {
    final bytes = await image.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      return null;
    }

    final resized = decoded.width > _maxImageWidth
        ? img.copyResize(
            decoded,
            width: _maxImageWidth,
            height: math.max(
              1,
              (decoded.height * (_maxImageWidth / decoded.width)).round(),
            ),
            interpolation: img.Interpolation.average,
          )
        : decoded;

    final encodedBytes = img.encodeJpg(resized, quality: _jpegQuality);
    final directory = await _parcelImageDirectory();
    await directory.create(recursive: true);

    final fileName =
        'parcel_${DateTime.now().millisecondsSinceEpoch}${_safeExtension(image.path)}';
    final filePath = path.join(directory.path, fileName);
    final outputFile = File(filePath);
    await outputFile.writeAsBytes(encodedBytes, flush: true);
    return outputFile.path;
  }

  Future<Directory> _parcelImageDirectory() async {
    final baseDirectory = await getApplicationSupportDirectory();
    return Directory(path.join(baseDirectory.path, _imageDirectoryName));
  }

  String _safeExtension(String sourcePath) {
    final extension = path.extension(sourcePath).toLowerCase();
    if (extension == '.jpg' || extension == '.jpeg') {
      return extension;
    }
    return '.jpg';
  }
}
