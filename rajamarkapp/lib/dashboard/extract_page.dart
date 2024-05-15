import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_vision/google_vision.dart' as gv;
import 'package:rajamarkapp/const/constant.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/modal/StudentInfo.dart';
import 'package:rajamarkapp/modal/StudentResult.dart';
import 'package:rajamarkapp/popups/delete_student_data.dart';
import 'package:rajamarkapp/state/ExamState.dart';
import 'package:rajamarkapp/utils/exam_calculation.dart';

enum ExamView { general, detail, edit, loading }

class ExtractPage extends StatefulWidget {
  const ExtractPage(
      {super.key,
      required this.examData,
      this.isEditing = false,
      this.currentStudentResult});
  final Exam examData;
  final bool? isEditing;
  final StudentResult? currentStudentResult;

  @override
  State<ExtractPage> createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  List<QuestionModal> sampleAnswerList = [];
  List<String> tempStudentAnswers = []; //Used for editing
  bool isAdding = false; //Used for adding student result manually

  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();

  ExamView currentView = ExamView.general;
  String? filePath = '';
  StudentResult? currentStudentResult;

  @override
  void initState() {
    super.initState();
    List<QuestionModal> tempList = List.generate(
      widget.examData.sampleAnswer.length,
      (index) => QuestionModal(
          questionNum: index + 1,
          selectedAnswer: widget.examData.sampleAnswer[index]),
    );
    sampleAnswerList = tempList;

    //Check if it is route from the studentList from exam view
    if (widget.currentStudentResult != null) {
      currentStudentResult = widget.currentStudentResult;
      currentView = ExamView.detail;
      studentNameController.text = currentStudentResult!.studentName;
      studentIdController.text = currentStudentResult!.studentId;
    }

    //Check if it is route from the edit button
    if (widget.isEditing!) {
      currentView = ExamView.edit;
      tempStudentAnswers = currentStudentResult!.answerText;
    }

    // print("${widget.examData.studentResults.length} student results");
  }

  void _uploadStudentData(BuildContext context) async {
    //Extract text from the image
    String? extracted = await _showFilePicker(context);
    if (extracted == null) {
      print("Error extracting text from image");
      return;
    }

    //Parse the extracted text
    StudentInfo studentInfo =
        parseInputString(extracted, sampleAnswerList.length);

    //Calculate the score and update student name and id
    studentNameController.text = studentInfo.studentName;
    studentIdController.text = studentInfo.studentID;
    int score = calculateScore(
        widget.examData.sampleAnswer, studentInfo.studentAnswers);

    // print("Id is ${studentInfo.studentID}");
    // print("Name is ${studentInfo.studentName}");
    // print("Answer is ${studentInfo.studentAnswers}");

    //Create a student result object
    StudentResult studentResult = StudentResult(
      studentId: studentInfo.studentID,
      examId: widget.examData.examId,
      studentName: studentInfo.studentName,
      score: score,
      answerText: studentInfo.studentAnswers,
      gradeLabel: calculateGrade(score, widget.examData),
      date: DateTime.now(),
    );

    //Check if the student is already uplaoded
    for (StudentResult result in widget.examData.studentResults) {
      if (result.examId == studentResult.examId &&
          result.studentId == studentResult.studentId) {
        print("Result Added before!");
        setState(() {
          currentView = ExamView.detail;
          currentStudentResult = studentResult;
        });
        return;
      }
    }
    //Add the student result to the exam state
    ExamState.to.addStudentResult(studentResult, widget.examData);

    //Change the current page state
    setState(() {
      currentView = ExamView.detail;
      currentStudentResult = studentResult;
    });
  }

  void _viewStudentDetails(StudentResult studentResult) {
    setState(() {
      currentView = ExamView.detail;
      currentStudentResult = studentResult;
      studentNameController.text = studentResult.studentName;
      studentIdController.text = studentResult.studentId;
    });
  }

  Future<String?> _showFilePicker(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    String? filePath = '';
    Uint8List? fileBytes;
    String? extracted;
    if (result != null) {
      setState(() {
        currentView = ExamView.loading;
      });
      if (kIsWeb) {
        // Handle web platform
        fileBytes = result.files.first.bytes;

        if (fileBytes != null) {
          // Convert Uint8List to ByteBuffer
          ByteBuffer buffer = fileBytes.buffer;
          gv.JsonImage jsonImage = gv.JsonImage.fromBuffer(buffer);

          // Assuming Google Vision can process JsonImage directly
          final String authString =
              await rootBundle.loadString('assets/auth/auth.json');
          final googleVision = await gv.GoogleVision.withJwt(authString);
          List<gv.EntityAnnotation> annotations =
              await googleVision.textDetection(jsonImage);
          extracted = annotations[0].description;
        }
      } else {
        // Handle non-web platforms
        filePath = result.files.single.path;

        if (filePath != null) {
          final String authString =
              await rootBundle.loadString('assets/auth/auth.json');
          final googleVision = await gv.GoogleVision.withJwt(authString);
          List<gv.EntityAnnotation> annotations = await googleVision
              .textDetection(gv.JsonImage.fromFilePath(filePath));
          extracted = annotations[0].description;
        }
      }
    }
    return extracted;
  }

