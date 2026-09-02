import 'package:flutter/material.dart';

import '../../models/catalog_models.dart';
import '../../services/catalog_service.dart';
import '../../services/favorites_service.dart';
import '../concert_detail/concert_detail_widget.dart';

class FavoriteAlbumsWidget extends StatefulWidget {
  const FavoriteAlbumsWidget({super.key});

  @override
  State<FavoriteAlbumsWidget> createState() => _FavoriteAlbumsWidgetState();
}

class _FavoriteAlbumsWidgetState extends State<FavoriteAlbumsWidget> {
  final CatalogService _catalogService = CatalogService();
  final FavoritesService _favoritesService = FavoritesService();
  late Future<List<FullConcert>> _albumsFuture;

  @override
  void initState() {
    super.initState();
    _albumsFuture = _loadAlbums();
  }

  Future<List<FullConcert>> _loadAlbums() async {
    final identifiers = await _favoritesService.loadFavoriteAlbums();
    final concerts = await _catalogService.fetchAllConcerts();
    return concerts
        .where((concert) => identifiers.contains(concert.identifier))
        .toList();
  }

  Future<void> _reload() async {
    setState(() => _albumsFuture = _loadAlbums());
    await _albumsFuture;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0D0D),
          foregroundColor: Colors.white,
          title: const Text('Favourite albums'),
        ),
        body: FutureBuilder<List<FullConcert>>(
          future: _albumsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final albums = snapshot.data ?? [];
            if (albums.isEmpty) {
              return const Center(
                child: Text(
                  'You do not have any favourite albums yet.',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: albums.length,
                separatorBuilder: (_, __) =>
                    const Divider(color: Color(0xFF292929)),
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 56,
                        width: 56,
                        child: Image.network(
                          album.albumImage,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.album,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      album.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${album.artist} · ${album.songs.length} songs',
                      style: const TextStyle(color: Colors.white60),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.white54,
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ConcertDetailWidget(
                          summary: ConcertSummary(
                            identifier: album.identifier,
                            title: album.title,
                            publicationDate: album.publicationDate,
                            year: '',
                            albumImage: album.albumImage,
                            tracksCount: album.songs.length,
                            url: album.url,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
}
