import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/dashboard/create_exam.dart';
import 'package:rajamarkapp/dashboard/exam_detail.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/state/ExamState.dart';
import 'package:rajamarkapp/state/UserState.dart';

import '../popups/delete_popup.dart';

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
                    onChanged: (value) => ExamState.to.filterExams(value),
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
                        UserState.to.getUser()?.displayName ?? "Anonymous",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateExamPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.add,
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
              Text('Session',
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
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 90),
              child: Obx(
                () => ExamState.to.filteredExams.isEmpty
                    ? const Center(child: Text("No exam"))
                    : ListView.separated(
                        itemCount: ExamState.to.filteredExams.length,
                        separatorBuilder: (context, index) =>
                            const Divider(color: Colors.black),
                        itemBuilder: (context, index) {
                          final exam = ExamState.to.filteredExams[index];
                          return examListTile(context, exam);
                        },
                      ),
              )),
        ),
      ],
    );
  }

  Widget examListTile(BuildContext context, Exam examData) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              examData.title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          // Center aligned Date of exam
          Expanded(
            child: Text(
              examData.courseCode, // Example date
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
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExamDetailsView(examData: examData),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateExamPage(
                          examData: examData,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeletePopup(examData: examData),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
