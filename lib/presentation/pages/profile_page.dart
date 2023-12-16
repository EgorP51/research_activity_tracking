import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_activity_tracking/data/database_service.dart';
import 'package:research_activity_tracking/presentation/pages/add_publication_page.dart';
import 'package:research_activity_tracking/presentation/pages/main_page.dart';
import 'package:research_activity_tracking/presentation/pages/scientific_publication_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/scientific_publication.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.user});

  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profile_page'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return MainPage(user: widget.user);
              },
            ));
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPublicationPage(
                    user: widget.user,
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
      body: FutureBuilder(
        future: DatabaseService().getData('scientists', widget.user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<ScientificPublication> list =
                ScientificPublication.parseFromSnapshot(
                    snapshot.data?['publications']);
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    '${widget.user.displayName}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${snapshot.data?['role']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'My publications: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ListView.builder(
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
                          subtitle: Text(
                            publication.publicationYear.toString(),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: CupertinoButton(
              color: Colors.black,
              onPressed: () {
                sendMessageToAdmin();
              },
              child: const Text('contact admin'),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessageToAdmin() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '63584ee@gmail.com',
      queryParameters: {
        'subject': 'subject',
        'body': 'body',
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }
}
