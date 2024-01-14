import 'package:flutter/material.dart';
import 'package:research_activity_tracking/data/models/scientific_publication.dart';
import 'package:url_launcher/url_launcher.dart';

class ScientificPublicationPage extends StatelessWidget {
  const ScientificPublicationPage({
    super.key,
    required this.publication,
  });

  final ScientificPublication publication;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Публікація'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Title: ${publication.publicationTitle}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'year: ${publication.publicationYear}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 100),
            Center(
              child: InkWell(
                child: Column(
                  children: [
                    SizedBox.square(
                      dimension: 100,
                      child: Image.asset('assets/pdf-icon.png'),
                    ),
                    const Text(
                      'Download file',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                onTap: () async {
                  if (!await launchUrl(Uri.parse(publication.filePath ?? ''))) {
                    throw Exception(
                      'Could not launch ${publication.filePath ?? ''}',
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
