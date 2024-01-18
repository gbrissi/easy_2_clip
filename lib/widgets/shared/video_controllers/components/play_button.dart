import 'package:easy_2_clip/widgets/shared/video_controllers/providers/video_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({super.key});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  late final _controller = context.read<VideoControllerProvider>();
  bool get _isPlaying => _controller.isPlaying;

  IconData get icon => _isPlaying ? Icons.pause : Icons.play_arrow;

  void _setVideoState() =>
      _isPlaying ? _controller.pauseTrack() : _controller.playTrack();

  @override
  Widget build(BuildContext context) {
    return Selector<VideoControllerProvider, bool>(
      selector: (_, provider) => provider.isPlaying,
      builder: (_, isPlaying, __) {
        return IconButton(
          onPressed: _setVideoState,
          icon: Icon(icon),
        );
      },
    );
  }
}
