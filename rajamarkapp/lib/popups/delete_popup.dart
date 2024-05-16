import 'package:flutter/material.dart';
import 'package:rajamarkapp/const/constant.dart';
import 'package:rajamarkapp/modal/Exam.dart';
import 'package:rajamarkapp/state/ExamState.dart';

class DeletePopup extends StatelessWidget {
  const DeletePopup({super.key, required this.examData});

  final Exam examData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: popupBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: Text(
        ("Are you sure you want to delete this file?"),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: blueButtonText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text("No"),
            ),
            SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                ExamState.to.removeExam(examData);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: warningColour,
                foregroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text("Yes"),
            )
          ],
        ),
      ],
    );
  }
}
