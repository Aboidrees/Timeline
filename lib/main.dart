import 'package:flutter/material.dart';

import 'file:///D:/FLUTTER/timeline/lib/helpers/const.dart';
import 'file:///D:/FLUTTER/timeline/lib/screens/main_layout.dart';

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
