import 'package:rajamarkapp/modal/Grade.dart';
import 'package:rajamarkapp/modal/StudentResult.dart';

class Exam {
  String examId;
  String title;
  String description;
  String courseCode;
  String session;
  List<String> sampleAnswer;
  double meanScore;
  double medianScore;
  List<Grade> grades;
  List<StudentResult> studentResults;

  Exam({
    required this.examId,
    required this.title,
    required this.description,
    required this.courseCode,
    required this.session,
    required this.sampleAnswer,
    this.meanScore = 0.0,
    this.medianScore = 0.0,
    required this.grades,
    required this.studentResults,
  });

  Exam.fromJson(Map<String, dynamic> json)
      : examId = json['examId'],
        title = json['title'],
        description = json['description'],
        courseCode = json['courseCode'],
        session = json['session'],
        sampleAnswer = (json['sampleAnswer'] as List).cast<String>(),
        meanScore = json['meanScore'],
        medianScore = json['medianScore'],
        grades =
            (json['grades'] as List).map((g) => Grade.fromJson(g)).toList(),
        studentResults = (json['studentResults'] as List)
            .map((r) => StudentResult.fromJson(r))
            .toList();

  Map<String, dynamic> toJson() => {
        'examId': examId,
        'title': title,
        'description': description,
        'courseCode': courseCode,
        'session': session,
        'sampleAnswer': sampleAnswer,
        'meanScore': meanScore,
        'medianScore': medianScore,
        'grades': grades.map((g) => g.toJson()).toList(),
        'studentResults': studentResults.map((r) => r.toJson()).toList(),
      };

  void calculateMean() {
    if (studentResults.isEmpty) {
      meanScore = 0.0;
    } else {
      double totalScore = 0.0;
      for (var result in studentResults) {
        totalScore += result.score;
      }
      meanScore = totalScore / studentResults.length;
    }
  }

  // Calculate median
  void calculateMedian() {
    if (studentResults.isEmpty) {
      medianScore = 0.0;
    } else {
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
    }
  }
}
