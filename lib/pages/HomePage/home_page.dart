// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Third Party Packages
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';

// Widgets
import 'widgets/file_name_preview.dart';
import 'widgets/late_participants_dialog.dart';
import 'widgets/my_filter_button.dart';

// Functions
import 'functions/get_late_participants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? _fileData;
  String? _fileName;
  bool _isFileHovered = false;

  DateTime _filterDateTime = DateTime.now().copyWith(
    hour: 5,
    minute: 1,
    second: 0,
    microsecond: 0,
    millisecond: 0,
  );
  final _timeController = TextEditingController(text: '5:01 AM');
  final _dateController = TextEditingController(
    text: DateTime.now().toString().split(' ').first,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zoom Attendance Tracker')),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          const Row(),
          const SizedBox(height: 35),
          DropTarget(
            onDragDone: _onDragDone,
            onDragEntered: (_) => setState(() => _isFileHovered = true),
            onDragExited: (_) => setState(() => _isFileHovered = false),
            child: GestureDetector(
              onTap: _selectFile,
              child: Container(
                foregroundDecoration: BoxDecoration(
                  color: _isFileHovered
                      ? Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.420)
                      : null,
                ),
                child: FileNamePreview(filePath: _fileName),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: _selectFile,
            child: const Text('Select File'),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 50,
              runSpacing: 50,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.date_range),
                      labelText: "Enter Date",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: _onEnterDatePressed,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.timer),
                      labelText: "Enter Time",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: _onEnterTimePressed,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          MyFilterButton(
            hidden: _fileName == null,
            onPressed: _getLateParticipants,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _onDragDone(DropDoneDetails data) async {
    try {
      for (final file in data.files) {
        if ((file.mimeType != null && file.mimeType != 'text/csv') ||
            file.name.split('.').last.toLowerCase() != 'csv' ||
            file.name.split('.').length == 1) {
          continue;
        }

        _fileData = await file.readAsBytes();
        _fileName = file.name;
        setState(() {});
        break;
      }
    } on Exception {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid input. Please select a valid CSV file.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _onEnterDatePressed() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _filterDateTime,
      firstDate: DateTime(0000),
      lastDate: DateTime(9999),
    );

    if (pickedDate == null) return;

    _filterDateTime = _filterDateTime.copyWith(
      year: pickedDate.year,
      month: pickedDate.month,
      day: pickedDate.day,
    );
    _dateController.text = pickedDate.toString().split(' ').first;
  }

  void _onEnterTimePressed() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay(
        hour: _filterDateTime.hour,
        minute: _filterDateTime.minute,
      ),
      context: context,
    );

    if (pickedTime == null) return;
    if (!mounted) return;

    _filterDateTime = _filterDateTime.copyWith(
      hour: pickedTime.hour,
      minute: pickedTime.minute,
    );
    _timeController.text = pickedTime.format(context);
  }

  void _selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        lockParentWindow: true,
        withData: true,
      );

      if (result == null || result.files.single.extension != 'csv') return;

      _fileData = result.files.single.bytes;
      _fileName = result.files.single.name;
      setState(() {});
    } on PlatformException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'An error occurred. Please try again.',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _getLateParticipants() {
    try {
      final lateParticipants = getLateParticipants(
        fileData: _fileData!,
        filterDateTime: _filterDateTime,
      );

      // Show a dialog with the late participants
      // Keep the dialog open until the user closes it
      // The dialog should have a button to copy the list of late participants
      showDialog(
        context: context,
        builder: (context) {
          return LateParticipantsDialog(lateParticipants: lateParticipants);
        },
        barrierDismissible: false,
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().split('Exception: ')[1],
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 6),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timeController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
