import 'package:flutter/material.dart';

import '../../components/cassette_icon.dart';
import '../../models/catalog_models.dart';
import '../../services/catalog_service.dart';
import '../about/about_app_dialog.dart';
import '../artist_concerts/artist_concerts_widget.dart';
import '../favorites/favorites_widget.dart';
import '../player/player_widget.dart';

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
  Future<List<FullConcert>>? _concertsFuture;
  String _searchText = '';
  String _selectedGenre = 'All';
  bool _isGrid = false;
  bool _startingRadio = false;

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
    CatalogService.clearCache();
    setState(() {
      _artistsFuture = _catalogService.fetchArtists();
      _concertsFuture = null;
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

  void _onSearchChanged(String value) {
    setState(() {
      _searchText = value;
      if (value.trim().isNotEmpty) {
        _concertsFuture ??= _catalogService.fetchAllConcerts();
      }
    });
  }

  bool _matchesSelectedGenre(Artist artist) {
    return _selectedGenre == 'All' ||
        artist.primaryGenre.toLowerCase() == _selectedGenre.toLowerCase() ||
        artist.genres.any(
          (genre) => genre.toLowerCase() == _selectedGenre.toLowerCase(),
        );
  }

  Future<void> _playGenreRadio() async {
    if (_startingRadio) return;
    setState(() => _startingRadio = true);

    try {
      final results = await Future.wait([
        _artistsFuture,
        _catalogService.fetchAllConcerts(),
      ]);
      final artists = results[0] as List<Artist>;
      final concerts = results[1] as List<FullConcert>;
      final allowedArtists = artists
          .where(_matchesSelectedGenre)
          .map((artist) => artist.name)
          .toSet();
      final queue = <PlaybackTrack>[
        for (final concert in concerts)
          if (allowedArtists.contains(concert.artist))
            for (final song in concert.songs)
              PlaybackTrack(concert: concert, song: song),
      ];

      if (!mounted) return;
      if (queue.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No playable songs were found.')),
        );
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PlayerWidget(
            queue: queue,
            initialIndex: 0,
            startShuffled: true,
          ),
        ),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to start radio: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _startingRadio = false);
    }
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
            tooltip: _isGrid ? 'List view' : 'Three-column view',
            icon: Icon(_isGrid ? Icons.view_list_rounded : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
          ),
          IconButton(
            tooltip: 'Favourites',
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
                  onChanged: _onSearchChanged,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search artist, song or genre',
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
                  itemCount: _genres.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index == _genres.length) {
                      final label = _selectedGenre == 'All'
                          ? 'Shuffle all'
                          : '$_selectedGenre radio';
                      return ActionChip(
                        avatar: _startingRadio
                            ? const SizedBox.square(
                                dimension: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.radio, size: 18),
                        label: Text(label),
                        onPressed: _startingRadio ? null : _playGenreRadio,
                        backgroundColor: const Color(0xFF33203F),
                        side: const BorderSide(color: Color(0xFFB14CFF)),
                        labelStyle: const TextStyle(color: Colors.white),
                      );
                    }
                    final genre = _genres[index];
                    final selected = genre == _selectedGenre;
                    return ChoiceChip(
                      label: Text(genre),
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
            final matchesGenre = _matchesSelectedGenre(artist);
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
                'No artists found',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          if (query.isNotEmpty) {
            final concertsFuture =
                _concertsFuture ??= _catalogService.fetchAllConcerts();
            return _CatalogueSearchResults(
              query: query,
              artists: artists,
              matchingArtists: filteredArtists,
              selectedGenre: _selectedGenre,
              concertsFuture: concertsFuture,
              onOpenArtist: _openArtist,
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
                      'No results for this search',
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
        '${artist.totalConcerts} concerts · ${artist.primaryGenre}',
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
                '${artist.totalConcerts} concerts',
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

class _CatalogueSearchResults extends StatelessWidget {
  const _CatalogueSearchResults({
    required this.query,
    required this.artists,
    required this.matchingArtists,
    required this.selectedGenre,
    required this.concertsFuture,
    required this.onOpenArtist,
  });

  final String query;
  final List<Artist> artists;
  final List<Artist> matchingArtists;
  final String selectedGenre;
  final Future<List<FullConcert>> concertsFuture;
  final ValueChanged<Artist> onOpenArtist;

  bool _matchesGenre(Artist artist) {
    return selectedGenre == 'All' ||
        artist.primaryGenre.toLowerCase() == selectedGenre.toLowerCase() ||
        artist.genres.any(
          (genre) => genre.toLowerCase() == selectedGenre.toLowerCase(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FullConcert>>(
      future: concertsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 14),
                Text(
                  'Searching songs…',
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
                'Song search is temporarily unavailable.\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          );
        }

        final artistByName = <String, Artist>{
          for (final artist in artists) artist.name.toLowerCase(): artist,
        };
        final allowedArtists = artists
            .where(_matchesGenre)
            .map((artist) => artist.name.toLowerCase())
            .toSet();
        final tracks = <PlaybackTrack>[];

        for (final concert in snapshot.data ?? const <FullConcert>[]) {
          final artistKey = concert.artist.toLowerCase();
          if (!allowedArtists.contains(artistKey)) continue;
          final artist = artistByName[artistKey];
          final contextText = [
            concert.artist,
            concert.title,
            artist?.primaryGenre ?? '',
            ...?artist?.genres,
          ].join(' ').toLowerCase();

          for (final song in concert.songs) {
            if ('$contextText ${song.name.toLowerCase()}'.contains(query)) {
              tracks.add(PlaybackTrack(concert: concert, song: song));
            }
          }
        }

        if (matchingArtists.isEmpty && tracks.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search_off, color: Colors.white54, size: 48),
                SizedBox(height: 12),
                Text(
                  'No artists or songs found',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          );
        }

        const maximumVisibleSongs = 250;
        final visibleTracks = tracks.take(maximumVisibleSongs).toList();
        final items = <Widget>[];

        if (matchingArtists.isNotEmpty) {
          items.add(
            _SearchSectionTitle(
              title: 'Artists',
              count: matchingArtists.length,
            ),
          );
          items.addAll(
            matchingArtists.map(
              (artist) => _ArtistListTile(
                artist: artist,
                onTap: () => onOpenArtist(artist),
              ),
            ),
          );
        }

        if (tracks.isNotEmpty) {
          items.add(_SearchSectionTitle(title: 'Songs', count: tracks.length));
          for (var index = 0; index < visibleTracks.length; index++) {
            final track = visibleTracks[index];
            items.add(
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                leading: const Icon(
                  Icons.music_note_rounded,
                  color: Color(0xFFB14CFF),
                ),
                title: Text(
                  track.song.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${track.concert.artist} · ${track.concert.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white60),
                ),
                trailing: const Icon(
                  Icons.play_circle_fill_rounded,
                  color: Color(0xFF9D00FF),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PlayerWidget(
                      queue: tracks,
                      initialIndex: index,
                    ),
                  ),
                ),
              ),
            );
          }
          if (tracks.length > maximumVisibleSongs) {
            items.add(
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Showing the first $maximumVisibleSongs songs. Refine your search to narrow the results.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            );
          }
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          itemCount: items.length,
          separatorBuilder: (_, __) =>
              const Divider(color: Color(0xFF292929), height: 1),
          itemBuilder: (_, index) => items[index],
        );
      },
    );
  }
}

class _SearchSectionTitle extends StatelessWidget {
  const _SearchSectionTitle({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 18, 4, 8),
      child: Text(
        '$title ($count)',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
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
              title: const Text('Favourites',
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
                'Update catalog',
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
                'App info',
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
              'The catalog could not be loaded',
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
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
