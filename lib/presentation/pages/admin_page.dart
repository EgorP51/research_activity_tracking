import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/database_service.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

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
        title: const Text('admin_page'),
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
            future: DatabaseService().getAllDocuments('scientists'),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Scientists: ',
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
                                    title:
                                        const Text('set as scientific adviser'),
                                    actions: [
                                      CupertinoButton(
                                        child: const Text('yes'),
                                        onPressed: () {
                                          DatabaseService().changeUserRole(
                                              newRole: 'scientific adviser',
                                              userId: snapshot.data[index]
                                                  ['authorId']);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            title:
                                Text(snapshot.data[index]['displayName'] ?? ''),
                            subtitle: Text(snapshot.data[index]['role'] ?? ''),
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
          FutureBuilder(
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
                                    title: const Text('Delete publications: '),
                                    actions: [
                                      CupertinoButton(
                                        child: const Text('yes'),
                                        onPressed: () {
                                          DatabaseService().deletePublication(
                                            snapshot.data[index]
                                                ['publicationTitle'],
                                          );
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            title: Text(
                                snapshot.data[index]['publicationTitle'] ?? ''),
                            subtitle: Text(
                                snapshot.data[index]['publicationYear'] ?? ''),
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
        ],
      ),
    );
  }
}
