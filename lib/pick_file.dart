import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:universal_platform/universal_platform.dart';
import 'logger.dart';

class PickFileCallback {
  final void Function(FilePickerResult? result)? onFilePicked;
  final void Function(Uint8List bytes) onBytesReaded;
  final void Function(String message)? onError;

  PickFileCallback(
      {required this.onBytesReaded, this.onFilePicked, this.onError});
}

Future<void> pickFile(PickFileCallback callback) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.any,
    allowMultiple: false,
  );

  if (callback.onFilePicked != null) {
    callback.onFilePicked!(result);
  }

  if (result != null && result.files.isNotEmpty) {
    PlatformFile file = result.files.single;
    logger.i('platform: ${UniversalPlatform.value}');
    logger.i('file.name: ${file.name}');
    logger.i('file.size: ${file.size}');
    if (!UniversalPlatform.isWeb) {
      logger.i('file.path: ${file.path}');
    }

    Uint8List? bytes = await _readBytesFromPlatformFile(file);
    if (bytes != null) {
      logger.i('file.bytes: ${bytes.length}');
      callback.onBytesReaded(bytes);
    } else {
      if (callback.onError != null) {
        callback.onError!('File is empty');
      }
    }
  }
}

Future<Uint8List?> _readBytesFromPlatformFile(PlatformFile file) async {
  if (UniversalPlatform.isWeb) {
    return file.bytes;
  } else {
    if (file.path != null) {
      File localFile = File(file.path!);
      Uint8List bytes = await localFile.readAsBytes();
      return bytes;
    }
    return null;
  }
}
