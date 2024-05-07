import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rajamarkapp/dashboard/student_answer.dart';
import 'package:rajamarkapp/popups/delete_student_data.dart';
import 'package:rajamarkapp/popups/edit_result_popup.dart';
import 'package:rajamarkapp/popups/sample_answer_first_popup.dart';
import 'package:rajamarkapp/popups/sample_answer_second_popup.dart';

import '../popups/delete_popup.dart';
import 'package:rajamarkapp/dashboard/file_picker.dart';

class ExamDetailsView extends StatelessWidget {
  final int examId;

  const ExamDetailsView({Key? key, required this.examId}) : super(key: key);

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
                    'Exam Title: ',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Exam Description: '),
                  Text('Course Code: '),
                  Text('Session: '),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 400,
              child: Center(
                child:
                    StatisticsWidget(), //Mean Score, Median Score with vertical divider
              ),
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
              child: ListView.separated(
                itemCount: 10, // Number of items
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'S${index + 101}', // Mock Student ID
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Student ${index + 1}', // Mock Student Name
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ['A', 'B', 'C', 'D', 'F'][index % 5], // Mock Result
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
                                        builder: (context) =>
                                            StudentAnswerPage()));
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
                                  builder: (context) =>
                                      DeleteStudentDataPopup(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MeanDonutChart(
          value: 77,
        ),
        SizedBox(
            height: 312,
            child: VerticalDivider(
              thickness: 2,
              width: 20,
              color: Color(0xff88899D),
            )),
        MedianDonutChart(
          value: 81,
        ),
      ],
    );
  }
}

class MeanDonutChart extends StatefulWidget {
  const MeanDonutChart({super.key, required this.value});
  final double value;
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
          width: 362,
          height: 312,
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
                    height: 247,
                    width: 247,
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
                                  radius: 40,
                                  showTitle: false)
                            ])),
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 180,
                                width: 150,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    percentage,
                                    style: const TextStyle(fontSize: 40),
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
  const MedianDonutChart({super.key, required this.value});
  final double value;

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
          width: 362,
          height: 312,
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
                    height: 247,
                    width: 247,
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
                                  radius: 40,
                                  showTitle: false)
                            ])),
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 180,
                                width: 150,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    percentage,
                                    style: const TextStyle(fontSize: 40),
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
