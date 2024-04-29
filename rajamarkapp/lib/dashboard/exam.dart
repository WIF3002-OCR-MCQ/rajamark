import 'package:flutter/material.dart';

class ExamDashboardPage extends StatefulWidget {
  const ExamDashboardPage({Key? key}) : super(key: key);

  @override
  _ExamDashboardPageState createState() => _ExamDashboardPageState();
}

class _ExamDashboardPageState extends State<ExamDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Dashboard'),
      ),
      body: Container(),
    );
  }
}
