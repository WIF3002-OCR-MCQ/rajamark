import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/GlobalService.dart';
import 'package:rajamarkapp/auth/forgot_pass.dart';
import 'package:rajamarkapp/dashboard/answer_scheme_page.dart';
import 'package:rajamarkapp/dashboard/create_exam.dart';
import 'package:rajamarkapp/dashboard/dashboard.dart';
import 'package:rajamarkapp/popups/processing.dart';
import 'package:rajamarkapp/database/database.dart';
import 'package:rajamarkapp/auth/register.dart';
import 'package:rajamarkapp/auth/login.dart';
import 'package:rajamarkapp/auth/verify_email.dart';
import 'package:rajamarkapp/state/ExamState.dart';
import 'package:rajamarkapp/state/GradeState.dart';
import 'package:rajamarkapp/state/StudentResultState.dart';
import 'package:rajamarkapp/state/UserState.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/foundation.dart';

import 'const/constant.dart';

void main() async {
  await FirebaseInitialization.initialize();
  WidgetsFlutterBinding.ensureInitialized();

  // await windowManager.ensureInitialized();
  Get.put<GlobalService>(GlobalService());
  Get.put<UserState>(UserState());
  Get.put<StudentResultState>(StudentResultState());
  Get.put<GradeState>(GradeState());
  Get.put<ExamState>(ExamState());

  // if (!kIsWeb && Platform.isWindows) {
  //   await WindowManager.instance.ensureInitialized();
  //   WindowManager.instance.setMinimumSize(const Size(1200, 850));
  // }
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => const ForgotPassPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/verify-email': (context) => const VerifyEmailPage(),
        '/createExamPage': (context) => const CreateExamPage(),
        '/answerSchemePage': (context) => const AnswerSchemePage(),
      },
    );
  }
}
