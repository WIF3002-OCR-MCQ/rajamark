import 'package:rajamarkapp/modal/Exam.dart';

int calculateScore(List<String> sampleAnswer, List<String> studentAnswer) {
  if (studentAnswer.length != sampleAnswer.length) {
    throw ArgumentError('Length of sampleAnswer must match answerText');
  }

  int score = 0;
  for (int i = 0; i < studentAnswer.length; i++) {
    if (studentAnswer[i].toLowerCase() == sampleAnswer[i].toLowerCase()) {
      score++;
    }
  }
  int convertedFullMark = (score / sampleAnswer.length * 100).floor();
  return convertedFullMark;
}

String calculateGrade(int score, Exam examData) {
  for (var grade in examData.grades) {
    if (score > grade.lowerScore && score < grade.upperScore) {
      return grade.gradeLabel;
    }
  }
  return "";
}
