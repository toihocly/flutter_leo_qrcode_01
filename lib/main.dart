import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/pages/my_history.dart';
import 'package:flutter_leo_qrcode_01/pages/my_home.dart';
import 'package:flutter_leo_qrcode_01/pages/my_scan.dart';
import 'package:flutter_leo_qrcode_01/theme/light_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: MyHome(),
      initialRoute: "/",
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        "/first": (final context) => const MyScanPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        "/second": (final context) => const MyHistoryPage(),
      },
    );
  }
}
