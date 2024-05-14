import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rajamarkapp/dashboard/student_answer.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/modal/StudentResult.dart';
import 'package:rajamarkapp/popups/delete_student_data.dart';
import 'package:rajamarkapp/popups/edit_result_popup.dart';
import 'package:rajamarkapp/popups/sample_answer_first_popup.dart';
import 'package:rajamarkapp/popups/sample_answer_second_popup.dart';

import '../popups/delete_popup.dart';
import 'package:rajamarkapp/dashboard/file_picker.dart';

class ExamDetailsView extends StatelessWidget {
  final Exam examData;

  const ExamDetailsView({Key? key, required this.examData}) : super(key: key);

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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FilePickerPopup(
                        isUploadMode:
                            true); // Pass mode here if true, will show upload else will show extract
                  },
                );
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
            SizedBox(height: 16.0),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double width = constraints.maxWidth;
                final bool isSmallScreen = width < 700;

                return Container(
                  height: isSmallScreen ? 200 : 400,
                  child: Center(
                    child: statisticWidget(examData, isSmallScreen),
                  ),
                );
              },
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
                child: examData.studentResults.length == 0
                    ? const Center(
                        child: Text("No student data"),
                      )
                    : ListView.separated(
                        itemCount:
                            examData.studentResults.length, // Number of items
                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.grey),
                        itemBuilder: (context, index) {
                          StudentResult result = examData.studentResults[index];
                          return studentResultRow(result, context);
                        },
                      )),
          ],
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
            result.studentId,
            style: GoogleFonts.poppins(),
          ),
        ),
        Expanded(
          child: Text(
            result.gradeLabel,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentAnswerPage()));
                },
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditResultPopUp(),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteStudentDataPopup(),
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
