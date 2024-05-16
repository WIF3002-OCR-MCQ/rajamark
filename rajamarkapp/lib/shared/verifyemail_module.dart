import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/auth/login.dart';

class VerifyEmailModule extends StatefulWidget {
  const VerifyEmailModule({Key? key}) : super(key: key);

  @override
  _VerifyEmailModuleState createState() => _VerifyEmailModuleState();
}

class _VerifyEmailModuleState extends State<VerifyEmailModule> {
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
              'Verify Email',
              style: GoogleFonts.poppins(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          Text(
            'Email Sent!',
            style: GoogleFonts.poppins(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Please check your email and open the link with the given instructions. Please check your spam folder if you did not receive it.',
            style: GoogleFonts.poppins(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement verify email functionality.
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 114, 178),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              'Continue',
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
