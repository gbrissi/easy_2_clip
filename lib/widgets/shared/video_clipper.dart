import 'dart:io';

import 'package:easy_2_clip/providers/video_file_controller.dart';
import 'package:easy_2_clip/widgets/shared/column_separated.dart';
import 'package:easy_2_clip/widgets/shared/range_selector/range_selector.dart';
import 'package:easy_2_clip/widgets/shared/row_separated.dart';
import 'package:easy_2_clip/widgets/shared/video_controllers/video_controllers.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';

class VideoClipper extends StatefulWidget {
  const VideoClipper({
    super.key,
  });

  @override
  State<VideoClipper> createState() => _VideoClipperState();
}

class _VideoClipperState extends State<VideoClipper> {
  // Create a [Player] to control playback.
  late final _player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final _videoController = VideoController(_player);
  late final _videoFileController = context.read<VideoFileController>();
  File get file => _videoFileController.file!;

  String get _filePath => file.path;
  Media get _videoFile => Media("file:///$_filePath");

  Duration _videoDuration = Duration.zero;
  TrimRange? _selectedRange;

  final GlobalKey _videoKey = GlobalKey();
  double? _videoWidth;

  void _updateRange(TrimRange range) {
    setState(() {
      _selectedRange = range;
    });
  }

  void _updateSize() {
    if (mounted) {
      setState(() {
        _videoWidth = _videoKey.currentContext?.size?.width;
        print("Video: ${_videoWidth}");
      });
    }
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateSize());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ColumnSeparated(
          spacing: 12,
          key: _videoKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Clip your video",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Configure your clip settings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            RowSeparated(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
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
                  width: 340,
                  height: 480 * 9.0 / 16.0,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        // spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ColumnSeparated(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Video details",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "path: ${file.path}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const Spacer(),
                          FilledButton.tonalIcon(
                            onPressed: () => {},
                            icon: const Icon(Icons.close),
                            label: const Text("Remove video"),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          width: _videoWidth,
          child: Column(
            children: [
              RangeSelector(
                totalDuration: _videoDuration,
                onChanged: _updateRange,
              ),
              VideoControllers(
                controller: _videoController,
              ),
            ],
          ),
        )
      ],
    );
  }
}
