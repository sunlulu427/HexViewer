import 'package:flutter/material.dart';
import 'package:hex_viewer/hex_formatter.dart';
import 'package:hex_viewer/pick_file.dart';

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
    pickFile(PickFileCallback(
      onBytesReaded: (bytes) => {
        setState(() {
          fileContent = formatHexView(bytes);
        })
      },
      onError: (message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      },
    ));
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
        child: Text(
          fileContent.isNotEmpty ? fileContent : "No file selected",
        ),
      ),
    );
  }
}
