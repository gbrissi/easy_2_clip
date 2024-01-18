import 'package:easy_2_clip/widgets/shared/video_controllers/providers/video_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioController extends StatefulWidget {
  const AudioController({super.key});

  @override
  State<AudioController> createState() => _AudioControllerState();
}

class _AudioControllerState extends State<AudioController> {
  late final _audioController = context.read<VideoControllerProvider>();

  @override
  Widget build(BuildContext context) {
    return Selector<VideoControllerProvider, double>(
      selector: (_, provider) => provider.audio,
      builder: (_, audio, __) {
        return Row(
          children: [
            IconButton(
              onPressed: audio > 0
                  ? _audioController.muteVolume
                  : _audioController.unmuteVolume,
              icon: Icon(
                audio > 0 ? Icons.volume_up : Icons.volume_off,
              ),
            ),
            SliderTheme(
              data: const SliderThemeData(
                trackHeight: 2.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
              ),
              child: SizedBox(
                width: 120,
                child: Slider(
                  value: audio,
                  max: 100,
                  activeColor: Colors.grey.shade900,
                  onChanged: _audioController.setVolume,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
