import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseInitialization {
  static Future<void> initialize() async {
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
}

//test connection function - can be deleted
Future<void> addDocument() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  try {
    await users.add({
      'name': 'John Doe',
      'age': 31,
      'email': 'john.doe@example.com',
    });
    print('Document added successfully!');
  } catch (e) {
    print('Error adding document: $e');
  }
}
