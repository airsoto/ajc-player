import 'package:flutter/material.dart';
import '../concert_detail/concert_detail_widget.dart';
import '../player/player_widget.dart';
import '../../models/catalog_models.dart';
import '../../services/catalog_service.dart';

class ArtistConcertsWidget extends StatefulWidget {
  const ArtistConcertsWidget({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  State<ArtistConcertsWidget> createState() => _ArtistConcertsWidgetState();
}

class _ArtistConcertsWidgetState extends State<ArtistConcertsWidget> {
  final CatalogService _catalogService = CatalogService();
  bool _loadingArtistQueue = false;

  Future<void> _playArtist({required bool shuffled}) async {
    if (_loadingArtistQueue) return;

    setState(() => _loadingArtistQueue = true);
    try {
      final allConcerts = await _catalogService.fetchAllConcerts();
      final byIdentifier = {
        for (final concert in allConcerts) concert.identifier: concert,
      };
      final queue = <PlaybackTrack>[];
      for (final summary in widget.artist.concerts) {
        final concert = byIdentifier[summary.identifier];
        if (concert == null) continue;
        queue.addAll(
          concert.songs.map(
            (song) => PlaybackTrack(concert: concert, song: song),
          ),
        );
      }

      if (!mounted) return;
      if (queue.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay canciones disponibles.')),
        );
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PlayerWidget(
            concert: queue.first.concert,
            initialIndex: 0,
            queue: queue,
            startShuffled: shuffled,
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _loadingArtistQueue = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        foregroundColor: Colors.white,
        title: Text(widget.artist.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _loadingArtistQueue
                        ? null
                        : () => _playArtist(shuffled: false),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Reproducir artista'),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton.filledTonal(
                  onPressed: _loadingArtistQueue
                      ? null
                      : () => _playArtist(shuffled: true),
                  tooltip: 'Reproducir artista en aleatorio',
                  icon: _loadingArtistQueue
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.shuffle_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: widget.artist.concerts.length,
              separatorBuilder: (_, __) {
                return const Divider(color: Color(0xFF292929));
              },
              itemBuilder: (context, index) {
                final concert = widget.artist.concerts[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 58,
                      height: 58,
                      child: Image.network(
                        concert.albumImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: const Color(0xFF292929),
                            child: const Icon(
                              Icons.music_note,
                              color: Colors.white70,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  title: Text(
                    concert.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${concert.publicationDate} · '
                    '${concert.tracksCount} canciones',
                    style: const TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.white54,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ConcertDetailWidget(
                          summary: concert,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
