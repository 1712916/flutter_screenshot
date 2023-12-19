import 'dart:io';

import 'package:flutter/material.dart';

import 'screenshot_listener/screenshot_listener.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ScreenShotListener _listener = ScreenShotListener.getInstance();

  String? text;

  @override
  void initState() {
    super.initState();

    _listener.addListener((path) {
      text = path;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }
}
