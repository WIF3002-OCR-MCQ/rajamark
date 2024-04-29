import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamDashboard extends StatelessWidget {
  const ExamDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width to conditionally render the search bar
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        if (screenWidth >=
            700) // Assuming 600px as the breakpoint for mobile view
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Search box on the top left
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search Exams',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                // User profile icon and name on the top right
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'John Doe',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://example.com/user_profile.jpg'), // Placeholder image URL
                        radius: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Page title "Exam"
              Text(
                'Exam',
                style: GoogleFonts.poppins(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // "Create" button with right next icon
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement create exam functionality
                },
                icon: Icon(Icons.add,
                    color:
                        const Color.fromARGB(255, 0, 0, 0)), // Dark blue icon
                label: Text(
                  'Create',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    // Dark blue text
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  backgroundColor: Color.fromARGB(255, 191, 215, 237),
                  padding: EdgeInsets.all(20), // More height
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 70, top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Name',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              Text('         Creation Date',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              Text('Actions',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 90),
            child: ListView.separated(
              itemCount: 20, // Assuming there are 10 dummy items for now
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left aligned Exam name
                      Expanded(
                        child: Text(
                          'Exam ${index + 1}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // Center aligned Date of exam
                      Expanded(
                        child: Text(
                          '15-04-2024', // Example date
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // Right aligned action icons
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                // TODO: Implement view functionality
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // TODO: Implement edit functionality
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // TODO: Implement delete functionality
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
