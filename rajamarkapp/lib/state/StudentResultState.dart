import 'package:get/get.dart';
import 'package:rajamarkapp/modal/StudentResult.dart';

class StudentResultState extends GetxService {
  static StudentResultState get to => Get.find();

  RxList<StudentResult> studentResults = RxList<StudentResult>([]);

  void addStudentResult(StudentResult studentResult) {
    studentResults.add(studentResult);
  }

  void removeStudentResult(StudentResult studentResult) {
    studentResults.remove(studentResult);
  }

  void updateStudentResult(StudentResult studentResult) {
    int index = studentResults.indexWhere(
        (element) => element.studentId == studentResult.studentId);
    studentResults[index] = studentResult;
  }
}
