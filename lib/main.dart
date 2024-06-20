import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'groups.dart';
import 'welcome.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

