import 'package:flutter/material.dart';

class tuika extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<tuika> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('予定編集'),
        ),
        body: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}