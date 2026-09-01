import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/catalog_models.dart';
import '../../services/favorites_service.dart';
import '../../services/playback_controller.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({
    super.key,
    this.concert,
    this.initialIndex = 0,
    this.queue,
    this.startShuffled = false,
    this.useCurrentQueue = false,
  });

  const PlayerWidget.current({super.key})
      : concert = null,
        initialIndex = 0,
        queue = null,
        startShuffled = false,
        useCurrentQueue = true;

  final FullConcert? concert;
  final int initialIndex;
  final List<PlaybackTrack>? queue;
  final bool startShuffled;
  final bool useCurrentQueue;

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final PlaybackController _playback = PlaybackController.instance;
  late final AudioPlayer _player = _playback.player;
  final FavoritesService _favoritesService = FavoritesService();

  late List<PlaybackTrack> _queue;
  late int _currentIndex;

  bool _isFavorite = false;

  PlaybackTrack get _currentTrack =>
      _playback.currentTrack ?? _queue[_currentIndex];

  Song get _currentSong => _currentTrack.song;

  bool get _hasPrevious =>
      _playback.hasTrack ? _playback.hasPrevious : _currentIndex > 0;

  bool get _hasNext => _playback.hasTrack
      ? _playback.hasNext
      : _currentIndex < _queue.length - 1;

  @override
  void initState() {
    super.initState();

    _queue = widget.queue ??
        (widget.concert?.songs ?? const <Song>[])
            .map((song) => PlaybackTrack(concert: widget.concert!, song: song))
            .toList();
    if (_queue.isEmpty && widget.useCurrentQueue) {
      _queue = [_playback.currentTrack!];
    }
    _currentIndex = widget.initialIndex.clamp(0, _queue.length - 1).toInt();
    _playback.setFullPlayerOpen(true);
    _playback.addListener(_onPlaybackChanged);
    if (!widget.useCurrentQueue) {
      unawaited(
        _playback.playQueue(
          _queue,
          initialIndex: widget.initialIndex,
          shuffled: widget.startShuffled,
        ),
      );
    }
    unawaited(_loadFavoriteStatus());
  }

  void _onPlaybackChanged() {
    if (mounted) setState(() {});
  }

  void _toggleShuffle() {
    _playback.toggleShuffle();
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

  Future<void> _playPrevious() async {
    await _playback.playPrevious();
  }

  Future<void> _playNext() async {
    await _playback.playNext();
  }

  @override
  void dispose() {
    _playback.removeListener(_onPlaybackChanged);
    _playback.setFullPlayerOpen(false);
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) {
        _playback.setFullPlayerOpen(false);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0D0D),
          foregroundColor: Colors.white,
          title: const Text('Reproduciendo'),
          actions: [
            IconButton(
              onPressed: _toggleFavorite,
              tooltip:
                  _isFavorite ? 'Quitar de favoritos' : 'Añadir a favoritos',
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
                      _currentTrack.concert.albumImage,
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
                  _currentTrack.concert.artist,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_playback.currentIndex + 1} de ${_playback.queueLength}',
                  style: const TextStyle(
                    color: Colors.white38,
                  ),
                ),
                const SizedBox(height: 26),
                if (_playback.error != null)
                  Text(
                    'No se pudo reproducir:\n${_playback.error}',
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
                IconButton(
                  onPressed: _toggleShuffle,
                  tooltip: _playback.shuffleEnabled
                      ? 'Desactivar reproducción aleatoria'
                      : 'Reproducción aleatoria',
                  icon: Icon(
                    Icons.shuffle_rounded,
                    color: _playback.shuffleEnabled
                        ? const Color(0xFF9D00FF)
                        : Colors.white60,
                  ),
                ),
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
