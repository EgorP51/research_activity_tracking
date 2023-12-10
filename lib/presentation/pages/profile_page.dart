import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_activity_tracking/data/database_service.dart';
import 'package:research_activity_tracking/presentation/pages/add_publication_page.dart';
import 'package:research_activity_tracking/presentation/pages/scientific_publication_page.dart';

import '../../data/models/scientific_publication.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profile_page'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPublicationPage(
                    user: user,
                  ),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.displayName}'),
            const SizedBox(height: 50),
            const Text('My publications: '),
            FutureBuilder(
              future: DatabaseService().getData('scientists', user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<ScientificPublication> list =
                      ScientificPublication.parseFromSnapshot(snapshot.data?['publications']);

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final publication = list[index];
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScientificPublicationPage(
                                  publication: publication,
                                ),
                              ),
                            );
                          },
                          title: Text(publication.publicationTitle ?? ''),
                          subtitle:
                              Text(publication.publicationYear.toString()),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
