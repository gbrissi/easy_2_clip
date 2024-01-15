import 'dart:io';

import 'package:easy_2_clip/widgets/shared/shell.dart';
import 'package:easy_2_clip/widgets/shared/video_clipper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

class ClipScreen extends StatefulWidget {
  const ClipScreen({super.key});

  @override
  State<ClipScreen> createState() => _ClipScreenState();
}

class _ClipScreenState extends State<ClipScreen> {
  File? video;

  Future<File?> _pickFile() async {
    File? file;
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
    }

    return file;
  }

  void _showFailSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(text),
      ),
    );
  }

  Future<void> _pickVideo() async {
    final File? file = await _pickFile();
    if (file != null) {
      if (file.existsSync()) {
        final String? type = lookupMimeType(file.path);
        if ((type?.startsWith("video") ?? false) && mounted) {
          setState(() {
            video = file;
          });
        } else {
          _showFailSnackbar(
            "The selected file isn't a video",
          );
        }
      } else {
        _showFailSnackbar(
          "The video wasn't found in the indicated path",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shell(
      child: Center(
        child: Builder(
          builder: (context) {
            if (video != null) {
              return VideoClipper(
                file: video!,
              );
            } else {
              return TextButton.icon(
                onPressed: _pickVideo,
                icon: const Icon(Icons.add),
                label: const Text(
                  "Pick a video",
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
