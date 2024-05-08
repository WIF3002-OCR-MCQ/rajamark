import 'package:get/get.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/services/firebase_service.dart';
import 'package:rajamarkapp/state/GradeState.dart';

class ExamState extends GetxService {
  static ExamState get to => Get.find();
  RxList<Exam> exams = RxList<Exam>([]);
  FirebaseService firebaseService = FirebaseService();

  Future<void> addExam(Exam exam) async {
    await firebaseService.addExam(exam);
    GradeState.to.addGradeList(exam.grades);

    exams.add(exam);
  }

  void removeExam(Exam exam) {
    exams.remove(exam);
  }

  void updateExam(Exam exam) {
    int index = exams.indexWhere((element) => element.examId == exam.examId);
    exams[index] = exam;
  }
}
