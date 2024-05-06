import 'package:flutter/material.dart';
import 'package:lowfidel/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "OCR App",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      color: Colors.white,
      home: HomePage(),
    );
  }
}
