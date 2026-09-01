import 'package:flutter/material.dart';

import '../../models/catalog_models.dart';
import '../../services/catalog_service.dart';
import '../artist_concerts/artist_concerts_widget.dart';
import '../favorites/favorites_widget.dart';

class ArtistsWidget extends StatefulWidget {
  const ArtistsWidget({super.key});

  static const String routeName = 'artists';
  static const String routePath = '/artists';

  @override
  State<ArtistsWidget> createState() => _ArtistsWidgetState();
}

class _ArtistsWidgetState extends State<ArtistsWidget> {
  final CatalogService _catalogService = CatalogService();

  late Future<List<Artist>> _artistsFuture;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _artistsFuture = _catalogService.fetchArtists();
  }

  Future<void> _reload() async {
    setState(() {
      _artistsFuture = _catalogService.fetchArtists();
    });

    await _artistsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AJC Player',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Aadam Jacobs Collection Player',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 11,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Favoritos',
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FavoritesWidget(),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar artista',
                hintStyle: const TextStyle(
                  color: Colors.white54,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white54,
                ),
                filled: true,
                fillColor: const Color(0xFF202020),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Artist>>(
        future: _artistsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return _ErrorView(
              message: snapshot.error.toString(),
              onRetry: _reload,
            );
          }

          final artists = snapshot.data ?? [];
          final query = _searchText.trim().toLowerCase();

          final filteredArtists = query.isEmpty
              ? artists
              : artists.where((artist) {
                  return artist.name.toLowerCase().contains(query);
                }).toList();

          if (artists.isEmpty) {
            return const Center(
              child: Text(
                'No se encontraron artistas',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: filteredArtists.length,
              separatorBuilder: (_, __) {
                return const Divider(
                  color: Color(0xFF292929),
                  height: 1,
                );
              },
              itemBuilder: (context, index) {
                final artist = filteredArtists[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 6,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF7C4DFF),
                    foregroundColor: Colors.white,
                    child: Text(
                      artist.name.isNotEmpty
                          ? artist.name[0].toUpperCase()
                          : '?',
                    ),
                  ),
                  title: Text(
                    artist.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${artist.totalConcerts} conciertos',
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
                        builder: (_) => ArtistConcertsWidget(
                          artist: artist,
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

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off,
              color: Colors.white70,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'No se pudo cargar el catálogo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
