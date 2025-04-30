import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String link;
  final String imageUrl;

  const NewsCard({
    required this.title,
    required this.link,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: GestureDetector(
          onTap: () => {_launchURL(link)},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage.assetNetwork(
                  placeholder: "assets/images/flutter_logo.png",
                  image: imageUrl),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(link),
              ),
            ],
          ),
        ));
  }

  // Launches the URL in the default browser of the device
  Future<void> _launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
