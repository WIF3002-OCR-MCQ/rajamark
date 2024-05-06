import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajamarkapp/Modals/DatabaseController.dart';


import 'Exam.dart'; 

class CreateExamScreen extends StatefulWidget {
  @override
  _CreateExamScreenState createState() => _CreateExamScreenState();
}

class _CreateExamScreenState extends State<CreateExamScreen> {
  final DatabaseController _controller = Get.find();
  final _formKey = GlobalKey<FormState>(); 
  final _idController=TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseCodeController = TextEditingController();
  final _sessionController = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers
    _idController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _courseCodeController.dispose();
    _sessionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Exam")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //  TextFormField(
              //   controller: _idController,
              //   decoration: InputDecoration(labelText: "id"),
              //   validator: (value) => value!.isEmpty ? "Please enter a title" : null,
              // ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) => value!.isEmpty ? "Please enter a title" : null,
              ),
               TextFormField( // Description
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3, // Allow multiple lines for description
                validator: (value) => value!.isEmpty ? "Please enter a description" : null,
              ),
              TextFormField( // Course Code
                controller: _courseCodeController,
                decoration: InputDecoration(labelText: "Course Code"),
                validator: (value) => value!.isEmpty ? "Please enter a course code" : null,
              ),
              TextFormField( // Session
                controller: _sessionController,
                decoration: InputDecoration(labelText: "Session"),
                validator: (value) => value!.isEmpty ? "Please enter a session" : null,
              ),
              // ... Add TextFormFields for description, courseCode, session
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) { 
                    // Create a new Exam object
                    Exam newExam = Exam(
                      examId: "" ,// Firestore will auto-generate an ID
                      title: _titleController.text,
                      description: _descriptionController.text,
                      courseCode: _courseCodeController.text,
                      session: _sessionController.text,
                      grades: [], // Initialize with an empty list of grades
                      studentResults: [], // Initialize with an empty list of student results
                      sampleAnswer: [], // Initialize with an empty list of sample answers
                    );

                    await _controller.createExam(newExam.toJson());
                    // Clear form fields (optional)
                    _titleController.clear();
                    // ... clear other controllers ... 

                    // Show success message or navigate back 
                    Get.snackbar("Success", "Exam Created!"); 
                  }
                },
                child: Text("Create Exam"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
