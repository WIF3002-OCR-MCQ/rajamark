import 'package:flutter/material.dart';
import 'package:get/get.dart';



import 'DatabaseController.dart';
import 'Exam.dart'; 

class EditExamScreen extends StatefulWidget {
  final Exam exam;

  EditExamScreen({required this.exam});

  @override
  _EditExamScreenState createState() => _EditExamScreenState();
}

class _EditExamScreenState extends State<EditExamScreen> {
  final DatabaseController _controller = Get.find();
  final _formKey = GlobalKey<FormState>(); 
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseCodeController = TextEditingController();
  final _sessionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing exam data
    _titleController.text = widget.exam.title;
    _descriptionController.text = widget.exam.description;
    _courseCodeController.text = widget.exam.courseCode;
    _sessionController.text = widget.exam.session; 
  }

  @override
  void dispose() {
    // Clean up controllers
    _titleController.dispose();
    _descriptionController.dispose();
    _courseCodeController.dispose();
    _sessionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Exam")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(  
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) => value!.isEmpty ? "Please enter a title" : null,
              ),
              TextFormField(  
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3, 
                validator: (value) => value!.isEmpty ? "Please enter a description" : null,
              ),
              // ... Add TextFormFields for courseCode, session
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async { 
                  if (_formKey.currentState!.validate()) {
                    // Update exam object
                    widget.exam.title = _titleController.text;
                    widget.exam.description = _descriptionController.text;
                    // ... update other fields ...

                    // Call your controller's updateExam method (you'll need to implement this)
                    //await _controller.updateExam(widget.exam.examId, widget.exam.toJson());

                    // Navigate back to exam list
                    Get.back(); // Or use Navigator.pop(context)
                  }
                },
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
