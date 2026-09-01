import 'package:flutter/material.dart';
import '../concert_detail/concert_detail_widget.dart';
import '../../models/catalog_models.dart';

class ArtistConcertsWidget extends StatelessWidget {
  const ArtistConcertsWidget({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        foregroundColor: Colors.white,
        title: Text(artist.name),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: artist.concerts.length,
        separatorBuilder: (_, __) {
          return const Divider(
            color: Color(0xFF292929),
          );
        },
        itemBuilder: (context, index) {
          final concert = artist.concerts[index];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 58,
                height: 58,
                child: Image.network(
                  concert.albumImage,
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
              concert.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '${concert.publicationDate} · '
              '${concert.tracksCount} canciones',
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
                  builder: (_) => ConcertDetailWidget(
                    summary: concert,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
