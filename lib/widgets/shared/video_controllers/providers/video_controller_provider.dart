import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoControllerProvider extends ChangeNotifier {
  final VideoController _videoController;
  double get _volume => _videoController.player.state.volume;
  bool get _isPlaying => _videoController.player.state.playing;

  late bool isPlaying = _isPlaying;
  late double audio = _volume;
  late double _lastTrackedActiveVolume = audio;

  void _updateAudioTrack(_) {
    audio = _volume;
    if (audio > 0) {
      _lastTrackedActiveVolume = audio;
    }

    notifyListeners();
  }

  void _updatePlayingState(_) {
    isPlaying = _isPlaying;
    notifyListeners();
  }

  VideoControllerProvider({required VideoController videoController})
      : _videoController = videoController {
    videoController.player.stream.volume.listen(_updateAudioTrack);
    videoController.player.stream.playing.listen(_updatePlayingState);
  }

  setVolume(double volume) => _videoController.player.setVolume(volume);
  unmuteVolume() => setVolume(_lastTrackedActiveVolume);
  muteVolume() => setVolume(0);
  playTrack() => _videoController.player.play();
  pauseTrack() => _videoController.player.pause();
}
