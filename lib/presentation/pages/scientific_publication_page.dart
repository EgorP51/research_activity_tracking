import 'package:flutter/material.dart';
import 'package:research_activity_tracking/data/models/scientific_publication.dart';

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
        title: const Text('publication_page'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(publication.publicationTitle),
            Text('{author: ${publication.authorId}}'),
            Text('year: ${publication.publicationYear}'),
            const SizedBox(height: 50),
            const Text('Content'),
            const Placeholder(),
          ],
        ),
      ),
    );
  }
}
