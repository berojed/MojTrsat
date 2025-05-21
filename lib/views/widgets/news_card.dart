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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color(0xFF23232E), 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _launchURL(link),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: imageUrl.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: "assets/images/flutter_logo.png",
                      image: imageUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: Colors.grey[850],
                        child: const Icon(Icons.broken_image, color: Colors.white38, size: 48),
                      ),
                    )
                  : Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey[850],
                      child: const Icon(Icons.image, color: Colors.white38, size: 48),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                link,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }




  // Launches the URL in the default browser of the device
  Future<void> _launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

}