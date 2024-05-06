import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajamarkapp/Modals/DatabaseController.dart';
import 'package:rajamarkapp/Modals/StudentResult.dart';

class StudentResultScreen extends StatelessWidget {
  final DatabaseController _controller = Get.find();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _examIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Results")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Option to get student results by student ID
            TextFormField(
              controller: _studentIdController,
              decoration: InputDecoration(labelText: "Enter Student ID"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String studentId = _studentIdController.text.trim();
                if (studentId.isNotEmpty) {
                  _controller.getStudentResultByStudentId(studentId);
                } else {
                  Get.snackbar("Error", "Please enter a valid student ID");
                }
              },
              child: Text("Get Student Results by Student ID"),
            ),
            SizedBox(height: 20),
            // Option to get student results by exam ID
            TextFormField(
              controller: _examIdController,
              decoration: InputDecoration(labelText: "Enter Exam ID"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String examId = _examIdController.text.trim();
                if (examId.isNotEmpty) {
                  _controller.getStudentResultByExamId(examId);
                } else {
                  Get.snackbar("Error", "Please enter a valid exam ID");
                }
              },
              child: Text("Get Student Results by Exam ID"),
            ),
            SizedBox(height: 20),
            // Option to get student results by student ID and exam ID
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _studentIdController,
                    decoration: InputDecoration(labelText: "Enter Student ID"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _examIdController,
                    decoration: InputDecoration(labelText: "Enter Exam ID"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String studentId = _studentIdController.text.trim();
                String examId = _examIdController.text.trim();
                if (studentId.isNotEmpty && examId.isNotEmpty) {
                  _controller.getStudentResultByStudentIdAndExamId(studentId, examId);
                } else {
                  Get.snackbar("Error", "Please enter both student ID and exam ID");
                }
              },
              child: Text("Get Student Results by Student ID and Exam ID"),
            ),
            SizedBox(height: 20),
            // Display the fetched results
            Obx(() {
              if (_controller.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                List<StudentResult> studentResults = _controller.studentResults.toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: studentResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(studentResults[index].studentId),
                        subtitle: Text("Score: ${studentResults[index].score}"),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
