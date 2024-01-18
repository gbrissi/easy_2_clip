import 'package:easy_2_clip/widgets/shared/video_controllers/providers/video_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';

import 'components/audio_controller.dart';
import 'components/play_button.dart';

class VideoControllers extends StatelessWidget {
  const VideoControllers({
    super.key,
    required this.controller,
  });
  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: ChangeNotifierProvider(
        create: (_) => VideoControllerProvider(
          videoController: controller,
        ),
        child: const Row(
          children: [
            PlayButton(),
            AudioController(),
          ],
        ),
      ),
    );
  }
}
