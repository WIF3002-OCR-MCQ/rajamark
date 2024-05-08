import 'package:get/get.dart';
import 'package:rajamarkapp/modal/Grade.dart';

class ExamState extends GetxService {
  static ExamState get to => Get.find();
  RxList<Grade> grades = RxList<Grade>([]);

  void addGrade(Grade grade) {
    grades.add(grade);
  }

  void removeGrade(Grade grade) {
    grades.remove(grade);
  }

  void updateGrade(Grade grade) {
    int index =
        grades.indexWhere((element) => element.gradeId == grade.gradeId);
    grades[index] = grade;
  }
}
