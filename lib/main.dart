import 'package:flutter/material.dart';

import 'screens/timer_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        canvasColor: Colors.blueGrey,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.pinkAccent,
        brightness: Brightness.dark,
      ),
      home: TimerScreen(),
    );
  }
}
