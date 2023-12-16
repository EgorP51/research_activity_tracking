import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_activity_tracking/data/auth_service.dart';
import 'package:research_activity_tracking/presentation/pages/admin_page.dart';
import 'package:research_activity_tracking/presentation/pages/profile_page.dart';
import 'package:research_activity_tracking/presentation/pages/scientific_adviser_page.dart';
import 'package:research_activity_tracking/presentation/pages/scientific_publication_page.dart';

import '../../data/database_service.dart';
import '../../data/models/scientific_publication.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.user});

  final User? user;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('main_page'),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                rebuildAllChildren(context);
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: DatabaseService().getAllDocuments('publications'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<ScientificPublication> list =
              ScientificPublication.parseFromSnapshot(snapshot.data);

              return RefreshIndicator(
                onRefresh: () async => rebuildAllChildren(context),
                child: Scrollbar(
                  child: ListView.builder(
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
                                builder: (context) =>
                                    ScientificPublicationPage(
                                      publication: publication,
                                    ),
                              ),
                            );
                          },
                          title: Text(publication.publicationTitle ?? ''),
                          subtitle:
                          Text(publication.publicationYear.toString()),
                          trailing: Text(
                            (publication.verified == true)
                                ? 'verified'
                                : 'not verified',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future: DatabaseService().getData('scientists', widget.user!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 70),
                    InkWell(
                      onTap: () {
                        if (snapshot.data?['role'] != 'user') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(user: widget.user!),
                            ),
                          );
                        }
                      },
                      child: const Icon(CupertinoIcons.person, size: 50),
                    ),
                    Text(snapshot.data?['displayName']),
                    if (snapshot.data?['role'] == 'admin')
                      CupertinoButton(
                        child: const Text('go to admin page'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminPage(),
                            ),
                          );
                        },
                      ),
                    if (snapshot.data?['role'] == 'scientific adviser')
                      CupertinoButton(
                        child: const Text('scientific adviser page'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (
                                  context) => const ScientificAdviserPage(),
                            ),
                          );
                        },
                      ),
                    const Spacer(),
                    CupertinoButton(
                        onPressed: () {}, child: const Text('Info about us')),
                    CupertinoButton(
                        onPressed: () {}, child: const Text('Privacy policy')),
                    IconButton(
                      onPressed: () {
                        AuthService().signOut();
                      },
                      icon: const Icon(Icons.login_rounded),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
