import 'package:flutter/material.dart';

import '../flutter_flow/nav/nav.dart';
import '../pages/player/player_widget.dart';
import '../services/playback_controller.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final playback = PlaybackController.instance;

    return AnimatedBuilder(
      animation: playback,
      builder: (context, _) {
        final track = playback.currentTrack;
        if (track == null || playback.fullPlayerOpen) {
          return const SizedBox.shrink();
        }

        return SafeArea(
          top: false,
          child: Material(
            color: const Color(0xFF1C1C1C),
            child: InkWell(
              onTap: () {
                appNavigatorKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (_) => const PlayerWidget(useCurrentQueue: true),
                  ),
                );
              },
              child: Container(
                height: 68,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFF3A3A3A)),
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: Image.network(
                          track.concert.albumImage,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.album,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            track.song.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            track.concert.artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: playback.togglePlayback,
                      icon: Icon(
                        playback.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: playback.hasNext ? playback.playNext : null,
                      icon: const Icon(Icons.skip_next_rounded),
                      color: Colors.white,
                      disabledColor: Colors.white24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
