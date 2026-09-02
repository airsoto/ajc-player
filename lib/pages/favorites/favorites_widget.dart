import 'package:flutter/material.dart';

import '../../models/catalog_models.dart';
import '../../services/catalog_service.dart';
import '../../services/favorites_service.dart';
import '../player/player_widget.dart';
import 'favorite_albums_widget.dart';

class FavoritesWidget extends StatefulWidget {
  const FavoritesWidget({super.key});

  @override
  State<FavoritesWidget> createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  final CatalogService _catalogService = CatalogService();
  final FavoritesService _favoritesService = FavoritesService();

  late Future<List<_FavoriteSong>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = _loadFavorites();
  }

  Future<List<_FavoriteSong>> _loadFavorites() async {
    final favoriteUrls = await _favoritesService.loadFavorites();
    final concerts = await _catalogService.fetchAllConcerts();

    final favorites = <_FavoriteSong>[];

    for (final concert in concerts) {
      for (var index = 0; index < concert.songs.length; index++) {
        final song = concert.songs[index];

        if (favoriteUrls.contains(song.mp3)) {
          favorites.add(
            _FavoriteSong(
              concert: concert,
              song: song,
              index: index,
            ),
          );
        }
      }
    }

    return favorites;
  }

  Future<void> _reload() async {
    setState(() {
      _favoritesFuture = _loadFavorites();
    });

    await _favoritesFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        foregroundColor: Colors.white,
        title: const Text('Favourites'),
        actions: [
          IconButton(
            tooltip: 'Favourite albums',
            icon: const Icon(Icons.album_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const FavoriteAlbumsWidget(),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<_FavoriteSong>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Favourites could not be loaded:\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          final favorites = snapshot.data ?? [];

          if (favorites.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Colors.white54,
                      size: 56,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'You do not have any favourite songs yet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: favorites.length,
              separatorBuilder: (_, __) {
                return const Divider(
                  color: Color(0xFF292929),
                  height: 1,
                );
              },
              itemBuilder: (context, index) {
                final favorite = favorites[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 6,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        favorite.concert.albumImage,
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
                    favorite.song.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${favorite.concert.artist} · '
                    '${favorite.song.duration}',
                    style: const TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.play_circle_fill,
                    color: Color(0xFF9D00FF),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PlayerWidget(
                          concert: favorite.concert,
                          initialIndex: favorite.index,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _FavoriteSong {
  const _FavoriteSong({
    required this.concert,
    required this.song,
    required this.index,
  });

  final FullConcert concert;
  final Song song;
  final int index;
}
