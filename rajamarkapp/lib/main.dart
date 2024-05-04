import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/auth/forgot_pass.dart';
import 'package:rajamarkapp/dashboard/dashboard.dart';
import 'package:rajamarkapp/database/database.dart';
import 'package:rajamarkapp/auth/register.dart';
import 'package:rajamarkapp/auth/login.dart';
import 'package:window_manager/window_manager.dart';

import 'const/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitialization.initialize();
  await windowManager.ensureInitialized();

  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(1200, 850));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RajaMark',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: backgroundColor,
          textTheme: GoogleFonts.poppinsTextTheme()),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => const ForgotPassPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
