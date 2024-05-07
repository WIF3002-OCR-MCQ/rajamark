import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/auth/forgot_pass.dart';
import 'package:rajamarkapp/auth/register.dart';
import 'package:rajamarkapp/auth/verify_email.dart';
import 'package:rajamarkapp/dashboard/dashboard.dart';
import 'package:rajamarkapp/shared/forgotpass_module.dart';
import 'package:rajamarkapp/shared/verifyemail_module.dart';

class LoginModule extends StatefulWidget {
  const LoginModule({Key? key}) : super(key: key);

  @override
  _LoginModuleState createState() => _LoginModuleState();
}

class _LoginModuleState extends State<LoginModule> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32.0),
          Center(
            child: Text(
              'Log in to start',
              style: GoogleFonts.poppins(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: GoogleFonts.poppins(),
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: GoogleFonts.poppins(),
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 114, 178),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              String email = _emailController.text;
              String password = _passwordController.text;

              // Print email and password to the terminal
              print('Email: $email');
              print('Password: $password');

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassPage()));
            },
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              //Go to Register Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            child: Text(
              'Don\'t have an account? Register here',
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
