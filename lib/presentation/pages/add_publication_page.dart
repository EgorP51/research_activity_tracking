import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_activity_tracking/data/database_service.dart';

class AddPublicationPage extends StatefulWidget {
  const AddPublicationPage({super.key, required this.user});

  final User user;

  @override
  State<AddPublicationPage> createState() => _AddPublicationPageState();
}

class _AddPublicationPageState extends State<AddPublicationPage> {
  PlatformFile? docFile;
  UploadTask? uploadTask;

  late final TextEditingController _publicationNameController;
  late final TextEditingController _publicationYearController;

  @override
  void initState() {
    _publicationNameController = TextEditingController();
    _publicationYearController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add new publication'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'УгА БугА',
                style: TextStyle(fontSize: 50),
              ),
              TextFormField(
                controller: _publicationNameController,
                decoration: const InputDecoration(
                  labelText: 'Publication title',
                ),
              ),
              TextFormField(
                controller: _publicationYearController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Publication year',
                ),
              ),
              const SizedBox(height: 30),
              if (docFile == null) ...[
                const Text('Add documentation\n(use pdf)'),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: Colors.black,
                    onPressed: () {
                      selectFile();
                    },
                    child: const Text('add file'),
                  ),
                ),
              ] else
                Text('Selected file:(${docFile!.name})'),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: CupertinoButton(
                  color: Colors.black,
                  onPressed: () {
                    uploadFile();
                  },
                  child: const Text('publish'),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      docFile = result.files.first;
    });
  }

  Future<void> uploadFile() async {
    final path = 'files/${docFile?.name}';
    final file = File(docFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask?.whenComplete(() {});

    final urlDownload = await snapshot?.ref.getDownloadURL();

    savePublication(urlDownload ?? '');
  }

  Future<void> savePublication(String filePath) async {
    final DatabaseService service = DatabaseService();

    Map<String, dynamic> publicationData = {
      'publicationTitle': _publicationNameController.text,
      'publicationYear': _publicationYearController.text,
      'authorId': widget.user.uid,
      'filePath': filePath,
      'verified': false,
    };

    await service.setData(
      'publications',
      _publicationNameController.text,
      publicationData,
    );

    service.addPublicationToScientist(
      scientistUid: widget.user.uid,
      publicationData: publicationData,
    );
  }
}
