import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../models/catalog_models.dart';

/// The single audio player shared by every screen in the app.
class PlaybackController extends ChangeNotifier {
  PlaybackController._() {
    _playerStateSubscription = player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed && !_changing) {
        unawaited(playNext());
      }
      notifyListeners();
    });
  }

  static final PlaybackController instance = PlaybackController._();

  final AudioPlayer player = AudioPlayer();
  late final StreamSubscription<PlayerState> _playerStateSubscription;

  List<PlaybackTrack> _queue = [];
  int _currentIndex = 0;
  bool _changing = false;
  bool _shuffleEnabled = false;
  bool fullPlayerOpen = false;
  String? error;

  bool get hasTrack => _queue.isNotEmpty;
  PlaybackTrack? get currentTrack => hasTrack ? _queue[_currentIndex] : null;
  Song? get currentSong => currentTrack?.song;
  int get currentIndex => _currentIndex;
  int get queueLength => _queue.length;
  bool get shuffleEnabled => _shuffleEnabled;
  bool get isPlaying => player.playing;
  bool get hasNext => _currentIndex < _queue.length - 1;
  bool get hasPrevious => _currentIndex > 0;

  Future<void> playQueue(
    List<PlaybackTrack> tracks, {
    int initialIndex = 0,
    bool shuffled = false,
  }) async {
    if (tracks.isEmpty) return;

    _queue = List<PlaybackTrack>.from(tracks);
    _currentIndex = initialIndex.clamp(0, _queue.length - 1).toInt();
    _shuffleEnabled = shuffled;
    if (shuffled) _shuffleKeepingCurrentTrack();
    notifyListeners();
    await _loadCurrentTrack(autoplay: true);
  }

  Future<void> _loadCurrentTrack({required bool autoplay}) async {
    final track = currentTrack;
    if (track == null || _changing) return;

    _changing = true;
    error = null;
    notifyListeners();

    try {
      await player.stop();
      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(track.song.mp3),
          tag: MediaItem(
            id: track.song.mp3,
            title: track.song.name,
            artist: track.concert.artist,
            album: track.concert.title,
            artUri: track.concert.albumImage.isNotEmpty
                ? Uri.tryParse(track.concert.albumImage)
                : null,
          ),
        ),
      );
      if (autoplay) unawaited(player.play());
    } catch (exception) {
      error = exception.toString();
    } finally {
      _changing = false;
      notifyListeners();
    }
  }

  Future<void> playNext() async {
    if (!hasNext) {
      await player.pause();
      await player.seek(Duration.zero);
      notifyListeners();
      return;
    }
    _currentIndex++;
    notifyListeners();
    await _loadCurrentTrack(autoplay: true);
  }

  Future<void> playPrevious() async {
    if (!hasPrevious) return;
    _currentIndex--;
    notifyListeners();
    await _loadCurrentTrack(autoplay: true);
  }

  Future<void> togglePlayback() async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
    notifyListeners();
  }

  void toggleShuffle() {
    _shuffleEnabled = !_shuffleEnabled;
    if (_shuffleEnabled && hasTrack) _shuffleKeepingCurrentTrack();
    notifyListeners();
  }

  void _shuffleKeepingCurrentTrack() {
    final current = _queue[_currentIndex];
    final remaining = List<PlaybackTrack>.from(_queue)
      ..removeAt(_currentIndex)
      ..shuffle();
    _queue = [current, ...remaining];
    _currentIndex = 0;
  }

  void setFullPlayerOpen(bool value) {
    fullPlayerOpen = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    player.dispose();
    super.dispose();
  }
}
