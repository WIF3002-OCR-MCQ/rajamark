import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DatabaseController.dart';
import 'EditExamScreen.dart';
import 'Exam.dart';

class ExamListScreen extends StatelessWidget {
  final DatabaseController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exams")),
      body: GetBuilder<DatabaseController>(
        init: _controller,
        builder: (_) {
          _controller.getAllExams(); // Fetch exams automatically
          return Obx(() {
            if (_controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (_controller.exams.isEmpty) {
              return Center(child: Text('No exams found'));
            } else {
              return ListView.builder(
                itemCount: _controller.exams.length,
                itemBuilder: (context, index) {
                  Exam exam = _controller.exams[index];
                  return ListTile(
                    title: Text(exam.title),
                    subtitle: Text(exam.examId),
                    trailing: Row( 
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _confirmDelete(context, exam.examId), 
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navigate to EditExamScreen and pass the exam object
                            // Example with standard Navigator:
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EditExamScreen(exam: exam), 
                            ));
                          },
                        )
                      ]
                    ),
                  );
                },
              );
            }
          });
        },
      ),
    );
  }

  // Confirmation Dialog
  void _confirmDelete(BuildContext context, String examId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this exam?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _controller.deleteExam(context , examId);
              Navigator.pop(context); // Close dialog
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
