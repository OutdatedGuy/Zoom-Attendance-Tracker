// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:dotted_border/dotted_border.dart';

class FileNamePreview extends StatelessWidget {
  const FileNamePreview({
    Key? key,
    required this.filePath,
  }) : super(key: key);

  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Theme.of(context).colorScheme.primary,
      borderType: BorderType.RRect,
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      dashPattern: [filePath == null ? 6.9 : 1],
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 600),
        color: filePath != null ? Colors.black87 : null,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
            child: filePath == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('No File Selected'),
                      SizedBox(height: 10),
                      Text('Drag & Drop file here'),
                      SizedBox(height: 10),
                      Icon(Icons.file_download_outlined),
                    ],
                  )
                : Text(filePath!.split(RegExp(r'[/\\]')).last),
          ),
        ),
      ),
    );
  }
}
