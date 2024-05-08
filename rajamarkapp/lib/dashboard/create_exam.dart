import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/dashboard/answer_scheme_page.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/modal/Grade.dart';
import 'package:rajamarkapp/shared/top_row_widget.dart';
import 'package:rajamarkapp/const/constant.dart';
import 'package:rajamarkapp/state/ExamState.dart';

class CreateExamPage extends StatefulWidget {
  const CreateExamPage({Key? key}) : super(key: key);

  @override
  State<CreateExamPage> createState() => _CreateExamPageState();
}

class QuestionModal {
  final int questionNum;
  final String selectedAnswer;

  QuestionModal({required this.questionNum, required this.selectedAnswer});
}

class GradeModal {
  final String grade;
  final int marks;

  GradeModal({required this.grade, required this.marks});
}

class _CreateExamPageState extends State<CreateExamPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseCodeController = TextEditingController();
  final _sessionController = TextEditingController();

  List<String> gradeName = [
    "A",
    "A-",
    "B+",
    "B",
    // "B-",
    // "C+",
    // "C",
    // "D",
    // "F",
  ];

  Map<String, List<TextEditingController>> gradeMap = {};

  // @override
  // void initState() {
  //   super.initState();
  //   gradeName.forEach((grade) {
  //     gradeMap[grade] = [TextEditingController(), TextEditingController()];
  //   });
  // }

  _CreateExamPageState() {
    gradeName.forEach((grade) {
      gradeMap[grade] = [TextEditingController(), TextEditingController()];
    });
  }

  List<QuestionModal> questionList = [
    QuestionModal(questionNum: 1, selectedAnswer: "D"),
    QuestionModal(questionNum: 2, selectedAnswer: "D"),
    QuestionModal(questionNum: 3, selectedAnswer: "B"),
    QuestionModal(questionNum: 4, selectedAnswer: "A"),
    QuestionModal(questionNum: 5, selectedAnswer: "C"),
    QuestionModal(questionNum: 6, selectedAnswer: "A"),
    QuestionModal(questionNum: 7, selectedAnswer: "B"),
    QuestionModal(questionNum: 8, selectedAnswer: "B"),
    QuestionModal(questionNum: 9, selectedAnswer: "C"),
    QuestionModal(questionNum: 10, selectedAnswer: "D"),
  ];

  void addQuestion() {
    questionList.add(QuestionModal(
        questionNum: questionList.length + 1, selectedAnswer: "A"));
    setState(() {});
  }

  void deleteQuestion(int questionNum) {
    questionList.removeWhere((element) => element.questionNum == questionNum);
    setState(() {});
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

  Future<void> createExam(BuildContext context) async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _courseCodeController.text.isEmpty ||
        _sessionController.text.isEmpty) {
      _dialogBuilder(context, "Error", "Please fill in all the details");
      return;
    }
    Random random = Random();
    int examIdint = random.nextInt(100001);
    String examId = "e$examIdint";

    List<String> sampleAnswers =
        questionList.map((question) => question.selectedAnswer).toList();

    List<Grade> grades = [];

    gradeName.forEach((grade) {
      int gradeIdInt = random.nextInt(100001);
      String gradeId = "g" + gradeIdInt.toString();

      grades.add(Grade(
          gradeId: gradeId,
          examId: examId.toString(),
          gradeLabel: grade,
          lowerScore: int.parse(gradeMap[grade]![0].text),
          upperScore: int.parse(gradeMap[grade]![1].text)));
    });

    Exam newExam = Exam(
        examId: examId.toString(), // Firestore will auto-generate an ID
        title: _titleController.text,
        description: _descriptionController.text,
        courseCode: _courseCodeController.text,
        session: _sessionController.text,
        grades: grades, // Initialize with an empty list of grades
        studentResults: [], // Initialize with an empty list of student results
        sampleAnswer: sampleAnswers);

    try {
      ExamState.to.addExam(newExam);
    } catch (e) {
      print("Error adding exam: $e");
      return;
    }

    await _dialogBuilder(context, "Added Success!", "Exam added successfully!");
    Navigator.of(context).pop();

    // Clear form fields (optional)
    // _titleController.clear();
    // _descriptionController.clear();
    // _courseCodeController.clear();
    // _sessionController.clear();
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
                      height: 800,
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
                                SizedBox(height: 20),
                                ...gradeName.map((grade) {
                                  return gradeRow(grade, gradeMap[grade]!);
                                }).toList(),
                              ],
                            ),
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
                      child: SizedBox(
                        width: 546,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...questionList
                                  .map((question) => questionAnswers(
                                        question.questionNum,
                                        question.selectedAnswer,
                                      ))
                                  .toList(),
                              ElevatedButton(
                                  onPressed: () => addQuestion(),
                                  child: Text("Add question")),
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
                              createExam(context);
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

  Widget gradeRow(String grade, List<TextEditingController> controllers) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(width: 32, child: Text(grade)),
          SizedBox(width: 10),
          SizedBox(
            width: 200,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers[0],

              decoration: const InputDecoration(
                hintText: 'Lower score',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 10), // Changed the fill color
              ),
              style: TextStyle(color: Colors.black), // Changed the text color
            ),
          ),
          SizedBox(width: 20),
          Text("-"),
          SizedBox(width: 20),
          SizedBox(
            width: 200,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers[1],
              decoration: const InputDecoration(
                hintText: 'Upper score',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 10), // Changed the fill color
              ),
              style: TextStyle(color: Colors.black), // Changed the text color
            ),
          ),
        ],
      ),
    );
  }

  Widget questionAnswers(int questionNum, String selectedAnswer) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 750,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Question $questionNum',
                      textAlign: TextAlign.left,
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
                          answerSelection(
                              "A", selectedAnswer == "A", questionNum),
                          answerSelection(
                              "B", selectedAnswer == "B", questionNum),
                          answerSelection(
                              "C", selectedAnswer == "C", questionNum),
                          answerSelection(
                              "D", selectedAnswer == "D", questionNum),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            IconButton(
                onPressed: () {
                  deleteQuestion(questionNum);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }

  Widget answerSelection(String letter, bool isFilled, int questionNum) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            questionList[questionNum - 1] =
                QuestionModal(questionNum: questionNum, selectedAnswer: letter);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isFilled ? correctColour : backgroundColor,
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
        ),
      ),
    );
  }
}
