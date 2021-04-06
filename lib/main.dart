import 'package:flutter/material.dart';
import 'package:timeline/const.dart';
import 'package:timeline/screens/Home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Line',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'Timeline'),
    );
  }
}
