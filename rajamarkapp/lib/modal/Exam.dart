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
  String teacherId;

  Exam({
    required this.examId,
    required this.title,
    required this.description,
    required this.courseCode,
    required this.session,
    required this.sampleAnswer,
    this.meanScore = 0.0,
    this.medianScore = 0.0,
    List<Grade>? grades,
    List<StudentResult>? studentResults,
    required this.teacherId,
  })  : grades = grades ?? [],
        studentResults = studentResults ?? [];

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      examId: json['examId'],
      title: json['title'],
      description: json['description'],
      courseCode: json['courseCode'],
      session: json['session'],
      sampleAnswer: (json['sampleAnswer'] as List).cast<String>(),
      meanScore: json['meanScore']?.toDouble() ?? 0.0,
      medianScore: json['medianScore']?.toDouble() ?? 0.0,
      grades: (json['grades'] as List?)
              ?.map((item) => Grade.fromJson(item))
              .toList() ??
          [],
      studentResults: (json['studentResults'] as List?)
              ?.map((item) => StudentResult.fromJson(item))
              .toList() ??
          [],
      teacherId: json['teacherId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'examId': examId,
        'title': title,
        'description': description,
        'courseCode': courseCode,
        'session': session,
        'sampleAnswer': sampleAnswer,
        'meanScore': meanScore,
        'medianScore': medianScore,
        'teacherId': teacherId,
      };
}
