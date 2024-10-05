
import 'dart:typed_data';

String formatHexView(Uint8List bytes) {
  final buffer = StringBuffer();

  for (int i = 0; i < bytes.length; i += 16) {
    final startPosition = i.toRadixString(16).padLeft(8, '0');
    buffer.write("$startPosition: ");

    for (int j = 0; j < 16; ++j) {
      if (i + j < buffer.length) {
        buffer.write("${bytes[i + j].toRadixString(16).padLeft(2, '0')} ");
      } else {
        buffer.write("  ");
      }
    }
    buffer.write("\n");
  }
  return buffer.toString();
}

