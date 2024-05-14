import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_vision/google_vision.dart' as gv;
import 'package:image_picker/image_picker.dart';
import 'package:rajamarkapp/const/constant.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/modal/StudentInfo.dart';
import 'package:rajamarkapp/modal/StudentResult.dart';
import 'package:rajamarkapp/utils/exam_calculation.dart';

enum ExamView { general, detail, edit }

class ExtractPage extends StatefulWidget {
  const ExtractPage({super.key, required this.examData});
  final Exam examData;

  @override
  State<ExtractPage> createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  List<QuestionModal> sampleAnswerList = [];
  List<StudentResult> studentResults = [];

  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();

  ExamView currentView = ExamView.general;
  String? filePath = '';
  StudentInfo? studentInfo;

  List<String> tempStudentAnswers = [];

  @override
  void initState() {
    super.initState();
    List<QuestionModal> tempList = List.generate(
      widget.examData.sampleAnswer.length,
      (index) => QuestionModal(
          questionNum: index + 1,
          selectedAnswer: widget.examData.sampleAnswer[index]),
    );

    setState(() {
      sampleAnswerList = tempList;
    });

    print("length is ${sampleAnswerList.length}");
  }

  void _uploadStudentData(BuildContext context) async {
    // String? path = await _showFilePicker(context);
    // if (path == null) {
    //   print("File is not picked!");
    //   return;
    // }
    // print("File picked");
    String? url;

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      await FirebaseStorage.instance.ref('uploads/upload.jpg').putData(bytes);
      url =
          await FirebaseStorage.instance.ref('uploads/upload.jpg').getDownloadURL();
    }

    String? extracted;

    print("Picked file path: ${url}");
    extracted = await FlutterTesseractOcr.extractText(url!, args: {
      "tessedit_char_whitelist":
          "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:. ",
      "preserve_interword_spaces": "1",
      "tessedit_pageseg_mode": "1",
    });

    print("Extracted text: $extracted");

    setState(() {
      currentView = ExamView.detail;
      studentInfo = parseInputString(extracted!);
    });

    // studentNameController.text = studentInfo!.studentName;
    // studentIdController.text = studentInfo!.studentID;

    // int score = calculateScore(
    //     widget.examData.sampleAnswer, studentInfo!.studentAnswers);

    // String? downloadUrl = await addImageToFirebase(
    //     File(path), "${studentInfo!.studentID}_${widget.examData.examId}");

    // print("File Uplaoded ${downloadUrl}");

    // //Upload to firestore cloud storage first to retrive the image url
    // //Then create a student result object

    // StudentResult studentResult = StudentResult(
    //   studentId: studentInfo!.studentID,
    //   examId: widget.examData.examId,
    //   studentName: studentInfo!.studentName,
    //   score: score,
    //   answerText: studentInfo!.studentAnswers,
    //   gradeLabel: calculateGrade(score, widget.examData),
    //   date: DateTime.now(),
    //   imgId: downloadUrl,
    // );

    // print(studentResult);
  }

  Future<String?> addImageToFirebase(File imageFile, String fileName) async {
    final destination = 'files/$fileName';
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('error occured');
    }
    return null;
  }

  // Future<String> saveStudentResultImage(File imageFile, String fileName) async {
  //   try {
  //     // String fileName =
  //     //     'result_${DateTime.now().millisecondsSinceEpoch}'; // Generate a unique file name for the image
  //     Reference storageReference =
  //         FirebaseStorage.instance.ref().child('student-answers/$fileName');
  //     UploadTask uploadTask = storageReference.putFile(imageFile);

  //     TaskSnapshot snapshot = await uploadTask;
  //     String downloadURL = await snapshot.ref.getDownloadURL();
  //     return downloadURL;
  //   } catch (e) {
  //     print('Error saving student result image: $e');
  //     throw e; // Rethrow the exception
  //   }
  // }

  Future<String?> _showFilePicker(BuildContext context) async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // filePath = result.files.single.path;
      String? extracted;

      // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      //   final String authString =
      //       await rootBundle.loadString('assets/auth/auth.json');
      //   final googleVision = await gv.GoogleVision.withJwt(authString);
      //   List<gv.EntityAnnotation> annotations = await googleVision
      //       .textDetection(gv.JsonImage.fromFilePath(filePath!));
      //   extracted = annotations[0].description;
      // } else {

      print("Picked file path: ${pickedFile.path}");
      extracted = await FlutterTesseractOcr.extractText(pickedFile.path, args: {
        "tessedit_char_whitelist":
            "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:. ",
        "preserve_interword_spaces": "1",
        "tessedit_pageseg_mode": "1",
      });
      // }

      setState(() {
        currentView = ExamView.detail;
        studentInfo = parseInputString(extracted!);
      });

      return filePath;

      // This is how to access student info object
      // StudentInfo studentInfo = parseInputString(extracted);
      // print('Student ID: ${studentInfo.studentID}');
      // print('Student Name: ${studentInfo.studentName}');
      // print('Student Answers:');
      // for (var answer in studentInfo.studentAnswers) {
      //   print(answer);
      // }
    }
    return null;
  }

  void back() {
    setState(() {
      currentView = ExamView.general;
      filePath = "";
      studentInfo = null;
    });
  }

  void _saveEditedStudentAnswer() {
    StudentInfo newStudentInfo = StudentInfo(
        studentName: studentNameController.text,
        studentID: studentIdController.text,
        studentAnswers: tempStudentAnswers);
    setState(() {
      studentInfo = newStudentInfo;
      currentView = ExamView.detail;
      tempStudentAnswers = [];
    });

    //TODO save the edited student answer to firestore
  }

  void _deleteStudentAnswer() {}

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
                  ? allStudentList(studentResults)
                  : uploadedImageView(filePath!),
            ],
          ),
        ));
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
    String? currentAnswer = studentInfo?.studentAnswers[questionNum - 1];
    List<String> abcd = ['A', 'B', 'C', 'D'];

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
                                    tempStudentAnswers[questionNum - 1] ==
                                            element
                                        ? Colors.red.shade300
                                        : backgroundColor,
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
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  children: [
                    currentView == ExamView.detail
                        ? Row(
                            children: [
                              IconButton(
                                  onPressed: () => back(),
                                  icon: const Icon(Icons.arrow_back)),
                              Text(studentInfo?.studentName ?? "",
                                  style: GoogleFonts.poppins(fontSize: 20)),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      currentView = ExamView.edit;
                                      tempStudentAnswers =
                                          studentInfo!.studentAnswers;
                                    });
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    _deleteStudentAnswer();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          )
                        : Row(
                            children: [
                              Text("Editing",
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
                                  child: const Text("Save")),
                            ],
                          ),
                    const SizedBox(height: 16),
                    Container(
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
                    )
                    // ElevatedButton(
                    //     onPressed: () => addQuestion(),
                    //     child: Text("Add question")),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionModal {
  final int questionNum;
  final String selectedAnswer;

  QuestionModal({required this.questionNum, required this.selectedAnswer});
}
