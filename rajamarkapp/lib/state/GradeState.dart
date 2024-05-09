import 'package:get/get.dart';
import 'package:rajamarkapp/modal/Grade.dart';
import 'package:rajamarkapp/services/firebase_service.dart';

class GradeState extends GetxService {
  static GradeState get to => Get.find();
  RxList<Grade> grades = RxList<Grade>([]);
  FirebaseService firebaseService = FirebaseService();

  void addGrade(Grade grade) {
    firebaseService.addGrade(grade);
    grades.add(grade);
  }

  void addGradeList(List<Grade> gradeList) {
    for (Grade grade in gradeList) {
      firebaseService.addGrade(grade);
    }
    grades.addAll(gradeList);
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
