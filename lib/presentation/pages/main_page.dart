import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_activity_tracking/data/auth_service.dart';
import 'package:research_activity_tracking/presentation/pages/profile_page.dart';
import 'package:research_activity_tracking/presentation/pages/scientific_publication_page.dart';

import '../../data/models/scientific_publication.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key, required this.user});

  final User? user;

  // Выборка всех публикаций!!
  List<ScientificPublication> publications = List.generate(
    12,
    (index) => ScientificPublication(
      id: 123,
      publicationTitle: 'Scientific publication title',
      publicationYear: 2004,
      authorId: 123,
      fieldId: 123,
      filePath: 'filePath',
    ),
  );

  @override
  Widget build(BuildContext context) {
    // here list of scientific publication
    return Scaffold(
      appBar: AppBar(
        title: const Text('main_page'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(publications[index].publicationTitle),
            subtitle: Text(publications[index].publicationYear.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScientificPublicationPage(
                    publication: publications[index],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: publications.length,
      ),
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(user: user!),
                    ),
                  );
                },
                child: const Icon(CupertinoIcons.person, size: 50),
              ),
              Text(user?.displayName ?? 'user info'),
              IconButton(
                onPressed: () {
                  AuthService().signOut();
                },
                icon: const Icon(Icons.login_rounded),
              )
            ],
          ),
        ),
      ),
    );
  }
}
