import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/catalog_models.dart';
import '../../services/favorites_service.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({
    super.key,
    required this.concert,
    required this.initialIndex,
  });

  final FullConcert concert;
  final int initialIndex;

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final AudioPlayer _player = AudioPlayer();
  final FavoritesService _favoritesService = FavoritesService();

  late int _currentIndex;
  late StreamSubscription<PlayerState> _playerStateSubscription;

  String? _error;
  bool _changingSong = false;
  bool _isFavorite = false;

  Song get _currentSong => widget.concert.songs[_currentIndex];

  bool get _hasPrevious => _currentIndex > 0;

  bool get _hasNext => _currentIndex < widget.concert.songs.length - 1;

  @override
  void initState() {
    super.initState();

    _currentIndex =
        widget.initialIndex.clamp(0, widget.concert.songs.length - 1).toInt();

    _playerStateSubscription = _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed &&
          !_changingSong) {
        _playNext();
      }
    });

    _loadCurrentSong(autoplay: true);
  }

  Future<void> _loadFavoriteStatus() async {
    final isFavorite = await _favoritesService.isFavorite(
      _currentSong.mp3,
    );

    if (!mounted) return;

    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    final isFavorite = await _favoritesService.toggleFavorite(
      _currentSong.mp3,
    );

    if (!mounted) return;

    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _loadCurrentSong({
    required bool autoplay,
  }) async {
    if (_changingSong) return;

    _changingSong = true;
    unawaited(_loadFavoriteStatus());

    if (mounted) {
      setState(() {
        _error = null;
      });
    }

    try {
      await _player.stop();
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(_currentSong.mp3),
          tag: MediaItem(
            id: _currentSong.mp3,
            title: _currentSong.name,
            artist: widget.concert.artist,
            album: widget.concert.title,
            artUri: widget.concert.albumImage.isNotEmpty
                ? Uri.tryParse(widget.concert.albumImage)
                : null,
          ),
        ),
      );

      if (autoplay) {
        unawaited(_player.play());
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = error.toString();
        });
      }
    } finally {
      _changingSong = false;
    }
  }

  Future<void> _playPrevious() async {
    if (!_hasPrevious) return;

    setState(() {
      _currentIndex--;
    });

    await _loadCurrentSong(autoplay: true);
  }

  Future<void> _playNext() async {
    if (!_hasNext) {
      await _player.pause();
      await _player.seek(Duration.zero);
      return;
    }

    setState(() {
      _currentIndex++;
    });

    await _loadCurrentSong(autoplay: true);
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        foregroundColor: Colors.white,
        title: const Text('Reproduciendo'),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            tooltip: _isFavorite ? 'Quitar de favoritos' : 'Añadir a favoritos',
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.redAccent : Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.network(
                    widget.concert.albumImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: const Color(0xFF292929),
                        child: const Icon(
                          Icons.album,
                          color: Colors.white70,
                          size: 100,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                _currentSong.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.concert.artist,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_currentIndex + 1} de '
                '${widget.concert.songs.length}',
                style: const TextStyle(
                  color: Colors.white38,
                ),
              ),
              const SizedBox(height: 26),
              if (_error != null)
                Text(
                  'No se pudo reproducir:\n$_error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                )
              else
                _ProgressBar(
                  player: _player,
                  formatDuration: _formatDuration,
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _hasPrevious ? _playPrevious : null,
                    iconSize: 44,
                    color: Colors.white,
                    disabledColor: Colors.white24,
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                    ),
                  ),
                  const SizedBox(width: 24),
                  StreamBuilder<PlayerState>(
                    stream: _player.playerStateStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      final processingState = state?.processingState;
                      final playing = state?.playing ?? false;

                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return const SizedBox(
                          width: 76,
                          height: 76,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return IconButton.filled(
                        onPressed: () {
                          if (playing) {
                            _player.pause();
                          } else {
                            _player.play();
                          }
                        },
                        iconSize: 48,
                        padding: const EdgeInsets.all(14),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF9D00FF),
                          foregroundColor: Colors.white,
                        ),
                        icon: Icon(
                          playing
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 24),
                  IconButton(
                    onPressed: _hasNext ? _playNext : null,
                    iconSize: 44,
                    color: Colors.white,
                    disabledColor: Colors.white24,
                    icon: const Icon(
                      Icons.skip_next_rounded,
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.player,
    required this.formatDuration,
  });

  final AudioPlayer player;
  final String Function(Duration) formatDuration;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
      stream: player.durationStream,
      builder: (context, durationSnapshot) {
        final duration = durationSnapshot.data ?? Duration.zero;

        return StreamBuilder<Duration>(
          stream: player.positionStream,
          builder: (context, positionSnapshot) {
            var position = positionSnapshot.data ?? Duration.zero;

            if (position > duration) {
              position = duration;
            }

            final maximum = duration.inMilliseconds > 0
                ? duration.inMilliseconds.toDouble()
                : 1.0;

            return Column(
              children: [
                Slider(
                  value: position.inMilliseconds.toDouble().clamp(0.0, maximum),
                  max: maximum,
                  activeColor: const Color(0xFF9D00FF),
                  inactiveColor: Colors.white24,
                  onChanged: duration == Duration.zero
                      ? null
                      : (value) {
                          player.seek(
                            Duration(
                              milliseconds: value.round(),
                            ),
                          );
                        },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(position),
                        style: const TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                      Text(
                        formatDuration(duration),
                        style: const TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
