import 'package:sound_flow/services/catalog_service.dart';

Future<void> main() async {
  final service = CatalogService();

  print('Descargando artistas...');
  final artists = await service.fetchArtists();
  print('Artistas recibidos: ${artists.length}');

  print('Descargando conciertos...');
  final concerts = await service.fetchAllConcerts();
  print('Conciertos recibidos: ${concerts.length}');

  if (artists.isNotEmpty) {
    print('Primer artista: ${artists.first.name}');
    print(
      'Conciertos del primer artista: '
      '${artists.first.concerts.length}',
    );
  }

  if (concerts.isNotEmpty) {
    print('Primer concierto: ${concerts.first.title}');
    print(
      'Canciones del primer concierto: '
      '${concerts.first.songs.length}',
    );
  }
}