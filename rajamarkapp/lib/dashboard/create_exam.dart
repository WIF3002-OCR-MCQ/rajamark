import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/dashboard/answer_scheme_page.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/shared/top_row_widget.dart';
import 'package:rajamarkapp/const/constant.dart';
import 'package:rajamarkapp/state/ExamState.dart';

class CreateExamPage extends StatefulWidget {
  const CreateExamPage({Key? key}) : super(key: key);

  @override
  State<CreateExamPage> createState() => _CreateExamPageState();
}

class _CreateExamPageState extends State<CreateExamPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseCodeController = TextEditingController();
  final _sessionController = TextEditingController();

  void createExam() {
    Exam newExam = Exam(
      examId: "", // Firestore will auto-generate an ID
      title: _titleController.text,
      description: _descriptionController.text,
      courseCode: _courseCodeController.text,
      session: _sessionController.text,
      grades: [], // Initialize with an empty list of grades
      studentResults: [], // Initialize with an empty list of student results
      sampleAnswer: [], // Initialize with an empty list of sample answers
    );

    ExamState.to.addExam(newExam);
    // Clear form fields (optional)
    _titleController.clear();
    _descriptionController.clear();
    _courseCodeController.clear();
    _sessionController.clear();

    // Show success message or navigate back
    Get.snackbar("Success", "Exam Created!");
  }

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

            SizedBox(height: 20), // Add some spacing
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
                      child: Text(
                        "Exam Details",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                                    controller: _titleController,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     textFieldValue = value;
                                    //   });
                                    // },
                                    decoration: InputDecoration(
                                      hintText: 'Enter title here',
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
                                    controller: _descriptionController,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     textFieldValue = value;
                                    //   });
                                    // },
                                    decoration: InputDecoration(
                                      hintText: 'Enter description here',
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
                                    controller: _courseCodeController,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     textFieldValue = value;
                                    //   });
                                    // },
                                    decoration: InputDecoration(
                                      hintText: 'Enter course code here',
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
                                    controller: _sessionController,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     textFieldValue = value;
                                    //   });
                                    // },
                                    decoration: InputDecoration(
                                      hintText: 'Enter session here',
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
                                //=================================Right Part=====================
                                // Container(
                                //   decoration: BoxDecoration(
                                //     color:
                                //         Color(0xFF0074B7), // Background color
                                //     borderRadius: BorderRadius.circular(
                                //         8.0), // Rounded corners
                                //   ),
                                //   padding: EdgeInsets.all(20.0),
                                //   margin: EdgeInsets.all(20.0),
                                //   child: Text(
                                //     'Next',
                                //     style: TextStyle(
                                //       color: Colors.white, // Text color
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                            // Corrected placement of Row widget
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Grading System:',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7.0), // Adjust margin as needed
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // Added container for "Answer Scheme"
                      margin: EdgeInsets.all(20),
                      child: Text(
                        "Answer Scheme",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 1000,
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      margin:
                          EdgeInsets.symmetric(horizontal: 200, vertical: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffbfd7ed)),
                      child: const SizedBox(
                        width: 546,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              QuestionAnswers(
                                questionNum: 1,
                                selectedAnswer: "D",
                              ),
                              QuestionAnswers(
                                questionNum: 2,
                                selectedAnswer: "D",
                              ),
                              QuestionAnswers(
                                questionNum: 3,
                                selectedAnswer: "B",
                              ),
                              QuestionAnswers(
                                questionNum: 4,
                                selectedAnswer: "A",
                              ),
                              QuestionAnswers(
                                questionNum: 5,
                                selectedAnswer: "C",
                              ),
                              QuestionAnswers(
                                questionNum: 6,
                                selectedAnswer: "A",
                              ),
                              QuestionAnswers(
                                questionNum: 7,
                                selectedAnswer: "B",
                              ),
                              QuestionAnswers(
                                questionNum: 8,
                                selectedAnswer: "B",
                              ),
                              QuestionAnswers(
                                questionNum: 10,
                                selectedAnswer: "D",
                              ),
                              AddQuestion(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 300.0, vertical: 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to the previous page
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF0074B7),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.all(20.0),
                              margin: EdgeInsets.all(20.0),
                              child: Text(
                                "Back",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.white, // Text color
                                ),
                              ),
                            ),
                          ),
                          Spacer(), // Use Spacer widget to distribute space
                          GestureDetector(
                            onTap: () {
                              // Navigate to the next page
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    // Replace `AnswerSchemePage()` with the widget for your next page
                                    return AnswerSchemePage();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF0074B7),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.all(20.0),
                              margin: EdgeInsets.all(20.0),
                              child: Text(
                                "Save",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.white, // Text color
                                ),
                              ),
                            ),
                          ),
                        ],
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

class QuestionAnswers extends StatefulWidget {
  const QuestionAnswers({
    required this.questionNum,
    required this.selectedAnswer,
    Key? key,
  }) : super(key: key);

  final int questionNum;
  final String selectedAnswer;

  @override
  State<QuestionAnswers> createState() => _QuestionAnswersState();
}

class _QuestionAnswersState extends State<QuestionAnswers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 750,
        height: 70,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${widget.questionNum}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: AnswerSelection(
                          letter: "A",
                          fill: widget.selectedAnswer == "A",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: AnswerSelection(
                          letter: "B",
                          fill: widget.selectedAnswer == "B",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: AnswerSelection(
                          letter: "C",
                          fill: widget.selectedAnswer == "C",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: AnswerSelection(
                          letter: "D",
                          fill: widget.selectedAnswer == "D",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnswerSelection extends StatelessWidget {
  const AnswerSelection({
    required this.letter,
    required this.fill,
    Key? key,
  }) : super(key: key);

  final String letter;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fill ? correctColour : backgroundColor,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: SizedBox(
        width: 30,
        height: 25,
        child: Center(
          child: Text(letter),
        ),
      ),
    );
  }
}

class AddQuestion extends StatelessWidget {
  const AddQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 750,
        height: 70,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
                      iconSize: 30.0,
                    ),
                  ),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: Text("Click to add question"),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
