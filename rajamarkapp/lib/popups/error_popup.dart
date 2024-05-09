import 'package:flutter/material.dart';
import 'package:rajamarkapp/const/constant.dart';

class ErrorPopup extends StatelessWidget {
  const ErrorPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: popupBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: Text(
        ("There is an error in the Exam Details. Please make changes."),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: Add Functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: blueButtonText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text("Okay"),
            ),
          ],
        ),
      ],
    );
  }
}
