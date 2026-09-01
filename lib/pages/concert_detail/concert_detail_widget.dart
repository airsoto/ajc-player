import 'package:flutter/material.dart';

import '../../models/catalog_models.dart';
import '../../services/catalog_service.dart';
import '../../services/favorites_service.dart';
import '../player/player_widget.dart';

class ConcertDetailWidget extends StatefulWidget {
  const ConcertDetailWidget({
    super.key,
    required this.summary,
  });

  final ConcertSummary summary;

  @override
  State<ConcertDetailWidget> createState() {
    return _ConcertDetailWidgetState();
  }
}

class _ConcertDetailWidgetState extends State<ConcertDetailWidget> {
  final CatalogService _catalogService = CatalogService();

  late Future<FullConcert?> _concertFuture;

  @override
  void initState() {
    super.initState();

    _concertFuture = _catalogService.fetchConcertByIdentifier(
      widget.summary.identifier,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        foregroundColor: Colors.white,
        title: const Text('Concierto'),
      ),
      body: FutureBuilder<FullConcert?>(
        future: _concertFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Cargando canciones…',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudo cargar el concierto:\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          final concert = snapshot.data;

          if (concert == null) {
            return const Center(
              child: Text(
                'No se encontró el concierto',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _ConcertHeader(
                  concert: concert,
                  onPlayAlbum: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PlayerWidget(
                          concert: concert,
                          initialIndex: 0,
                        ),
                      ),
                    );
                  },
                  onShuffleAlbum: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PlayerWidget(
                          concert: concert,
                          initialIndex: 0,
                          startShuffled: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverList.separated(
                itemCount: concert.songs.length,
                separatorBuilder: (_, __) {
                  return const Divider(
                    color: Color(0xFF292929),
                    height: 1,
                  );
                },
                itemBuilder: (context, index) {
                  final song = concert.songs[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: SizedBox(
                      width: 32,
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      song.name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      song.duration,
                      style: const TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.play_circle_fill,
                      color: Color(0xFF9D00FF),
                      size: 34,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PlayerWidget(
                            concert: concert,
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ConcertHeader extends StatefulWidget {
  const _ConcertHeader({
    required this.concert,
    required this.onPlayAlbum,
    required this.onShuffleAlbum,
  });

  final FullConcert concert;
  final VoidCallback onPlayAlbum;
  final VoidCallback onShuffleAlbum;

  @override
  State<_ConcertHeader> createState() => _ConcertHeaderState();
}

class _ConcertHeaderState extends State<_ConcertHeader> {
  final FavoritesService _favoritesService = FavoritesService();
  bool _isFavoriteAlbum = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final isFavorite = await _favoritesService.isFavoriteAlbum(
      widget.concert.identifier,
    );
    if (mounted) setState(() => _isFavoriteAlbum = isFavorite);
  }

  Future<void> _toggleFavoriteAlbum() async {
    final isFavorite = await _favoritesService.toggleFavoriteAlbum(
      widget.concert.identifier,
    );
    if (mounted) setState(() => _isFavoriteAlbum = isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 220,
              height: 220,
              child: Image.network(
                widget.concert.albumImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: const Color(0xFF292929),
                    child: const Icon(
                      Icons.album,
                      color: Colors.white70,
                      size: 80,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.concert.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.concert.artist} · ${widget.concert.publicationDate}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${widget.concert.songs.length} canciones',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            children: [
              FilledButton.icon(
                onPressed: widget.onPlayAlbum,
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Reproducir álbum'),
              ),
              OutlinedButton.icon(
                onPressed: widget.onShuffleAlbum,
                icon: const Icon(Icons.shuffle_rounded),
                label: const Text('Aleatorio'),
              ),
              IconButton(
                onPressed: _toggleFavoriteAlbum,
                tooltip: _isFavoriteAlbum
                    ? 'Quitar álbum de favoritos'
                    : 'Añadir álbum a favoritos',
                icon: Icon(
                  _isFavoriteAlbum ? Icons.favorite : Icons.favorite_border,
                  color: _isFavoriteAlbum ? Colors.redAccent : Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
