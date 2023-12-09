import 'package:flutter/material.dart';

class AddPublicationPage extends StatelessWidget {
  const AddPublicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add new publication'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'УгА БугА',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
