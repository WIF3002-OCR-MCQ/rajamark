import 'dart:math';

import 'package:get/get.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/modal/StudentResult.dart';
import 'package:rajamarkapp/services/firebase_service.dart';
// import 'package:rajamarkapp/state/GradeState.dart';

class ExamState extends GetxService {
  static ExamState get to => Get.find();
  RxList<Exam> exams = RxList<Exam>([]);
  RxList<Exam> filteredExams = RxList<Exam>([]);
  FirebaseService firebaseService = FirebaseService();

  void getExams() async {
    exams.value = await firebaseService.getExams();
    for (Exam exam in exams) {
      List<StudentResult> studentResults =
          await firebaseService.getStudentResultByExamId(exam.examId);

      exam.studentResults = studentResults;
    }

    filteredExams.value = exams;
  }

  void filterExams(String searchvalue) {
    if (searchvalue == '') {
      filteredExams.value = exams;
      return;
    }
    filteredExams.value = exams
        .where((exam) =>
            exam.courseCode.toLowerCase().contains(searchvalue.toLowerCase()) ||
            exam.title.toLowerCase().contains(searchvalue.toLowerCase()))
        .toList();
  }

  void addExam(Exam exam) async {
    await firebaseService.addExam(exam);
    exams.add(exam);
  }

  void removeExam(Exam exam) async {
    bool isDeleted = await firebaseService.deleteExam(exam);
    if (isDeleted) {
      exams.remove(exam);
      print("${exam.examId} deleted");
    } else {
      print("Failed to delete ${exam.examId}");
    }
  }

  void updateExam(Exam exam) async {
    bool isUpdated = await firebaseService.updateExam(exam);
    if (isUpdated) {
      print("${exam.examId} updated");
      int index = exams.indexWhere((element) => element.examId == exam.examId);
      exams[index] = exam;
    } else {
      print("Failed to update ${exam.examId}");
    }
  }

  void addStudentResult(StudentResult studentResult, Exam currentExam) async {
    bool isAdded = await firebaseService.addStudentResult(studentResult);

    if (!isAdded) return;
    for (var exam in exams) {
      if (exam.examId == currentExam.examId) {
        exam.studentResults.add(studentResult);
      }
    }
  }

  void removeStudentResult(
      StudentResult studentResult, Exam currentExam) async {
    bool isRemoved = await firebaseService.removeStudentResult(studentResult);

    if (!isRemoved) return;
    for (var exam in exams) {
      if (exam.examId == currentExam.examId) {
        exam.studentResults.remove(studentResult);
      }
    }
  }

  void updateStudentResult(
      StudentResult studentResult, Exam currentExam) async {
    bool isUpdated = await firebaseService.updateStudentResult(studentResult);

    if (!isUpdated) return;
    for (var exam in exams) {
      if (exam.examId == currentExam.examId) {
        int index = exam.studentResults.indexWhere(
            (element) => element.studentId == studentResult.studentId);
        exam.studentResults[index] = studentResult;
      }
    }
  }
}
