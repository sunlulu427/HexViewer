import 'package:flutter/material.dart';
import 'package:hex_viewer/hex_formatter.dart';
import 'package:hex_viewer/pick_file.dart';
import 'package:hex_viewer/widgets/file_viewer.dart';
import 'package:sidebarx/sidebarx.dart';

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
              padding: const EdgeInsets.only(left: 32, right: 32),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              fileContent = "";
            });
          },
          elevation: 7,
          highlightElevation: 14,
          tooltip: 'close',
          isExtended: false,
          child: const Icon(Icons.clear),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        drawer: SidebarX(
          theme: SidebarXTheme(
              decoration: const BoxDecoration(color: Colors.blueGrey),
              textStyle: const TextStyle(color: Colors.white),
              itemTextPadding: const EdgeInsets.only(left: 16),
              selectedItemTextPadding: const EdgeInsets.only(left: 16),
              itemDecoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              selectedItemDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.37)))),
          controller: SidebarXController(selectedIndex: 0, extended: true),
          items: const [
            SidebarXItem(icon: Icons.home, label: 'Home'),
            SidebarXItem(icon: Icons.search, label: 'Search')
          ],
        ),
        body: Expanded(
          child: Container(
            color: Colors.white,
            child: Center(
              child: FileViewer(content: fileContent),
            ),
          ),
        ));
  }
}
