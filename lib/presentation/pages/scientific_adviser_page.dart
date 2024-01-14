import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_activity_tracking/data/database_service.dart';
import 'package:research_activity_tracking/presentation/pages/scientific_publication_page.dart';

import '../../data/models/scientific_publication.dart';

class ScientificAdviserPage extends StatelessWidget {
  const ScientificAdviserPage({super.key});

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('scientific_adviser_page'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              rebuildAllChildren(context);
            },
            icon: const Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: DatabaseService().getAllDocuments('publications'),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Publications: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  title: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    snapshot.data[index]['publicationTitle'] ??
                                        '',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CupertinoButton(
                                        child: const Text('read'),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ScientificPublicationPage(
                                                publication:
                                                    ScientificPublication
                                                        .fromJson(
                                                  snapshot.data[index],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      CupertinoButton(
                                        child: const Text('verify'),
                                        onPressed: () {
                                          DatabaseService().verifyPublication(
                                              snapshot.data[index]
                                                  ['publicationTitle']);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                            },
                          );
                        },
                        title: Text(
                            snapshot.data[index]['publicationTitle'] ?? ''),
                        subtitle:
                            Text(snapshot.data[index]['publicationYear'] ?? ''),
                      );
                    },
                  ),
                ),
                const Divider(),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
