import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_activity_tracking/presentation/pages/add_publication_page.dart';

import '../../data/models/user.dart';

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
                  builder: (context) => const AddPublicationPage(),
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
            Text('${user.firstName} ${user.lastName}'),
            Text(user.role),
            const SizedBox(height: 50),
            const Text('My publications: '),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const SizedBox(
                  height: 80,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Placeholder(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