  void back() {
    setState(() {
      currentView = ExamView.general;
      filePath = "";
      currentStudentResult = null;
    });
  }

  void _addStudentResult() {
    setState(() {
      isAdding = true;
      currentView = ExamView.edit;
      tempStudentAnswers =
          List.generate(sampleAnswerList.length, (index) => '');
    });
  }

  void _saveEditedStudentAnswer() {
    if (!isAdding) {
      //Performing editing function
      int score =
          calculateScore(widget.examData.sampleAnswer, tempStudentAnswers);
      String gradeLabel = calculateGrade(score, widget.examData);

      currentStudentResult!.score = score;
      currentStudentResult!.gradeLabel = gradeLabel;
      currentStudentResult!.studentName = studentNameController.text;
      currentStudentResult!.studentId = studentIdController.text;
      currentStudentResult!.answerText = tempStudentAnswers;

      ExamState.to.updateStudentResult(currentStudentResult!, widget.examData);

      setState(() {
        currentStudentResult!.score = score;
        currentStudentResult!.gradeLabel = gradeLabel;
        currentStudentResult!.studentName = studentNameController.text;
        currentStudentResult!.studentId = studentIdController.text;
        currentStudentResult!.answerText = tempStudentAnswers;
        currentView = ExamView.detail;
        tempStudentAnswers = [];
      });
    } else {
      //Performing adding function
      int score =
          calculateScore(widget.examData.sampleAnswer, tempStudentAnswers);
      String gradeLabel = calculateGrade(score, widget.examData);

      //Create a student result object
      StudentResult studentResult = StudentResult(
        studentId: studentIdController.text,
        examId: widget.examData.examId,
        studentName: studentNameController.text,
        score: score,
        answerText: tempStudentAnswers,
        gradeLabel: gradeLabel,
        date: DateTime.now(),
      );

      //Check if the student is already uplaoded
      for (StudentResult result in widget.examData.studentResults) {
        if (result.examId == studentResult.examId &&
            result.studentId == studentResult.studentId) {
          print("Result Added before!");
          setState(() {
            currentView = ExamView.detail;
            currentStudentResult = studentResult;
          });
          return;
        }
      }
      //Add the student result to the exam state
      ExamState.to.addStudentResult(studentResult, widget.examData);

      //Change the current page state
      setState(() {
        currentView = ExamView.detail;
        currentStudentResult = studentResult;
        tempStudentAnswers = [];
        isAdding = false;
      });
    }
  }

