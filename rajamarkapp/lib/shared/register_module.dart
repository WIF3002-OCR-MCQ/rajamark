import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterModule extends StatefulWidget {
  const RegisterModule({Key? key}) : super(key: key);

  @override
  _RegisterModuleState createState() => _RegisterModuleState();
}

class _RegisterModuleState extends State<RegisterModule> {
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
              'Register With Us',
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
          const SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
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
              // TODO: Implement Register functionality.
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 114, 178),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              'Register',
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
