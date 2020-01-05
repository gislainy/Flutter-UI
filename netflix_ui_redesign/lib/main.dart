import 'package:flutter/material.dart';
import 'package:netflix_ui_redesign/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix Redesign',
      home: HomeScreen(),
    );
  }
}
