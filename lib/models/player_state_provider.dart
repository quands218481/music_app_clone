// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';

class PlayerStateProvider {
  AudioPlayer advancedPlayer = AudioPlayer();
  PlayerStateProvider() {
    // advancedPlayer.setUrl(url);
  }
  get durationStream => advancedPlayer.durationStream;
  Duration get duration =>
      advancedPlayer.duration ?? const Duration(milliseconds: 1);
  get positionStream => advancedPlayer.positionStream;
  Duration get position {
    if (processingState == ProcessingState.completed) {
      return const Duration(seconds: 0);
    } else {
      return advancedPlayer.position;
    }
  }

  setPosition(double p) {
    advancedPlayer.seek(Duration(seconds: p.toInt()));
  }

  get playingStateStream => advancedPlayer.playerStateStream;
  get processingState => advancedPlayer.processingState;
  get playing => advancedPlayer.playing;
  void togglePlayer() {
    if (playing) {
      advancedPlayer.pause();
    } else {
      advancedPlayer.play();
    }
  }

  setNewUrl(String url) {
    advancedPlayer.setUrl(url);
    advancedPlayer.play();
  }
  get volumeStream => advancedPlayer.volumeStream;
  get volume => advancedPlayer.volume;
  void setVolumeApp(double v) {
    advancedPlayer.setVolume(v);
  }
}
