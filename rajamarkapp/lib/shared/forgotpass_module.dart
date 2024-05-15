import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:rajamarkapp/auth/verify_email.dart';

class ForgotPassModule extends StatefulWidget {
  const ForgotPassModule({Key? key}) : super(key: key);

  @override
  _ForgotPassModuleState createState() => _ForgotPassModuleState();
}

class _ForgotPassModuleState extends State<ForgotPassModule> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLinkSent = false;
String errorMessage = '';
  Future<void> _sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      setState(() {
        isLinkSent = true;
        errorMessage = '';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32.0),
          Center (
            child: Text(
              'Forgot Your Password?',
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
           if (isLinkSent)
            Center(
              child: Text(
                'Reset email link sent!',
                style: GoogleFonts.poppins(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: _sendPasswordResetEmail,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 114, 178),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              'Change Password',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                color: Colors.white,
              ),
              
            ),
          ),   
          const SizedBox(height: 32.0),   
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
