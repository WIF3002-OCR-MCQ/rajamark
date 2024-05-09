import 'package:get/get.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/services/firebase_service.dart';
import 'package:rajamarkapp/state/GradeState.dart';

class ExamState extends GetxService {
  static ExamState get to => Get.find();
  RxList<Exam> exams = RxList<Exam>([]);
  RxList<Exam> filteredExams = RxList<Exam>([]);
  FirebaseService firebaseService = FirebaseService();

  void getExams() async {
    exams.value = await firebaseService.getExams();
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
    GradeState.to.addGradeList(exam.grades);

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
}
