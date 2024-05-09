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
        if (constraints.maxWidth < 700) {
          return MobileTopMenu(
            onExamTap: onExamTap,
            onAccountTap: onAccountTap,
            onLogoutTap: onLogoutTap,
          );
        } else {
          return Container(
            width: 200,
            color: const Color.fromARGB(255, 241, 243, 246),
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
                          color: const Color.fromARGB(255, 0, 0, 0),
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
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onTap: onAccountTap,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: onLogoutTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE54A50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Log out',
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
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
              const SizedBox(width: 16),
              Image.asset(
                'images/1.png',
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 8),
              Text(
                'RajaMark',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // TODO: Implement search functionality
                },
              ),
            ],
          ),
        ),
        if (_isExpanded)
          Container(
            color: Colors.white.withOpacity(0.8),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    Image.asset(
                      'images/1.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'RajaMark',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: widget.onExamTap,
                  child: Text(
                    'Exams',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: widget.onAccountTap,
                  child: Text(
                    'Account',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
