import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rajamarkapp/dashboard/extract_page.dart';
import 'package:rajamarkapp/dashboard/student_answer.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/modal/Grade.dart';
import 'package:rajamarkapp/modal/StudentResult.dart';
import 'package:rajamarkapp/popups/delete_student_data.dart';
import 'package:rajamarkapp/popups/edit_result_popup.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rajamarkapp/state/ExamState.dart';

class ExamDetailsView extends StatefulWidget {
  const ExamDetailsView({Key? key, required this.examData}) : super(key: key);

  final Exam examData;

  @override
  State<ExamDetailsView> createState() => _CreateExamDetailsViewState();
}

class _CreateExamDetailsViewState extends State<ExamDetailsView> {
  late Exam examData;

  @override
  void initState() {
    super.initState();
    examData = widget.examData;
    initialiseGradeAndResult();
  }

  void initialiseGradeAndResult() async {
    examData = ExamState.to.exams
        .firstWhere((element) => element.examId == examData.examId);
    List<StudentResult> studentResult =
        await ExamState.to.getStudentResultByExamId(examData.examId);
    List<Grade> grade = await ExamState.to.getGradesByExamId(examData.examId);
    setState(() {
      examData.studentResults = studentResult;
      examData.grades = grade;
    });
    calculateMean();
    calculateMedian();
  }

  void calculateMean() {
    List<StudentResult> studentResults = examData.studentResults;
    if (examData.studentResults.isEmpty) return;

    //calculate mean score
    double totalScore = 0.0;
    for (var result in studentResults) {
      totalScore += result.score;
    }
    double meanScore = totalScore / studentResults.length;
    setState(() {
      examData.meanScore = meanScore;
    });
  }

  // Calculate median
  void calculateMedian() {
    List<StudentResult> studentResults = examData.studentResults;
    if (studentResults.isEmpty) return;

    double medianScore = 0.0;

    List<int> scores = studentResults.map((result) => result.score).toList();
    scores.sort();
    int middleIndex = (scores.length / 2).floor();
    if (scores.length % 2 == 0) {
      // Even number of scores
      medianScore = (scores[middleIndex - 1] + scores[middleIndex]) / 2;
    } else {
      // Odd number of scores
      medianScore = scores[middleIndex].toDouble();
    }
    setState(() {
      examData.medianScore = medianScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExtractPage(examData: examData),
                  ),
                ).then((_) => initialiseGradeAndResult());
              },
              icon: const Icon(Icons.remove_red_eye, color: Colors.white),
              label: Text(
                'View Answer',
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exam Title: ${examData.title}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Exam Description: ${examData.description}'),
                    Text('Course Code:  ${examData.courseCode}'),
                    Text('Session: ${examData.session}'),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 400,
                child: Center(
                  child: statisticWidget(examData),
                ),
              ),
              const SizedBox(height: 16.0),
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
                    flex: 2,
                    child: Text(
                      'Result',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Actions',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              examData.studentResults.isEmpty
                  ? const Center(
                      child: Text("No student data"),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: examData.studentResults.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.grey),
                      itemBuilder: (context, index) {
                        StudentResult result = examData.studentResults[index];
                        return studentResultRow(result, context);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget studentResultRow(StudentResult result, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            result.studentId,
            style: GoogleFonts.poppins(),
          ),
        ),
        Expanded(
          child: Text(
            result.studentName,
            style: GoogleFonts.poppins(),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            result.gradeLabel,
            style: GoogleFonts.poppins(),
          ),
        ),
        Expanded(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExtractPage(
                          examData: examData, currentStudentResult: result),
                    ),
                  ).then((_) => initialiseGradeAndResult());
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExtractPage(
                          examData: examData,
                          currentStudentResult: result,
                          isEditing: true),
                    ),
                  ).then((_) => initialiseGradeAndResult());
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        DeleteStudentDataPopup(onDelete: () async {
                      ExamState.to.removeStudentResult(result, widget.examData);
                      List<StudentResult> studentResult = await ExamState.to
                          .getStudentResultByExamId(examData.examId);
                      setState(() {
                        examData.studentResults = studentResult;
                      });
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget statisticWidget(Exam examData, bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MeanDonutChart(
          value: examData.meanScore,
          isSmallScreen: isSmallScreen,
        ),
        SizedBox(
          height: isSmallScreen ? 156 : 312,
          child: VerticalDivider(
            thickness: 2,
            width: 20,
            color: Color(0xff88899D),
          ),
        ),
        MedianDonutChart(
          value: examData.medianScore,
          isSmallScreen: isSmallScreen,
        ),
      ],
    );
  }
}

