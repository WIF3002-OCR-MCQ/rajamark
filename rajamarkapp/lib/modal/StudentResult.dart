class StudentResult {
  String studentResultId; // Adding an ID for the Student Result 
  String studentId;
  String examId;
  List<String> answerText;//This is to store the student extracted answer
  int score;
  DateTime date;
  String gradeLabel;

  StudentResult({
    required this.studentResultId,
    required this.studentId,
    required this.examId,
    required this.answerText,
    required this.score,
    required this.date,
    required this.gradeLabel,
  });

  StudentResult.fromJson(Map<String, dynamic> json)
      : studentResultId = json['studentResultId'],
        studentId = json['studentId'],
        examId = json['examId'],
        answerText = (json['answerText'] as List).cast<String>(),
        score = json['score'],
        date = DateTime.parse(json['date']),
        gradeLabel = json['gradeLabel'];

  Map<String, dynamic> toJson() => {
        'studentResultId': studentResultId,
        'studentId': studentId,
        'examId': examId,
        'answerText': answerText,
        'score': score,
        'date': date.toString(),
        'gradeLabel': gradeLabel,
      };


      int calculateScore(List<String> sampleAnswer) {//Here we just compare the answer extracted with sample answer input by lecturer
    int score = 0;
    for (int i = 0; i < answerText.length; i++) {
      if (answerText[i].toLowerCase() == sampleAnswer[i].toLowerCase()) {
        score++;
      }
    }
    return score;
  }
}


/** Just for testing ...this how it will work where we will compare answers by extracting only the answers and storing it in array
 *  final exam = Exam(
      examId: "TEST_EXAM_123",
      examTitle: "Sample Exam",
      examDesc: "This is a sample exam for testing purposes.",
      courseCode: "ABC101",
      session: "Spring 2024",
      sampleAnswer: ["A","B","C","D","A"], userId: '', 
      studentResults: [],
    );

    // Create dummy student results
    final student1 = StudentResult(
      studentId: "STD_001",
      examId: exam.examId,
      studentName: "John Doe",
      answerText: ["A", "C", "B", "D", "A"],
      score: 0, // Initially set score to 0
      grade: "",
      date: DateTime.now(),
      imgId: "",
    );

 */