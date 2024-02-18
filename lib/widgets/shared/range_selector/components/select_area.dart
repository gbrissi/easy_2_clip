import 'dart:io';

import 'package:easy_2_clip/providers/range_selector_controller.dart';
import 'package:easy_2_clip/services/ffmpeg_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/video_file_controller.dart';

class SelectArea extends StatefulWidget {
  const SelectArea({
    super.key,
  });

  @override
  State<SelectArea> createState() => _SelectAreaState();
}

class _SelectAreaState extends State<SelectArea> {
  late final _rangeSelectorController = context.read<RangeSelectorController>();
  late final _videoFileController = context.read<VideoFileController>();
  final GlobalKey _areaKey = GlobalKey();
  String get filePath => _videoFileController.file!.path;
  final List<File> vidImages = [];

  Future<void> _setTrailThumbFrames() async {
    final Duration? totalVidDuration = await FFmpegService.getVidTotalDuration(
      filePath,
    );

    if (totalVidDuration != null) {
      // From video start to video end
      final DurationRange range = DurationRange(
        start: Duration.zero,
        end: totalVidDuration,
      );

      // Get thumbnail second by second.
      const Duration step = Duration(
        seconds: 1,
      );

      FFmpegService.getFFmpegVideoFrames(
        filePath,
        step,
        range,
        (File? frame) {
          if (mounted && frame != null) {
            setState(() {
              vidImages.add(frame);
            });
          }
        },
      );
    }
  }

  void _setAreaOffset() {
    final areaBox = _areaKey.currentContext!.findRenderObject() as RenderBox;
    final Offset areaOffset = areaBox.localToGlobal(Offset.zero);
    _rangeSelectorController.setOffsetArea(areaOffset);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setAreaOffset();
      _setTrailThumbFrames();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _areaKey,
      width: double.infinity,
      color: Colors.grey.shade900,
      child: Row(
        children: vidImages
            .map(
              (e) => Expanded(
                child: Image.file(
                  e,
                  height: double.infinity,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
