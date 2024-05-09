import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rajamarkapp/shared/login_module.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/dashboard/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
                      child: Center(
                          child: LoginModule(dialogBuilder: _dialogBuilder)),
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

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/1.png',
                      width: 60,
                      height: 60,
                    ),
                    Text(
                      'RajaMark',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: SvgPicture.asset(
                        'images/examIllustration.svg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 700,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child:
                      Center(child: LoginModule(dialogBuilder: _dialogBuilder)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
