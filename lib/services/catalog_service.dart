import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

import '../models/catalog_models.dart';

class CatalogService {
  static const String _baseUrl =
      'https://raw.githubusercontent.com/airsoto/vet/main/'
      'json/Aadam_Jacobs_Player_App';

  static const String _artistsUrl =
      '$_baseUrl/index_artists_genres_final_clean.json';

  static const String _bundledArtistsPath =
      'assets/jsons/index_artists_genres_final_clean.json';

  static const String _concertsUrl =
      '$_baseUrl/_index_todos_los_conciertos.json';

  static List<FullConcert>? _concertsCache;

  Future<List<Artist>> fetchArtists() async {
    late final List<dynamic> decoded;

    try {
      final response = await http.get(Uri.parse(_artistsUrl));
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }
      decoded = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    } catch (_) {
      final bundledJson = await rootBundle.loadString(_bundledArtistsPath);
      decoded = jsonDecode(bundledJson) as List<dynamic>;
    }

    return decoded.map((item) {
      return Artist.fromJson(
        Map<String, dynamic>.from(item as Map),
      );
    }).toList();
  }

  Future<List<FullConcert>> fetchAllConcerts() async {
    if (_concertsCache != null) {
      return _concertsCache!;
    }

    final response = await http.get(Uri.parse(_concertsUrl));

    if (response.statusCode != 200) {
      throw Exception(
        'No se pudo descargar el índice de conciertos: '
        '${response.statusCode}',
      );
    }

    final decoded = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    _concertsCache = decoded.map((item) {
      return FullConcert.fromJson(
        Map<String, dynamic>.from(item as Map),
      );
    }).toList();

    return _concertsCache!;
  }

  Future<FullConcert?> fetchConcertByIdentifier(
    String identifier,
  ) async {
    final concerts = await fetchAllConcerts();

    for (final concert in concerts) {
      if (concert.identifier == identifier) {
        return concert;
      }
    }

    return null;
  }
}