  void _deleteStudentResult() {
    ExamState.to.removeStudentResult(currentStudentResult!, widget.examData);
    setState(() {
      widget.examData.studentResults.remove(currentStudentResult);
      currentView = ExamView.general;
      currentStudentResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.examData.title)),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              answerScheme(),
              currentView == ExamView.general
                  ? allStudentList(widget.examData.studentResults)
                  : currentView == ExamView.loading
                      ? loadingScreen()
                      : uploadedImageView(filePath!),
            ],
          ),
        ));
  }

  Widget loadingScreen() {
    return Expanded(
      child: Column(
        children: [
          Text("", style: GoogleFonts.poppins(fontSize: 20)),
          const SizedBox(height: 16),
          Container(
              height: MediaQuery.of(context).size.height - 160,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffbfd7ed)),
              child: const Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }

  Widget answerScheme() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Answer Scheme", style: GoogleFonts.poppins(fontSize: 20)),
          const SizedBox(height: 16),
          Container(
            height: MediaQuery.of(context).size.height - 160,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffbfd7ed)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  currentView == ExamView.edit ? editingRow() : Container(),
                  ...sampleAnswerList.map((question) => questionAnswers(
                        question.questionNum,
                        question.selectedAnswer,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget editingRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          TextField(
            controller: studentNameController,
            decoration: const InputDecoration(
              hintText: 'Student Name',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10), // Changed the fill color
            ),
            style:
                const TextStyle(color: Colors.black), // Changed the text color
          ),
          const SizedBox(
              height: 16), // Added a SizedBox to separate the two TextFields
          TextField(
            controller: studentIdController,
            decoration: const InputDecoration(
              hintText: 'Student Id',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10), // Changed the fill color
            ),
            style:
                const TextStyle(color: Colors.black), // Changed the text color
          ),
        ],
      ),
    );
  }

  Widget questionAnswers(int questionNum, String sampleAnswer) {
    String? currentAnswer;
    try {
      currentAnswer = currentStudentResult?.answerText[questionNum - 1];
    } catch (e) {
      print('Error: $e');
    }
    List<String> abcd = ['A', 'B', 'C', 'D'];

    Color getColor(int questionNum, String answer, String sampleAnswer) {
      if (tempStudentAnswers.isNotEmpty &&
          questionNum <= tempStudentAnswers.length) {
        String currentAnswer = tempStudentAnswers[questionNum - 1];
        if (currentAnswer == answer) {
          return Colors.red.shade300;
        }
      }
      return backgroundColor;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question $questionNum',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 32,
            margin: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: currentView == ExamView.general
                      ? abcd
                          .map((element) => answerSelection(
                                element,
                                sampleAnswer == element
                                    ? correctColour
                                    : backgroundColor,
                                questionNum,
                              ))
                          .toList()
                      : currentView == ExamView.detail
                          ? abcd.map((element) {
                              Color color;
                              if (currentAnswer == element) {
                                color = sampleAnswer == element
                                    ? correctColour
                                    : Colors.red.shade300;
                              } else {
                                color = sampleAnswer == element
                                    ? correctColour
                                    : backgroundColor;
                              }
                              return answerSelection(
                                  element, color, questionNum);
                            }).toList()
                          : abcd
                              .map((element) => answerSelection(
                                    element,
                                    getColor(
                                        questionNum, element, sampleAnswer),
                                    questionNum,
                                  ))
                              .toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget studentAnswers(StudentResult studentResult) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _viewStudentDetails(studentResult),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Student ID: ${studentResult.studentId}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Name: ${studentResult.studentName}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget answerSelection(String letter, Color filledColor, int questionNum) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          if (currentView == ExamView.edit) {
            setState(() {
              tempStudentAnswers[questionNum - 1] = letter;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: filledColor,
            // color: isFilled ? correctColour : backgroundColor,
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

  //===========================================Right Section===========================================
  Widget uploadedImageView(String path) {
    try {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Students", style: GoogleFonts.poppins(fontSize: 20)),
            const SizedBox(height: 16),
            Container(
              height: MediaQuery.of(context).size.height - 160,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffbfd7ed)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    currentView == ExamView.detail
                        ? Row(
                            children: [
                              IconButton(
                                  onPressed: () => back(),
                                  icon: const Icon(Icons.arrow_back)),
                              Text(currentStudentResult?.studentName ?? "",
                                  style: GoogleFonts.poppins(fontSize: 20)),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      currentView = ExamView.edit;
                                      tempStudentAnswers =
                                          currentStudentResult!.answerText;
                                    });
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DeleteStudentDataPopup(
                                              onDelete: () {
                                                _deleteStudentResult();
                                              },
                                            ));
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          )
                        : Row(
                            children: [
                              Text(isAdding ? "Add student result" : "Editing",
                                  style: GoogleFonts.poppins(fontSize: 20)),
                              const Spacer(),
                              FilledButton.tonal(
                                  onPressed: () {
                                    setState(() {
                                      currentView = ExamView.detail;
                                    });
                                  },
                                  child: const Text("Cancel")),
                              const SizedBox(width: 8),
                              FilledButton(
                                  onPressed: () => _saveEditedStudentAnswer(),
                                  child: Text(isAdding ? "Add" : "Save")),
                            ],
                          ),
                    const SizedBox(height: 16),
                    filePath == ''
                        ? Text(
                            isAdding
                                ? "Fill the student details into the textfield on the left."
                                : "Student answer is extracted",
                            textAlign: TextAlign.start)
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: SizedBox(
                              child: Image.file(
                                File(path),
                                fit: BoxFit.cover,
                                width: double
                                    .infinity, // Set a specific width for the image
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      // print('Error loading image: $e');
      return const Text('Error loading image');
    }
  }

  Widget allStudentList(List<StudentResult> studentResults) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Students", style: GoogleFonts.poppins(fontSize: 20)),
          const SizedBox(height: 16),
          Container(
            height: MediaQuery.of(context).size.height - 160,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffbfd7ed)),
            child: SizedBox(
              width: 546,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...studentResults.map((results) => studentAnswers(results)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _uploadStudentData(context),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 50, color: Colors.grey),
                                Text(
                                  'Click to upload answer sheet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _addStudentResult(),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 50, color: Colors.grey),
                                Text(
                                  'Click to fill in manually',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Fill in student details'),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: studentNameController,
                decoration: const InputDecoration(
                  hintText: 'Student Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10), // Changed the fill color
                ),
                style: const TextStyle(
                    color: Colors.black), // Changed the text color
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: studentIdController,
                decoration: const InputDecoration(
                  hintText: 'Student Id',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10), // Changed the fill color
                ),
                style: const TextStyle(
                    color: Colors.black), // Changed the text color
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Treasury department'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('State department'),
            ),
          ],
        );
      },
    );
  }
}

class QuestionModal {
  final int questionNum;
  final String selectedAnswer;

  QuestionModal({required this.questionNum, required this.selectedAnswer});
}
