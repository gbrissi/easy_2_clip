import 'dart:io';

import 'package:easy_2_clip/widgets/shared/range_selector/range_selector.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoClipper extends StatefulWidget {
  const VideoClipper({
    super.key,
    required this.file,
  });
  final File file;

  @override
  State<VideoClipper> createState() => _VideoClipperState();
}

class _VideoClipperState extends State<VideoClipper> {
  // Create a [Player] to control playback.
  late final _player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final _videoController = VideoController(_player);

  String get _filePath => widget.file.path;
  Media get _videoFile => Media("file:///$_filePath");

  Duration _videoDuration = Duration.zero;
  TrimRange? _selectedRange;

  void _updateRange(TrimRange range) {
    setState(() {
      _selectedRange = range;
    });
  }

  void _updateVideoLength(Duration duration) {
    if (mounted) {
      setState(() {
        _videoDuration = _player.state.duration;
      });
    }
  }

  @override
  void initState() {
    _player.open(_videoFile);
    _player.stream.duration.listen(_updateVideoLength);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 500,
          height: 500 * 9.0 / 16.0,
          child: Video(
            controller: _videoController,
          ),
        ),
        RangeSelector(
          totalDuration: _videoDuration,
          onChanged: _updateRange,
        ),
      ],
    );
  }
}