class MeanDonutChart extends StatefulWidget {
  const MeanDonutChart(
      {super.key, required this.value, required this.isSmallScreen});
  final double value;
  final bool isSmallScreen;

  @override
  State<MeanDonutChart> createState() => _MeanDonutChartState();
}

class _MeanDonutChartState extends State<MeanDonutChart> {
  @override
  Widget build(BuildContext context) {
    String percentage = '${widget.value.round()}%';
    Color getColor(double value) {
      if (value >= 80) {
        return const Color(0xff6fb293);
      } else if (value >= 50) {
        return const Color(0xffeec76b);
      } else {
        return const Color(0xffe54a50);
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: widget.isSmallScreen ? 156 : 362,
          height: widget.isSmallScreen ? 156 : 312,
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Mean Score',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                    height: widget.isSmallScreen ? 110 : 247,
                    width: widget.isSmallScreen ? 110 : 247,
                    child: Stack(
                      children: [
                        PieChart(PieChartData(
                            startDegreeOffset: 90,
                            sectionsSpace: 0,
                            sections: [
                              PieChartSectionData(
                                  value: widget.value,
                                  color: getColor(widget.value),
                                  radius: 40,
                                  showTitle: false),
                              PieChartSectionData(
                                  value: 100 - widget.value,
                                  color: Color(0xffF0E5FC),
                                  radius: widget.isSmallScreen ? 10 : 40,
                                  showTitle: false)
                            ])),
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: widget.isSmallScreen ? 75 : 180,
                                width: widget.isSmallScreen ? 75 : 150,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    percentage,
                                    style: TextStyle(
                                        fontSize:
                                            widget.isSmallScreen ? 20 : 40),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedianDonutChart extends StatefulWidget {
  const MedianDonutChart(
      {super.key, required this.value, required this.isSmallScreen});
  final double value;
  final bool isSmallScreen;

  @override
  State<MedianDonutChart> createState() => _MedianDonutChartState();
}

class _MedianDonutChartState extends State<MedianDonutChart> {
  @override
  Widget build(BuildContext context) {
    String percentage = '${widget.value.round()}%';
    Color getColor(double value) {
      if (value >= 80) {
        return const Color(0xff6fb293);
      } else if (value >= 50) {
        return const Color(0xffeec76b);
      } else {
        return const Color(0xffe54a50);
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: widget.isSmallScreen ? 156 : 362,
          height: widget.isSmallScreen ? 156 : 312,
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Median Score',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                    height: widget.isSmallScreen ? 110 : 247,
                    width: widget.isSmallScreen ? 110 : 247,
                    child: Stack(
                      children: [
                        PieChart(PieChartData(
                            startDegreeOffset: 90,
                            sectionsSpace: 0,
                            sections: [
                              PieChartSectionData(
                                  value: widget.value,
                                  color: getColor(widget.value),
                                  radius: 40,
                                  showTitle: false),
                              PieChartSectionData(
                                  value: 100 - widget.value,
                                  color: Color(0xffF0E5FC),
                                  radius: widget.isSmallScreen ? 10 : 40,
                                  showTitle: false)
                            ])),
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: widget.isSmallScreen ? 75 : 180,
                                width: widget.isSmallScreen ? 75 : 150,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    percentage,
                                    style: TextStyle(
                                        fontSize:
                                            widget.isSmallScreen ? 20 : 40),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
