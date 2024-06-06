import 'package:flutter/material.dart';
import 'package:flutter_kraft/core/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts App'),
        ),
      ),
    );
  }
}
