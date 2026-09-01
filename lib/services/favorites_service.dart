import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _storageKey = 'favorite_song_urls';

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
}
