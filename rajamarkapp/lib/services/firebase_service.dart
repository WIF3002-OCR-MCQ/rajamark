import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/modal/Grade.dart';
import 'package:rajamarkapp/modal/StudentResult.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Exam>> getExams() async {
    CollectionReference exams = _firestore.collection('exam');
    List<Exam> examList = [];

    try {
      QuerySnapshot querySnapshot = await exams.get();
      querySnapshot.docs.forEach((element) {
        final data = element.data() as Map<String, dynamic>;
        examList.add(Exam.fromJson(data));
        // print("Successfully get Exams");
      });
    } catch (e) {
      print('Error getting exams: $e');
    }

    return examList;
  }

  Future<bool> addExam(Exam examData) async {
    CollectionReference exams = _firestore.collection('exam');

    try {
      await exams.doc(examData.examId).set(examData.toJson());
      return true;
    } catch (e) {
      print('Error creating exam: $e');
      return false;
    }
  }

  Future<bool> updateExam(Exam examData) async {
    CollectionReference exams = _firestore.collection('exam');

    try {
      await exams.doc(examData.examId).update(examData.toJson());
      return true;
    } catch (e) {
      print('Error updating exam: $e');
      return false;
    }
  }

  Future<bool> deleteExam(Exam examData) async {
    CollectionReference exams = _firestore.collection('exam');

    try {
      await exams.doc(examData.examId).delete();
      return true;
    } catch (e) {
      print('Error deleting exam: $e');
      return false;
    }
  }

  Future<Exam?> getExamById(String examId) async {
    CollectionReference exams = _firestore.collection('exam');

    try {
      DocumentSnapshot snapshot = await exams.doc(examId).get();
      if (snapshot.exists) {
        Exam exam = Exam.fromJson(snapshot.data() as Map<String, dynamic>);
        return exam;
      } else {
        print('Exam with ID $examId does not exist.');

        return null;
      }
    } catch (e) {
      print('Error retrieving exam: $e');
      return null;
    }
  }

  Future<String?> saveStudentResultImage(File imageFile) async {
    try {
      String fileName =
          'result_${DateTime.now().millisecondsSinceEpoch}.jpg'; // Generate a unique file name for the image
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('student-result-images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error saving student result image: $e');
      return null;
    }
  }

  Future<bool> addStudentResult(StudentResult studentData) async {
    CollectionReference student_result =
        FirebaseFirestore.instance.collection('student_result');

    try {
      await student_result.doc().set(studentData.toJson());
      return true;
    } catch (e) {
      print('Error creating exam: $e');
      return false;
    }
  }

  Future<List<StudentResult>> getStudentResultByStudentId(
      String studentId) async {
    CollectionReference resultsCollection =
        FirebaseFirestore.instance.collection('student_result');
    List<StudentResult> studentResults = [];

    try {
      QuerySnapshot querySnapshot = await resultsCollection
          .where('student_id', isEqualTo: studentId)
          .get();
      for (var doc in querySnapshot.docs) {
        studentResults
            .add(StudentResult.fromJson(doc.data() as Map<String, dynamic>));
      }
      return studentResults;
    } catch (e) {
      print('Error getting student results: $e');
      return [];
    }
  }

  Future<List<StudentResult>> getStudentResultByExamId(String examId) async {
    CollectionReference resultsCollection =
        FirebaseFirestore.instance.collection('student_result');
    List<StudentResult> studentResults = [];

    try {
      QuerySnapshot querySnapshot =
          await resultsCollection.where('exam_id', isEqualTo: examId).get();
      for (var doc in querySnapshot.docs) {
        studentResults
            .add(StudentResult.fromJson(doc.data() as Map<String, dynamic>));
      }
      return studentResults;
    } catch (e) {
      print('Error getting student results: $e');
      return [];
    }
  }

  Future<List<StudentResult>> getStudentResultByStudentIdAndExamId(
      String studentId, String examId) async {
    CollectionReference resultsCollection =
        FirebaseFirestore.instance.collection('student_result');
    List<StudentResult> studentResults = [];

    try {
      QuerySnapshot querySnapshot = await resultsCollection
          .where('exam_id', isEqualTo: examId)
          .where('student_id', isEqualTo: studentId)
          .get();
      for (var doc in querySnapshot.docs) {
        studentResults
            .add(StudentResult.fromJson(doc.data() as Map<String, dynamic>));
      }
      return studentResults;
    } catch (e) {
      print('Error getting student results: $e');
      return [];
    }
  }

  Future<String?> updateStudentResultByExamIdAndStudentId(String examId,
      String studentId, Map<String, dynamic> updatedStudentResult) async {
    CollectionReference studentResults =
        FirebaseFirestore.instance.collection('student_result');
    try {
      // Query to retrieve the specific document where both studentId and examId match
      QuerySnapshot querySnapshot = await studentResults
          .where('student_id', isEqualTo: studentId)
          .where('exam_id', isEqualTo: examId)
          .limit(1)
          .get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the document
        DocumentReference docRef = querySnapshot.docs.first.reference;

        // Update the document with the new data
        await docRef.update(updatedStudentResult);

        print(
            'Student result for student ID $studentId and exam ID $examId updated successfully!');
        return docRef.id;
      } else {
        print(
            'No student result found for student ID $studentId and exam ID $examId.');
        return null;
      }
    } catch (e) {
      print('Error updating student result: $e');
      return null;
    }
  }

  Future<String?> deleteStudentResultByExamIdAndStudentId(
      String examId, String studentId) async {
    CollectionReference studentResults =
        FirebaseFirestore.instance.collection('student_result');
    try {
      // Query to retrieve the specific document where both studentId and examId match
      QuerySnapshot querySnapshot = await studentResults
          .where('student_id', isEqualTo: studentId)
          .where('exam_id', isEqualTo: examId)
          .limit(1)
          .get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the document
        DocumentReference docRef = querySnapshot.docs.first.reference;

        // Delete the document
        await docRef.delete();

        print(
            'Student result for student ID $studentId and exam ID $examId deleted successfully!');
        return docRef.id;
      } else {
        print(
            'No student result found for student ID $studentId and exam ID $examId.');
        return null;
      }
    } catch (e) {
      print('Error deleting student result: $e');
      return null;
    }
  }

  //------------------- GRADE -------------------

  Future<bool> addGrade(Grade gradeData) async {
    CollectionReference grades =
        FirebaseFirestore.instance.collection('exam/${gradeData.examId}/grades');

    try {
      await grades.doc(gradeData.gradeId).set(gradeData.toJson());
      return true;
    } catch (e) {
      print('Error creating grade: $e');
      return false;
    }
  }

  Future<List<Grade>> getGradesByExamId(String examId) async {
    CollectionReference grade = FirebaseFirestore.instance.collection('grade');
    List<Grade> gradeList = [];

    try {
      QuerySnapshot querySnapshot =
          await grade.where('exam_id', isEqualTo: examId).get();
      querySnapshot.docs.forEach((element) {
        final data = element.data() as Map<String, dynamic>;
        gradeList.add(Grade.fromJson(data));
        print("Successfully get Grades");
      });
      return gradeList;
    } catch (e) {
      print('Error getting grade: $e');
      return [];
    }
  }

  Future<List<Grade>> getGradeByExamIdAndGradeLabel(
      String examId, String gradeLabel) async {
    CollectionReference grade = FirebaseFirestore.instance.collection('grade');
    List<Grade> gradeList = [];

    try {
      QuerySnapshot querySnapshot = await grade
          .where('exam_id', isEqualTo: examId)
          .where('grade_label', isEqualTo: gradeLabel)
          .get();
      querySnapshot.docs.forEach((element) {
        final data = element.data() as Map<String, dynamic>;
        gradeList.add(Grade.fromJson(data));
        print("Successfully get Grades");
      });
      return gradeList;
    } catch (e) {
      print('Error getting grade: $e');
      return [];
    }
  }

  Future<String?> updateGradeByExamIdAndGradeLabel(String examId,
      String gradeLabel, Map<String, dynamic> updatedGradeData) async {
    CollectionReference grade = FirebaseFirestore.instance.collection('grade');
    try {
      // Query to retrieve the specific document where both studentId and examId match
      QuerySnapshot querySnapshot = await grade
          .where('grade_label', isEqualTo: gradeLabel)
          .where('exam_id', isEqualTo: examId)
          .limit(1)
          .get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the document
        DocumentReference docRef = querySnapshot.docs.first.reference;

        // Update the document with the new data
        await docRef.update(updatedGradeData);

        print(
            'Student result for grade label ID $gradeLabel and exam ID $examId updated successfully!');
        return docRef.id;
      } else {
        print(
            'No student result found for grade label ID $gradeLabel and exam ID $examId.');
        return null;
      }
    } catch (e) {
      print('Error updating student result: $e');
      return null;
    }
  }

  // Future<void> updateStudentResultScores(
  //     List<StudentResult> results, List<String> sampleAnswers) async {
  //   for (var result in results) {
  //     result.score = result.calculateScore(sampleAnswers);
  //   }
  // }

  // Future<void> updateExamStatistics(Exam exam) async {
  //   exam.calculateMean();
  //   exam.calculateMedian();
  //   update();
  // }
}
