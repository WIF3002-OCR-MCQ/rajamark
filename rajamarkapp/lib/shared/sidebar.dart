import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback onExamTap;
  final VoidCallback onAccountTap;
  final VoidCallback onLogoutTap;

  const Sidebar({
    Key? key,
    required this.onExamTap,
    required this.onAccountTap,
    required this.onLogoutTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MobileTopMenu(
            onExamTap: onExamTap,
            onAccountTap: onAccountTap,
            onLogoutTap: onLogoutTap,
          );
        } else {
          return Container(
            width: 200,
            color: const Color(0xFF0074B7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      'images/3.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 50),
                    ListTile(
                      title: Text(
                        'Exams',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onTap: onExamTap,
                    ),
                    ListTile(
                      title: Text(
                        'Account',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onTap: onAccountTap,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextButton(
                    onPressed: onLogoutTap,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF0074B7),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class MobileTopMenu extends StatefulWidget {
  final VoidCallback onExamTap;
  final VoidCallback onAccountTap;
  final VoidCallback onLogoutTap;

  const MobileTopMenu({
    Key? key,
    required this.onExamTap,
    required this.onAccountTap,
    required this.onLogoutTap,
  }) : super(key: key);

  @override
  _MobileTopMenuState createState() => _MobileTopMenuState();
}

class _MobileTopMenuState extends State<MobileTopMenu> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0074B7),
      child: Column(
        children: [
          ListTile(
            title: Image.asset(
              'images/3.png',
              width: 100,
              height: 100,
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Column(
              children: [
                ListTile(
                  title: Text(
                    'Exams',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: widget.onExamTap,
                ),
                ListTile(
                  title: Text(
                    'Account',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: widget.onAccountTap,
                ),
                ListTile(
                  title: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: widget.onLogoutTap,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
