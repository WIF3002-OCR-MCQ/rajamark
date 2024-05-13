import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_vision/google_vision.dart' as gv;
import 'package:rajamarkapp/const/constant.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/modal/StudentInfo.dart';
import 'package:rajamarkapp/modal/StudentResult.dart';
import 'package:rajamarkapp/utils/exam_calculation.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({super.key, required this.examData});
  final Exam examData;

  @override
  State<ExtractPage> createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  List<QuestionModal> questionList = [];
  List<StudentResult> studentResults = [];
  bool isDetailsView = false;
  String? filePath = '';
  StudentInfo? studentInfo;

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
      questionList = tempList;
    });

    print("length is ${questionList.length}");
  }

  void _uploadStudentData(BuildContext context) async {
    bool ispicked = await _showFilePicker(context);
    if (!ispicked) {
      print("File is not picked!");
      return;
    }
    print("File picked");

    String? downloadUrl = await saveStudentResultImage(
        File(filePath!), "${studentInfo!.studentID}_${widget.examData.examId}");
    if (downloadUrl == null) {
      print("File is not uploaded!");
      return;
    }
    print("File Uplaoded ${downloadUrl}");

    //Upload to firestore cloud storage first to retrive the image url
    //Then create a student result object

    int score = calculateScore(
        widget.examData.sampleAnswer, studentInfo!.studentAnswers);

    StudentResult studentResult = StudentResult(
      studentId: studentInfo!.studentID,
      examId: widget.examData.examId,
      studentName: studentInfo!.studentName,
      score: score,
      answerText: studentInfo!.studentAnswers,
      gradeLabel: calculateGrade(score, widget.examData),
      date: DateTime.now(),
      imgId: downloadUrl,
    );

    print(studentResult);
  }

  Future<String?> saveStudentResultImage(
      File imageFile, String fileName) async {
    try {
      print("bruh");
      // String fileName =
      //     'result_${DateTime.now().millisecondsSinceEpoch}'; // Generate a unique file name for the image
      print(fileName);
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('student-result-images/$fileName');
      print(storageReference.fullPath);
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error saving student result image: $e');
      return null;
    }
  }

  Future<bool> _showFilePicker(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      filePath = result.files.single.path;
      String? extracted;

      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        final String authString =
            await rootBundle.loadString('assets/auth/auth.json');
        final googleVision = await gv.GoogleVision.withJwt(authString);
        List<gv.EntityAnnotation> annotations = await googleVision
            .textDetection(gv.JsonImage.fromFilePath(filePath!));
        extracted = annotations[0].description;
      } else {
        extracted = await FlutterTesseractOcr.extractText(filePath!, args: {
          "tessedit_char_whitelist":
              "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:. ",
          "preserve_interword_spaces": "1",
          "tessedit_pageseg_mode": "1",
        });
      }
      setState(() {
        isDetailsView = true;
        studentInfo = parseInputString(extracted!);
      });

      return true;

      // This is how to access student info object
      // StudentInfo studentInfo = parseInputString(extracted);
      // print('Student ID: ${studentInfo.studentID}');
      // print('Student Name: ${studentInfo.studentName}');
      // print('Student Answers:');
      // for (var answer in studentInfo.studentAnswers) {
      //   print(answer);
      // }
    }
    return false;
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
              !isDetailsView
                  ? studentWidgetList(studentResults)
                  : studentAnswerFileWidget(filePath!),
            ],
          ),
        ));
  }

  Widget studentAnswerFileWidget(String path) {
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
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isDetailsView = false;
                              });
                            },
                            icon: Icon(Icons.arrow_back)),
                        Text(studentInfo?.studentName ?? "",
                            style: GoogleFonts.poppins(fontSize: 20)),
                        Spacer(),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
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
      print('Error loading image: $e');
      return Text('Error loading image');
    }
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

  Widget studentWidgetList(List<StudentResult> studentResults) {
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
                    ...studentResults
                        .map((results) => studentAnswers(results))
                        .toList(),
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

  Widget questionAnswers(int questionNum, String selectedAnswer) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question $questionNum',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 15,
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
                  children: [
                    answerSelection("A", selectedAnswer == "A", questionNum),
                    answerSelection("B", selectedAnswer == "B", questionNum),
                    answerSelection("C", selectedAnswer == "C", questionNum),
                    answerSelection("D", selectedAnswer == "D", questionNum),
                  ],
                ),
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

class QuestionModal {
  final int questionNum;
  final String selectedAnswer;

  QuestionModal({required this.questionNum, required this.selectedAnswer});
}
