int _toInt(dynamic value) {
  if (value is int) return value;
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

class Song {
  const Song({
    required this.name,
    required this.duration,
    required this.durationIso,
    required this.mp3,
  });

  final String name;
  final String duration;
  final String durationIso;
  final String mp3;

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      name: json['nombre']?.toString() ?? '',
      duration: json['duracion']?.toString() ?? '',
      durationIso: json['duracion_iso']?.toString() ?? '',
      mp3: json['mp3']?.toString() ?? '',
    );
  }
}

class ConcertSummary {
  const ConcertSummary({
    required this.identifier,
    required this.title,
    required this.publicationDate,
    required this.year,
    required this.albumImage,
    required this.tracksCount,
    required this.url,
  });

  final String identifier;
  final String title;
  final String publicationDate;
  final String year;
  final String albumImage;
  final int tracksCount;
  final String url;

  factory ConcertSummary.fromJson(Map<String, dynamic> json) {
    return ConcertSummary(
      identifier: json['identifier']?.toString() ?? '',
      title: json['concierto']?.toString() ?? '',
      publicationDate: json['fecha_publicacion']?.toString() ?? '',
      year: json['year']?.toString() ?? '',
      albumImage: json['imagen_disco']?.toString() ?? '',
      tracksCount: _toInt(json['tracks_count']),
      url: json['url']?.toString() ?? '',
    );
  }
}

class Artist {
  const Artist({
    required this.name,
    required this.slug,
    required this.totalConcerts,
    required this.concerts,
  });

  final String name;
  final String slug;
  final int totalConcerts;
  final List<ConcertSummary> concerts;

  factory Artist.fromJson(Map<String, dynamic> json) {
    final concertList = json['concerts'] as List<dynamic>? ?? [];

    return Artist(
      name: json['artista']?.toString() ?? '',
      slug: json['artist_slug']?.toString() ?? '',
      totalConcerts: _toInt(json['total_concerts']),
      concerts: concertList
          .whereType<Map<String, dynamic>>()
          .map(ConcertSummary.fromJson)
          .toList(),
    );
  }
}

class FullConcert {
  const FullConcert({
    required this.identifier,
    required this.url,
    required this.title,
    required this.artist,
    required this.publicationDate,
    required this.albumImage,
    required this.songs,
  });

  final String identifier;
  final String url;
  final String title;
  final String artist;
  final String publicationDate;
  final String albumImage;
  final List<Song> songs;

  factory FullConcert.fromJson(Map<String, dynamic> json) {
    final songList = json['canciones'] as List<dynamic>? ?? [];

    return FullConcert(
      identifier: json['identifier']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      title: json['concierto']?.toString() ?? '',
      artist: json['artista']?.toString() ?? '',
      publicationDate: json['fecha_publicacion']?.toString() ?? '',
      albumImage: json['imagen_disco']?.toString() ?? '',
      songs: songList
          .whereType<Map<String, dynamic>>()
          .map(Song.fromJson)
          .toList(),
    );
  }
}

/// One song together with the concert it belongs to. This lets the player
/// continue across concert boundaries when an entire artist is selected.
class PlaybackTrack {
  const PlaybackTrack({
    required this.concert,
    required this.song,
  });

  final FullConcert concert;
  final Song song;
}
