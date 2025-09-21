// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LateParticipantsDialog extends StatefulWidget {
  const LateParticipantsDialog({super.key, required this.lateParticipants});

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: Text(
              'Late Participants',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        width: 350,
        child: SelectableText(
          widget.lateParticipants.map((e) => '• $e').join('\n'),
          style: const TextStyle(fontSize: 16),
        ),
      ),
      actions: [
        TextButton(onPressed: _onCopyPressed, child: const Text('Copy')),
      ],
    );
  }

  void _onCopyPressed() async {
    final msg = widget.lateParticipants.isEmpty
        ? '*No Late Participants*'
        : '*Late Participants:*\n- ${widget.lateParticipants.join('\n- ')}';

    // Copy the list of late participants to the clipboard
    await Clipboard.setData(ClipboardData(text: msg));
    if (!mounted) return;

    // Show a snackbar to notify the user that the list has been copied
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }
}
