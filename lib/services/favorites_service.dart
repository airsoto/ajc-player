import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _storageKey = 'favorite_song_urls';
  static const String _albumStorageKey = 'favorite_concert_identifiers';

  Future<Set<String>> loadFavorites() async {
    final preferences = await SharedPreferences.getInstance();
    final values = preferences.getStringList(_storageKey) ?? [];

    return values.toSet();
  }

  Future<bool> isFavorite(String songUrl) async {
    final favorites = await loadFavorites();
    return favorites.contains(songUrl);
  }

  Future<bool> toggleFavorite(String songUrl) async {
    final preferences = await SharedPreferences.getInstance();
    final favorites = await loadFavorites();

    late final bool isNowFavorite;

    if (favorites.contains(songUrl)) {
      favorites.remove(songUrl);
      isNowFavorite = false;
    } else {
      favorites.add(songUrl);
      isNowFavorite = true;
    }

    await preferences.setStringList(
      _storageKey,
      favorites.toList(),
    );

    return isNowFavorite;
  }

  Future<Set<String>> loadFavoriteAlbums() async {
    final preferences = await SharedPreferences.getInstance();
    return (preferences.getStringList(_albumStorageKey) ?? []).toSet();
  }

  Future<bool> isFavoriteAlbum(String identifier) async {
    return (await loadFavoriteAlbums()).contains(identifier);
  }

  Future<bool> toggleFavoriteAlbum(String identifier) async {
    final preferences = await SharedPreferences.getInstance();
    final favorites = await loadFavoriteAlbums();
    final isNowFavorite = !favorites.contains(identifier);
    if (isNowFavorite) {
      favorites.add(identifier);
    } else {
      favorites.remove(identifier);
    }
    await preferences.setStringList(_albumStorageKey, favorites.toList());
    return isNowFavorite;
  }
}
