import 'package:flutter/material.dart';

class FileViewer extends StatelessWidget {
  final String content;
  late final List<String> lines;
  FileViewer({super.key, required this.content}) : lines = content.split('\n');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lines.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            lines[index],
            style: const TextStyle(
              fontFamily: 'monospace',
            ),
          ),
        );
      },
    );
  }
}
