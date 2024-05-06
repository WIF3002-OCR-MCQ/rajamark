import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajamarkapp/Modals/CreateExamScreen.dart';
import 'package:rajamarkapp/Modals/ExamList.dart';
import 'package:rajamarkapp/database/database.dart';

import 'DatabaseController.dart';


Future<void> main() async {
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
  Get.put(DatabaseController());
  runApp(MyApp());

  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      title: 'Exam App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home://CreateExamScreen()
     ExamListScreen(), 
    );
  }
}