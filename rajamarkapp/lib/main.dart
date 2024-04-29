import 'package:flutter/material.dart';
import 'package:rajamarkapp/auth/forgot_pass.dart';
import 'package:rajamarkapp/dashboard/dashboard.dart';
import 'package:rajamarkapp/database/database.dart';
import 'package:rajamarkapp/dashboard/account.dart';
import 'package:rajamarkapp/dashboard/exam.dart';
import 'package:rajamarkapp/auth/register.dart';
import 'package:rajamarkapp/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitialization.initialize();
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
      ),
      initialRoute: '/dashboard',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => const ForgotPassPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
