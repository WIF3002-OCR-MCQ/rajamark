import 'package:get/get.dart';
import 'package:rajamarkapp/modal/Exam.dart';

class ExamState extends GetxService {
  static ExamState get to => Get.find();
  RxList<Exam> exams = RxList<Exam>([]);

  void addExam(Exam exam) {
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
