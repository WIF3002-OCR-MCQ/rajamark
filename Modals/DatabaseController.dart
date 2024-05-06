import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// Your modal classes
import 'Exam.dart';
import 'StudentResult.dart';
import 'grade.dart';

class DatabaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

 // RxList<User> users = RxList<User>([]);
  RxList<Exam> exams = RxList<Exam>([]);
  RxList<StudentResult> studentResults = RxList<StudentResult>([]);
  RxList<Grade> grades = RxList<Grade>([]);
  RxBool isLoading = false.obs;
//RxList
  // Initialize Firebase
  Future<void> initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAkhF8Nmtr2ou0mwenA7WzCRLyAbyQo13g",
        authDomain: "ocrsystemformcqanswersheet.firebaseapp.com",
        projectId: "ocrsystemformcqanswersheet",
        storageBucket: "ocrsystemformcqanswersheet.appspot.com",
        messagingSenderId: "468830889753",
        appId: "1:468830889753:web:99d84c4a6abc2ea1174788",
        measurementId: "G-7XGK9X56VL",
      ),
    );
  }

  // User Methods
  // Future<void> getUsers() async {
  //   isLoading.value = true;
  //   try {
  //     QuerySnapshot querySnapshot = await _firestore.collection('user').get();
  //     users.value = querySnapshot.docs.map((doc) => User.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //   } catch (e) {
  //     print('Error retrieving users: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> createUser(User user) async { 
  //   // ...implementation
  // }

  // Exam Methods
  Future<void> getExams() async {
    // ...implementation
  }

  Future<void> createExam(Map<String, dynamic> examData) async {
  CollectionReference exams = FirebaseFirestore.instance.collection('exam');

  try {
    DocumentReference doc = await exams.add(examData);
    examData['examId'] = doc.id;
    print('Exam data with updated ID: $examData');
    print('Exam created successfully! '+ doc.id);
  } catch (e) {
    print('Error creating exam: $e');
  }
}

Future<void> updateExamById(String examId, Map<String, dynamic> updatedExamData) async {
  CollectionReference exams = FirebaseFirestore.instance.collection('exam');

  try {
    await exams.doc(examId).update(updatedExamData);
    print('Exam updated successfully! '+ examId);
  } catch (e) {
    print('Error updating exam: $e');
  }
}

Future<void> deleteExam(BuildContext context, examId) async {
  CollectionReference exams = FirebaseFirestore.instance.collection('exam');

  try {
    // Fetch the document reference directly
    DocumentReference docRef = exams.doc(examId);

    // Check if it exists        
    if (!(await docRef.get()).exists) {
      print('Exam with ID $examId does not exist.'); 
      return; 
    }

    // Delete using the reference
    await docRef.delete(); 
    print('Exam deleted successfully!');
  } catch (e) {
    // ... (Handle errors here)
  }
}

 Future<void> getAllExams() async {
    isLoading.value = true; 

    try {
      CollectionReference examsRef = FirebaseFirestore.instance.collection('exam'); // Updated variable name 
      QuerySnapshot querySnapshot = await examsRef.get(); 

      // Clear any previous exams and add new ones:
      exams.clear(); // Important! Clear the list before adding
      exams.addAll(querySnapshot.docs
          .map((doc) => Exam.fromJson(doc.data() as Map<String, dynamic>))
          .toList()); 

           print('Exams fetched:'); // New print statement
    for (var exam in exams) {
      print('  - Exam ID: ${exam.examId}'); 
    }
    } catch (e) {
      print('Error retrieving exams: $e');
    } finally {
      isLoading.value = false; 
    }
  }


Future<Map<String, dynamic>?> getExamById(String examId) async {
  CollectionReference exams = FirebaseFirestore.instance.collection('exam');

  try {
    DocumentSnapshot snapshot = await exams.doc(examId).get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      print('Exam with ID $examId does not exist.');
      
      return null;
    }
  } catch (e) {
    print('Error retrieving exam: $e');
    return null;
  }
}

  // ... Add other CRUD methods for Exams, Student Results, and Grades

  //-------------- Student_Result-------------
// Create Student
// String? downloadURL = await saveStudentResultImage();
// save the image file and get the link
// use the link to create a student result

