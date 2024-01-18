import 'dart:io';

import 'package:easy_2_clip/widgets/shared/range_selector/range_selector.dart';
import 'package:easy_2_clip/widgets/shared/row_separated.dart';
import 'package:easy_2_clip/widgets/shared/video_controllers/video_controllers.dart';
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
        RowSeparated(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 480,
              height: 480 * 9.0 / 16.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Video(
                  controller: _videoController,
                  controls: NoVideoControls,
                ),
              ),
            ),
            SizedBox(
              // width: 160,
              height: 480 * 9.0 / 16.0,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      const SizedBox.shrink(),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () => {},
                        icon: const Icon(Icons.delete),
                        label: const Text("Remove video"),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        RangeSelector(
          totalDuration: _videoDuration,
          onChanged: _updateRange,
        ),
        VideoControllers(
          controller: _videoController,
        ),
      ],
    );
  }
}
