// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:dotted_border/dotted_border.dart';

class FileNamePreview extends StatelessWidget {
  const FileNamePreview({super.key, required this.filePath});

  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(12),
        color: Theme.of(context).colorScheme.primary,
        strokeWidth: 2,
        strokeCap: StrokeCap.round,
        dashPattern: filePath == null ? [6.9] : [1000, 0],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 600),
        decoration: BoxDecoration(
          color: filePath != null
              ? Theme.brightnessOf(context) == Brightness.dark
                    ? Colors.black87
                    : Colors.white70
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
            child: filePath == null
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No File Selected'),
                      SizedBox(height: 10),
                      Text('Drag & Drop file here'),
                      SizedBox(height: 10),
                      Icon(Icons.file_download_outlined),
                    ],
                  )
                : Text(
                    filePath!.split(RegExp(r'[/\\]')).last,
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ),
    );
  }
}
