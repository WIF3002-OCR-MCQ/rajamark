import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    height: 400,
                    color: Colors.white,
                    child: const Center(
                      child: Text('Login Module'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            'images/3.png',
            width: 300,
            height: 300,
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
                Align(
                  alignment: Alignment.topLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.asset('images/3.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: FittedBox(
                      fit: BoxFit.contain,
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
            color: Color.fromARGB(255, 255, 255, 255),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                color: Colors.white,
                child: const Center(
                  child: Text('Login Module'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
