import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/shared/top_row_widget.dart';

class CreateExamPage extends StatefulWidget {
  const CreateExamPage({Key? key}) : super(key: key);

  @override
  State<CreateExamPage> createState() => _CreateExamPageState();
}

class _CreateExamPageState extends State<CreateExamPage> {
  String textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TopRowWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: Text(
                "Create Exam",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.grey, // Customize the color of the divider
              thickness: 1, // Adjust the thickness of the divider
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: Text(
                "Exam Details",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20), // Add some spacing
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFBFD7ED),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50.0), // Adjusted spacing
                                  child: Text(
                                    'Exam Title: ',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50.0), // Adjusted spacing
                                  child: Text(
                                    'Exam Description: ',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50.0), // Adjusted spacing
                                  child: Text(
                                    'Course Code: ',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Session: ',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), // No space added below this text
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width:
                                      200, // Set the width of the text input box
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        textFieldValue = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your input here',
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              10), // Changed the fill color
                                    ),
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Changed the text color
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width:
                                      200, // Set the width of the text input box
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        textFieldValue = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your input here',
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              10), // Changed the fill color
                                    ),
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Changed the text color
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width:
                                      200, // Set the width of the text input box
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        textFieldValue = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your input here',
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              10), // Changed the fill color
                                    ),
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Changed the text color
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width:
                                      200, // Set the width of the text input box
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        textFieldValue = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your input here',
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              10), // Changed the fill color
                                    ),
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Changed the text color
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Save',
                                  ),
                                  color: Color(0xFF0074B7),
                                  padding: EdgeInsets.all(20.0),
                                  margin: EdgeInsets.all(20.0),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width:
                                      200, // Set the width of the text input box
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        textFieldValue = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your input here',
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              10), // Changed the fill color
                                    ),
                                    style: TextStyle(
                                        color: Colors
                                            .black), // Changed the text color
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Input: $textFieldValue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Second Container',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
