import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamDetailsView extends StatelessWidget {
  final int examId;

  const ExamDetailsView({Key? key, required this.examId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement upload answer functionality
              },
              icon: Icon(Icons.upload, color: Colors.white),
              label: Text(
                'Upload Answer',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width:
                  double.infinity, // Makes the Container span the entire width
              padding: const EdgeInsets.all(
                  16.0), // Keeps the text inside left-aligned
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Keeps the text left-aligned
                children: [
                  Text(
                    'Exam Title: ',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Exam Description: '),
                  Text('Course Code: '),
                  Text('Session: '),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 200.0,
              color: Colors.grey[200],
              child: Center(
                child: Text('Place for a widget'),
              ),
            ),
            SizedBox(height: 16.0),
            // Column headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Student ID',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Name',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Result',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  // Actions header takes more space due to buttons
                  flex: 2,
                  child: Text(
                    'Actions',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 10, // Number of items
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'S${index + 101}', // Mock Student ID
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Student ${index + 1}', // Mock Student Name
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ['A', 'B', 'C', 'D', 'F'][index % 5], // Mock Result
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                // View functionality
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Edit functionality
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Delete functionality
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
