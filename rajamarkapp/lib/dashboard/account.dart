import 'package:flutter/material.dart';

class AccountDashboardPage extends StatefulWidget {
  const AccountDashboardPage({Key? key}) : super(key: key);

  @override
  _AccountDashboardPageState createState() => _AccountDashboardPageState();
}

class _AccountDashboardPageState extends State<AccountDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Dashboard'),
      ),
      body: Container(),
    );
  }
}
