import 'package:flutter/material.dart';
import 'package:research_activity_tracking/presentation/pages/auth_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Research Activity Tracking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const AuthPage();
    //   Scaffold(
    //   appBar: AppBar(
    //     title: const Text('КурСадЧ По ТИриПЫЗЫ'),
    //     backgroundColor: Colors.black,
    //     centerTitle: true,
    //   ),
    // );
  }
}
