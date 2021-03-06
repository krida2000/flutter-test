
import 'package:flutter/material.dart';

import 'Components/user-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User screens!',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(bodyText1: TextStyle(fontSize: 25, fontFamily: "Montserrat"))
      ),
      home: UserScreen(title: 'User screen'),
    );
  }
}