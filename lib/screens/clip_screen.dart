import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_2_clip/widgets/shared/shell.dart';
import 'package:easy_2_clip/widgets/shared/video_clipper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mime/mime.dart';
import 'dart:math' as math;

import '../widgets/shared/action_button.dart';
import '../widgets/shared/column_separated.dart';

class ClipScreen extends StatefulWidget {
  const ClipScreen({super.key});

  @override
  State<ClipScreen> createState() => _ClipScreenState();
}

class _ClipScreenState extends State<ClipScreen> {
  File? video;
  bool isDragging = false;
  bool isPicking = false;

  Future<File?> _pickFile() async {
    File? file;

    setState(() {
      isPicking = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    setState(() {
      isPicking = false;
    });

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

  void _setVideo(File file) {
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

  Future<void> _pickVideo() async {
    final File? file = await _pickFile();
    if (file != null) {
      _setVideo(file);
    }
  }

  void _getFileDrop(XFile file) {
    final File newFile = File(file.path);
    _setVideo(newFile);
  }

  void _updateDragState(bool value) {
    setState(() {
      isDragging = value;
    });
  }

  Widget get _dragWidget => isDragging
      ? Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.9),
          padding: const EdgeInsets.all(24),
          child: DottedBorder(
            color: Colors.white,
            dashPattern: const [12, 12],
            strokeWidth: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/place_item.svg",
                    width: 64,
                    height: 64,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Text(
                    "Drop your file in here.",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      : const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return Shell(
      child: DropTarget(
        onDragEntered: (_) => _updateDragState(true),
        onDragExited: (_) => _updateDragState(false),
        onDragDone: (details) => _getFileDrop(
          details.files.first,
        ),
        child: Stack(
          children: [
            Positioned(
              top: -40,
              left: -(MediaQuery.of(context).size.width / 7),
              child: Transform.rotate(
                angle: 6,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset(
                    "assets/film_reel.png",
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Builder(
                builder: (context) {
                  // TODO: Move to another screen when video is set.
                  if (video != null) {
                    return VideoClipper(
                      file: video!,
                    );
                  } else {
                    return SizedBox(
                      width: 420,
                      child: ColumnSeparated(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 12,
                        children: [
                          SvgPicture.asset(
                            "assets/place_item.svg",
                            width: 64,
                            height: 64,
                            colorFilter: ColorFilter.mode(
                              Colors.grey.shade900,
                              BlendMode.srcIn,
                            ),
                          ),
                          const Text(
                            "Add a video that you would like to be trimmed",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ActionButton(
                            onPressed: _pickVideo,
                            isActive: !isPicking,
                            label: "Pick a video",
                          ),
                          const Text(
                            "or drop a file in here",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            _dragWidget,
          ],
        ),
      ),
    );
  }
}
