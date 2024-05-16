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

  final _auth = FirebaseAuth.instance;

  Future<void> _sendPasswordResetEmail() async {
    //Check if email is valid email
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text.trim());
    print(emailValid);
    if (!emailValid) {
      setState(() {
        errorMessage = 'Invalid email format';
      });
      return;
    }

    //Check if email exists in firebase auth

    try {
      await _auth.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      setState(() {
        isLinkSent = true;
        errorMessage = 'Reset email link sent!';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLinkSent = false;
        errorMessage = e.message ?? 'An error occurred';
      });
    } catch (e) {
      setState(() {
        isLinkSent = false;
        errorMessage = 'An unknown error occurred, please try again later.';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(),
              Text(
                'Forgot Your Password?',
                style: GoogleFonts.poppins(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
          isLinkSent
              ? const Text(
                  "Link sent! Check your email",
                  textAlign: TextAlign.start,
                )
              : Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.start,
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
