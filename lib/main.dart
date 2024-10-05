import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

void main() {
  runApp(const HexViewerApp());
}

class HexViewerApp extends StatelessWidget {
  const HexViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hex Viewer',
      debugShowCheckedModeBanner: false,
      home: HexViewerPage(),
    );
  }
}

class HexViewerPage extends StatefulWidget {
  const HexViewerPage({super.key});
  @override
  State<HexViewerPage> createState() => _HexViewerPageState();
}

class _HexViewerPageState extends State<HexViewerPage> {
  String fileContent = '';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      Uint8List bytes = await file.readAsBytes();
      setState(() {
        fileContent = _formatHexView(bytes);
      });
    }
  }

  String _formatHexView(Uint8List bytes) {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < bytes.length; i += 16) {
      buffer.write("${i.toRadixString(16).padLeft(8, '0')}: ");
      for (int j = 0; j < 16; ++j) {
        if (i + j < bytes.length) {
          buffer.write("${bytes[i + j].toRadixString(16).padLeft(2, '0')} ");
        } else {
          buffer.write("  ");
        }
      }
      buffer.write("\n");
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hex Viewer'),
        actions: [
          IconButton(
            onPressed: _pickFile,
            icon: const Icon(Icons.folder_open),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(fileContent.isNotEmpty ? fileContent : "No file selected"),
      ),
    );
  }
}