Future<String?> saveStudentResultImage(File imageFile) async {
  try {
    String fileName = 'result_${DateTime.now().millisecondsSinceEpoch}.jpg'; // Generate a unique file name for the image
    Reference storageReference = FirebaseStorage.instance.ref().child('student-result-images/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;

  } catch (e) {
    print('Error saving student result image: $e');
    return null;
  }
}


//pass in the student result map
//This the method to save the student name ,id,extracted answers
Future<void> createStudentResult(Map<String, dynamic> studentData) async {
  CollectionReference student_result = FirebaseFirestore.instance.collection('student_result');

  try {
    DocumentReference doc = await student_result.add(studentData);
    print('Student Result created successfully! '+ doc.id);
  } catch (e) {
    print('Error creating exam: $e');
  }
}

Future<List<Map<String, dynamic>>> getStudentResultByStudentId(String studentId) async {
  try {
    CollectionReference resultsCollection = FirebaseFirestore.instance.collection('student_result');
    QuerySnapshot querySnapshot = await resultsCollection.where('student_id', isEqualTo: studentId).get();
    List<Map<String, dynamic>> resultsList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    return resultsList;

  } catch (e) {
    print('Error getting student results: $e');
    return [];
  }

}

Future<List<Map<String, dynamic>>> getStudentResultByExamId(String examId) async {
  try {
    CollectionReference resultsCollection = FirebaseFirestore.instance.collection('student_result');
    QuerySnapshot querySnapshot = await resultsCollection.where('exam_id', isEqualTo: examId).get();
    List<Map<String, dynamic>> resultsList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    return resultsList;

  } catch (e) {
    print('Error getting student results: $e');
    return [];
  }
}

Future<List<Map<String, dynamic>>> getStudentResultByStudentIdAndExamId(String studentId, String examId) async {
  try {
    CollectionReference resultsCollection = FirebaseFirestore.instance.collection('student_result');
    QuerySnapshot querySnapshot = await resultsCollection.where('exam_id', isEqualTo: examId).where('student_id', isEqualTo: studentId).get();
    List<Map<String, dynamic>> resultsList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    return resultsList;

  } catch (e) {
    print('Error getting student results: $e');
    return [];
  }
}

Future<void> updateStudentResultByExamIdAndStudentId(String examId, String studentId, Map<String, dynamic> updatedStudentResult) async {
  CollectionReference studentResults = FirebaseFirestore.instance.collection('student_result');
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

      print('Student result for student ID $studentId and exam ID $examId updated successfully!');
    } else {
      print('No student result found for student ID $studentId and exam ID $examId.');
    }
  } catch (e) {
    print('Error updating student result: $e');
  }
}

Future<void> deleteStudentResultByExamIdAndStudentId(String examId, String studentId) async {
  CollectionReference studentResults = FirebaseFirestore.instance.collection('student_result');
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

      print('Student result for student ID $studentId and exam ID $examId deleted successfully!');
    } else {
      print('No student result found for student ID $studentId and exam ID $examId.');
    }
  } catch (e) {
    print('Error deleting student result: $e');
  }
}


//----------grade-------------------
Future<void> createGrade(Map<String, dynamic> gradeData) async {
  CollectionReference grade = FirebaseFirestore.instance.collection('grade');

  try {
    DocumentReference doc = await grade.add(gradeData);
    print('Grade created successfully! '+ doc.id);
  } catch (e) {
    print('Error creating grade:$e');
  }
}

Future<List<Map<String, dynamic>>> getGradesByExamId(String examId) async {
  CollectionReference grade = FirebaseFirestore.instance.collection('grade');

  try {
    QuerySnapshot querySnapshot = await grade.where('exam_id', isEqualTo: examId).get();
    List<Map<String, dynamic>> resultsList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    return resultsList;

  } catch (e) {
    print('Error getting grade: $e');
    return [];
  }
}

Future<List<Map<String, dynamic>>> getGradeByExamIdAndGradeLabel(String examId, String gradeLabel) async {
  CollectionReference grade = FirebaseFirestore.instance.collection('grade');

  try {
    QuerySnapshot querySnapshot = await grade.where('exam_id', isEqualTo: examId).where('grade_label', isEqualTo: gradeLabel).get();
    List<Map<String, dynamic>> resultsList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    return resultsList;

  } catch (e) {
    print('Error getting grade: $e');
    return [];
  }
}

Future<void> updateGradeByExamIdAndGradeLabel(String examId, String gradeLabel, Map<String, dynamic> updatedGradeData) async {
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

      print('Student result for grade label ID $gradeLabel and exam ID $examId updated successfully!');
    } else {
      print('No student result found for grade label ID $gradeLabel and exam ID $examId.');
    }
  } catch (e) {
    print('Error updating student result: $e');
  }
}

  // Calculation Methods
  Future<void> updateStudentResultScores(List<StudentResult> results, List<String> sampleAnswers) async {
    for (var result in results) {
      result.score = result.calculateScore(sampleAnswers);
    }
    update();
  }

  Future<void> updateExamStatistics(Exam exam) async {
    exam.calculateMean();
    exam.calculateMedian();
    update(); 
  }
}
