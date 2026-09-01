import 'package:flutter/material.dart';

import '../../components/cassette_icon.dart';
import '../../models/catalog_models.dart';
import '../../services/catalog_service.dart';
import '../about/about_app_dialog.dart';
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
  String _selectedGenre = 'All';
  bool _isGrid = false;

  static const _genres = [
    'All',
    'Rock',
    'Folk',
    'Electronic',
    'Country',
    'Jazz',
    'Hip-Hop',
    'Experimental',
    'Pop',
    'Classical',
    'World / Latin',
    'Blues',
    'Soul / R&B',
    'Other',
  ];

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

  void _openArtist(Artist artist) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ArtistConcertsWidget(artist: artist),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      drawer: _AppDrawer(onRefresh: _reload),
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
            tooltip: _isGrid ? 'Mostrar como lista' : 'Mostrar en 3 columnas',
            icon: Icon(_isGrid ? Icons.view_list_rounded : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
          ),
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
          preferredSize: const Size.fromHeight(128),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: TextField(
                  onChanged: (value) => setState(() => _searchText = value),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar artista o género',
                    hintStyle: const TextStyle(color: Colors.white54),
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
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  itemCount: _genres.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final genre = _genres[index];
                    final selected = genre == _selectedGenre;
                    return ChoiceChip(
                      label: Text(genre == 'All' ? 'Todos' : genre),
                      selected: selected,
                      selectedColor: const Color(0xFF8E24E9),
                      backgroundColor: const Color(0xFF252525),
                      side: BorderSide(
                        color:
                            selected ? const Color(0xFFB14CFF) : Colors.white24,
                      ),
                      labelStyle: const TextStyle(color: Colors.white),
                      onSelected: (_) {
                        setState(() => _selectedGenre = genre);
                      },
                    );
                  },
                ),
              ),
            ],
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

          final filteredArtists = artists.where((artist) {
            final matchesGenre = _selectedGenre == 'All' ||
                artist.primaryGenre == _selectedGenre ||
                artist.genres.any(
                  (genre) =>
                      genre.toLowerCase() == _selectedGenre.toLowerCase(),
                );
            final searchable = [
              artist.name,
              artist.primaryGenre,
              ...artist.genres,
            ].join(' ').toLowerCase();
            return matchesGenre &&
                (query.isEmpty || searchable.contains(query));
          }).toList();

          if (artists.isEmpty) {
            return const Center(
              child: Text(
                'No se encontraron artistas',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          if (filteredArtists.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 120),
                  Icon(Icons.search_off, color: Colors.white54, size: 48),
                  SizedBox(height: 12),
                  Center(
                    child: Text(
                      'No hay artistas para esta búsqueda',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: _isGrid
                ? GridView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: filteredArtists.length,
                    itemBuilder: (context, index) => _ArtistGridTile(
                      artist: filteredArtists[index],
                      onTap: () => _openArtist(filteredArtists[index]),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                    itemCount: filteredArtists.length,
                    separatorBuilder: (_, __) => const Divider(
                      color: Color(0xFF292929),
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final artist = filteredArtists[index];
                      return _ArtistListTile(
                        artist: artist,
                        onTap: () => _openArtist(artist),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

class _ArtistListTile extends StatelessWidget {
  const _ArtistListTile({required this.artist, required this.onTap});

  final Artist artist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      leading: const CassetteIcon(),
      title: Text(
        artist.name,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${artist.totalConcerts} conciertos · ${artist.primaryGenre}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white60),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      onTap: onTap,
    );
  }
}

class _ArtistGridTile extends StatelessWidget {
  const _ArtistGridTile({required this.artist, required this.onTap});

  final Artist artist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1B1B1B),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CassetteIcon(size: 40),
              const SizedBox(height: 8),
              Text(
                artist.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${artist.totalConcerts} conciertos',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white60, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer({required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF151515),
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 18),
              child: Row(
                children: [
                  CassetteIcon(size: 52),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AJC Player',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Aadam Jacobs Collection',
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.redAccent),
              title: const Text('Favoritos',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const FavoritesWidget()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh, color: Colors.white70),
              title: const Text(
                'Actualizar catálogo',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                await onRefresh();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFFB14CFF)),
              title: const Text(
                'Información de la app',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pop();
                showAjcAboutDialog(context);
              },
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Independent non-profit project',
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ),
          ],
        ),
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
