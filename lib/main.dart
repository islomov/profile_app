import 'package:flutter/material.dart';
import 'package:profile_app/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset:false,
        appBar: AppBar(title: Text("Profile App")),
        body: HomePage(),
      ),
    );
  }
}
