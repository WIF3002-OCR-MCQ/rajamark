class StudentResult {
  String studentId;
  String examId;
  String studentName;
  int score;
  List<String> answerText; // This is to store the student extracted answer
  String gradeLabel;
  DateTime date;

  StudentResult({
    required this.studentId,
    required this.examId,
    required this.studentName,
    required this.score,
    required this.answerText,
    required this.gradeLabel,
    required this.date,
  });

  StudentResult.fromJson(Map<String, dynamic> json)
      : studentId = json['studentId'],
        examId = json['examId'],
        studentName = json['studentName'],
        score = json['score'],
        answerText = (json['answerText'] as List<dynamic>).cast<String>(),
        gradeLabel = json['gradeLabel'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'examId': examId,
        'studentName': studentName,
        'score': score,
        'answerText': answerText,
        'gradeLabel': gradeLabel,
        'date': date.toString()
      };

  @override
  String toString() {
    return 'StudentResult{studentId: $studentId, examId: $examId, studentName: $studentName, '
        'score: $score, answerText: $answerText, gradeLabel: $gradeLabel, date: $date}';
  }
}
