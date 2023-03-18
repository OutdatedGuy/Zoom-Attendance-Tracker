// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LateParticipantsDialog extends StatefulWidget {
  const LateParticipantsDialog({
    super.key,
    required this.lateParticipants,
  });

  final List<String> lateParticipants;

  @override
  State<LateParticipantsDialog> createState() => _LateParticipantsDialogState();
}

class _LateParticipantsDialogState extends State<LateParticipantsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Row(
        children: [
          const Text('Late Participants'),
          const Spacer(),
          IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Text(
        widget.lateParticipants.map((e) => '• $e').join('\n'),
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          child: const Text('Copy'),
          onPressed: () async {
            // Copy the list of late participants to the clipboard
            await Clipboard.setData(
              ClipboardData(text: widget.lateParticipants.join('\n')),
            );
            if (!mounted) return;

            // Show a snackbar to notify the user that the list has been copied
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Copied to clipboard'),
              ),
            );
          },
        ),
      ],
    );
  }
}
