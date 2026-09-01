import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _aboutText =
    '''Aadam Jacobs, a Chicago-based music enthusiast, secretly recorded more than 10,000 live concerts from the 1980s onward, including early performances by artists such as Nirvana, R.E.M., The Cure, Pixies, Björk, and Sonic Youth.

His goal was never commercial. He simply wanted to preserve and share the experience of live music.

Since 2023, an international group of volunteers has been digitizing, restoring, and cataloguing his recordings, making them freely available through the Internet Archive.

The result is an extraordinary historical archive with significant cultural value. Although live recordings can sometimes raise copyright questions, many of the musicians involved have expressed support for the project.

Inspired by this remarkable effort, I wanted to express my admiration for Aadam Jacobs' work and my gratitude for the generosity of making such a vast collection of live recordings accessible to the public.

I created this app as a small, independent, non-profit project based on the Aadam Jacobs Collection.

The app allows users to explore concerts by artist and always links back to the original material hosted on the Internet Archive. Its purpose is simply to make the collection easier to discover, explore, and listen to, while helping to preserve and promote the extraordinary musical legacy represented by this archive.''';

const _aboutMeText =
    '''My name is Ángel Soto. I am a veterinarian, university lecturer, and independent developer based in Madrid, Spain. I enjoy creating small educational, scientific, and cultural digital projects in my spare time.''';

Future<void> showAjcAboutDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: const Color(0xFF181818),
      title: const Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFFB14CFF)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'About AJC Player',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      content: const SizedBox(
        width: 620,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                _aboutText,
                style: TextStyle(color: Colors.white70, height: 1.45),
              ),
              SizedBox(height: 12),
              _WebLink(
                label: 'Aadam Jacobs Collection',
                url: 'https://aadamjacobscollection.org/',
              ),
              _WebLink(
                label: 'Collection on Internet Archive',
                url: 'https://archive.org/details/@aadam_jacobs_collection',
              ),
              Divider(color: Colors.white24, height: 32),
              Text(
                'About me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              SelectableText(
                _aboutMeText,
                style: TextStyle(color: Colors.white70, height: 1.45),
              ),
              SizedBox(height: 12),
              _WebLink(
                label: 'More about my projects',
                url: 'https://airsoto.github.io/vet/',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

class _WebLink extends StatelessWidget {
  const _WebLink({required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () => launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        ),
        icon: const Icon(Icons.open_in_new, size: 18),
        label: Text(label),
      ),
    );
  }
}
