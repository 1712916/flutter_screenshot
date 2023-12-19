import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screenshot_listener/screenshot_listener.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        AnotherPage.otherPageRoute: (context) => const AnotherPage(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScreenShotListener _listener = ScreenShotListener.getInstance();

  String? text;

  @override
  void initState() {
    super.initState();

    questPermissions();

    _listener.init();

    _listener.addListener((path) {
      text = path;
      setState(() {});
    });
  }

  void questPermissions() async {
    //android 13
    await Permission.photos.request();

    //android < 13
    //await Permission.storage.request();
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detect Screenshot Callback Example'),
      ),
      body: Center(
        child: text == null
            ? const Text(
                "Ready",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Image.file(File(text!)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AnotherPage.otherPageRoute);
        },
        child: const Icon(Icons.navigate_next_outlined),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  static const String otherPageRoute = "other";

  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Another Page"),
      ),
      body: Center(
        child: Container(
          color: Colors.orange,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
