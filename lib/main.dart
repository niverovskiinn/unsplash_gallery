import 'package:flutter/material.dart';
import 'package:unsplash_gallery/config/constants.dart' as Constants;
import 'package:unsplash_gallery/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.mainColor,
        primarySwatch: Constants.semiColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: Constants.title),
    );
  }
}
