import 'package:flutter/material.dart';
import 'package:rajamarkapp/auth/login.dart';
import 'package:rajamarkapp/dashboard/user_manual.dart';
import 'package:rajamarkapp/shared/sidebar.dart';
import 'package:rajamarkapp/dashboard/exam.dart';
import 'package:rajamarkapp/dashboard/account.dart';
import 'package:rajamarkapp/state/ExamState.dart';
import 'package:rajamarkapp/state/UserState.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Widget _currentContent = const ExamDashboard();

  @override
  void initState() {
    super.initState();
    ExamState.to.getExams();
  }

  void _showExamDashboard() {
    setState(() {
      _currentContent = const ExamDashboard();
    });
  }

  void _userManualView() {
    setState(() {
      _currentContent = const UserManual();
    });
  }

  void _logout() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Log out'),
              onPressed: () {
                UserState.to.removeUser();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            // Mobile layout
            return Column(
              children: [
                Sidebar(
                  onExamTap: _showExamDashboard,
                  onManualTap: _userManualView,
                  onLogoutTap: _logout,
                ),
                Expanded(
                  child: _currentContent,
                ),
              ],
            );
          } else {
            // Desktop layout
            return Row(
              children: [
                Sidebar(
                  onExamTap: _showExamDashboard,
                  onManualTap: _userManualView,
                  onLogoutTap: _logout,
                ),
                Expanded(
                  child: _currentContent,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
