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
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            // Assuming 700px as the breakpoint for mobile view
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
      floatingActionButton: screenWidth < 700 // Check if mobile view
          ? FloatingActionButton.extended(
              // label for extended fab
              label: const Text('Create Exam',
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.add),
              onPressed: () {
                // TODO: Implement create exam functionality
              },

              backgroundColor: Colors.blue, // Use your desired color
            )
          : null, // Do not show FAB in desktop view
    );
  }
}
