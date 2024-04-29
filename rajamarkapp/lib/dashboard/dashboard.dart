import 'package:flutter/material.dart';
import 'package:rajamarkapp/shared/sidebar.dart';
import 'package:rajamarkapp/dashboard/exam.dart';
import 'package:rajamarkapp/dashboard/account.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Widget _currentContent = const ExamDashboard();

  void _showExamDashboard() {
    setState(() {
      _currentContent = const ExamDashboard();
    });
  }

  void _showAccountDashboard() {
    setState(() {
      _currentContent = const AccountDashboard();
    });
  }

  void _logout() {
    // TODO: Implement logout functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile layout
            return Column(
              children: [
                Sidebar(
                  onExamTap: _showExamDashboard,
                  onAccountTap: _showAccountDashboard,
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
                  onAccountTap: _showAccountDashboard,
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
