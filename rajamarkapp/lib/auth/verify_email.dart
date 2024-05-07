import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rajamarkapp/shared/verifyemail_module.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildDesktopLayout();
          } else {
            return _buildDesktopLayout();
            //return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: SvgPicture.asset(
                    'images/examIllustration.svg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 195, 202, 207),
                child: Center(
                  child: Container(
                    width: 400,
                    height: 500,

                    //make corner radius
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const Center(child: VerifyEmailModule()),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Image.asset(
            'images/3.png',
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
  }
}
