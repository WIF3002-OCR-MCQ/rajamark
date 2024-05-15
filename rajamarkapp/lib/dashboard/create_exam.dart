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
  const CreateExamPage({Key? key, this.examData}) : super(key: key);

  final Exam? examData;

  @override
  State<CreateExamPage> createState() => _CreateExamPageState();
}

class _CreateExamPageState extends State<CreateExamPage> {
  bool isEditing = false;
  Random random = Random();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseCodeController = TextEditingController();
  final _sessionController = TextEditingController();

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

  List<String> gradeName = ["A", "A-", "B+", "B", "B-", "C+", "C", "D", "F"];

  Map<String, List<TextEditingController>> gradeMap = {};

  _CreateExamPageState() {
    gradeName.forEach((grade) {
      //0 is lowerscore, 1 is higherscore
      gradeMap[grade] = [TextEditingController(), TextEditingController()];

      switch (grade) {
        case "A":
          gradeMap[grade]![0].text = "90";
          gradeMap[grade]![1].text = "100";
          break;
        case "A-":
          gradeMap[grade]![0].text = "85";
          gradeMap[grade]![1].text = "89";
          break;
        case "B+":
          gradeMap[grade]![0].text = "80";
          gradeMap[grade]![1].text = "84";
          break;
        case "B":
          gradeMap[grade]![0].text = "75";
          gradeMap[grade]![1].text = "79";
          break;
        case "B-":
          gradeMap[grade]![0].text = "70";
          gradeMap[grade]![1].text = "74";
          break;
        case "C+":
          gradeMap[grade]![0].text = "65";
          gradeMap[grade]![1].text = "69";
          break;
        case "C":
          gradeMap[grade]![0].text = "60";
          gradeMap[grade]![1].text = "64";
          break;
        case "D":
          gradeMap[grade]![0].text = "50";
          gradeMap[grade]![1].text = "59";
          break;
        case "F":
          gradeMap[grade]![0].text = "0";
          gradeMap[grade]![1].text = "49";
          break;
        default:
          gradeMap[grade]![0].text = "0";
          gradeMap[grade]![1].text = "0";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.examData == null) {
      return;
    }

    isEditing = true;
    _titleController.text = widget.examData!.title;
    _descriptionController.text = widget.examData!.description;
    _courseCodeController.text = widget.examData!.courseCode;
    _sessionController.text = widget.examData!.session;

    widget.examData!.grades.forEach((grade) {
      gradeMap[grade.gradeLabel]![0].text = grade.lowerScore.toString();
      gradeMap[grade.gradeLabel]![1].text = grade.upperScore.toString();
    });

    questionList = widget.examData!.sampleAnswer
        .asMap()
        .entries
        .map((entry) => QuestionModal(
            questionNum: entry.key + 1, selectedAnswer: entry.value))
        .toList();

    setState(() {});
  }

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
  }

  Future<void> editExam(BuildContext context) async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _courseCodeController.text.isEmpty ||
        _sessionController.text.isEmpty) {
      _dialogBuilder(context, "Error", "Please fill in all the details");
      return;
    }
    String examId = widget.examData!.examId;

    List<String> sampleAnswers =
        questionList.map((question) => question.selectedAnswer).toList();

    List<Grade> grades = [];

    gradeName.forEach((grade) {
      var existingGrade = widget.examData!.grades.firstWhere(
        (element) => element.gradeLabel == grade,
        orElse: () => Grade(
          gradeId: "g${random.nextInt(100001)}",
          examId: examId.toString(),
          gradeLabel: grade,
          lowerScore: 0,
          upperScore: 0,
        ),
      );

      existingGrade.lowerScore = int.parse(gradeMap[grade]![0].text);
      existingGrade.upperScore = int.parse(gradeMap[grade]![1].text);

      grades.add(existingGrade);
    });

    Exam currentExam = Exam(
        examId: examId.toString(), // Firestore will auto-generate an ID
        title: _titleController.text,
        description: _descriptionController.text,
        courseCode: _courseCodeController.text,
        session: _sessionController.text,
        grades: grades, // Initialize with an empty list of grades
        studentResults: widget.examData!
            .studentResults, // Initialize with an empty list of student results
        sampleAnswer: sampleAnswers);

    try {
      ExamState.to.updateExam(currentExam);
    } catch (e) {
      print("Error updating exam: $e");
      return;
    }

    await _dialogBuilder(
        context, "Updated Success!", "Exam updated successfully!");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: TopRowWidget(),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackButton(),
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
                ],
              ),
              Divider(
                color: Colors.grey, // Customize the color of the divider
                thickness: 1, // Adjust the thickness of the divider
                height: 20.0,
              ),
              SizedBox(height: 20), // Add some spacing
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFBFD7ED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Exam Title: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: 'Enter title here',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Exam Description: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Enter description here',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Course Code: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: TextField(
                          controller: _courseCodeController,
                          decoration: InputDecoration(
                            hintText: 'Enter course code here',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Session: ',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        child: TextField(
                          controller: _sessionController,
                          decoration: InputDecoration(
                            hintText: 'Enter session here',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Grading System:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      ...gradeName.map((grade) {
                        return gradeRow(grade, gradeMap[grade]!);
                      }).toList(),
                    ],
                  ),
                ),
              ),
              Container(
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffbfd7ed),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...questionList
                          .map((question) => questionAnswers(
                                question.questionNum,
                                question.selectedAnswer,
                              ))
                          .toList(),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => addQuestion(),
                        child: Text("Add question"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Text(
                        "Back",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        isEditing ? editExam(context) : createExam(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF0074B7),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Text(
                        isEditing ? "Update" : "Save",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers[0],
              decoration: const InputDecoration(
                hintText: 'Lower score',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 20),
          Text("-"),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers[1],
              decoration: const InputDecoration(
                hintText: 'Upper score',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              style: TextStyle(color: Colors.black),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question $questionNum',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  answerSelection("A", selectedAnswer == "A", questionNum),
                  answerSelection("B", selectedAnswer == "B", questionNum),
                  answerSelection("C", selectedAnswer == "C", questionNum),
                  answerSelection("D", selectedAnswer == "D", questionNum),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              deleteQuestion(questionNum);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Widget answerSelection(String letter, bool isFilled, int questionNum) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            questionList[questionNum - 1] = QuestionModal(
              questionNum: questionNum,
              selectedAnswer: letter,
            );
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

class QuestionModal {
  final int questionNum;
  final String selectedAnswer;

  QuestionModal({required this.questionNum, required this.selectedAnswer});
}
