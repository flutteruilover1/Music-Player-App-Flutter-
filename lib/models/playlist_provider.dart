import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/models/song.dart';

class playlistProvider extends ChangeNotifier {
  // playlist of song
  final List<Song> _playlist = [
    Song(
      songName: 'Nafta ujeelan awgaa joogine maqanee',
      artisName: 'Farxiya Fiska',
      albumArtImagePath: 'assets/images/farxiya_fiska.png',
      audioPath: 'audio/Farxiya Fiska.mp3',
    ),

    Song(
      songName: 'Heesta Naxli adoo niyada iga jaray',
      artisName: 'Yurub Geenyo',
      albumArtImagePath: 'assets/images/yurub_genyo.jpg',
      audioPath: 'audio/yurub geenyo.mp3',
    ),
  ];

  int? _currentSongIndex = 0;

  // audio player
  final AudioPlayer _audioplayer = AudioPlayer();

  // duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor   👈 SLIDER FIXES HERE 🔥🔥🔥
  playlistProvider() {
    listenToDuration();
  }

  // initially not play
  bool _isPlaying = false;

  // play song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;

    await _audioplayer.stop();
    await _audioplayer.play(AssetSource(path));

    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioplayer.pause();
    _isPlaying = false;
    notifyListeners(); // 👈 Was missing
  }

  // resume playing
  void resume() async {
    await _audioplayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void puseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek
  void seek(Duration position) async {
    await _audioplayer.seek(position);
  }

  // next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  // previous song
  void playPreviouseSong() {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // listen to duration (THIS DRIVES THE SLIDER)
  void listenToDuration() {
    // total duration
    _audioplayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // current position
    _audioplayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // when song finishes
    _audioplayer.onPlayerComplete.listen((event) => playNextSong());
  }

  /*
    GETTERS
  */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*
    SETTERS
  */
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }
}
