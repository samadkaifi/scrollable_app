import 'package:flutter/material.dart';

import 'Screen/Home.dart';

void main() {
  runApp(ScrollableApp());
}

class ScrollableApp extends StatefulWidget {
  @override
  _ScrollableAppState createState() => _ScrollableAppState();
}

class _ScrollableAppState extends State<ScrollableApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: ScrollApp(

      ),
    );
  }
}
