import 'package:flutter/material.dart';
import 'package:lowfidel/pages/home.dart';
import 'package:lowfidel/pages/upload.dart';
import 'package:lowfidel/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OCR App",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      color: Colors.white,
      routes: {
        MyRoutes.home: (context) => const HomePage(),
        MyRoutes.uploadpage: (context) => const UploadPage(),
      },
    );
  }
}
