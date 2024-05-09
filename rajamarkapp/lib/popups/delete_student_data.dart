import 'package:flutter/material.dart';
import 'package:rajamarkapp/const/constant.dart';

class DeleteStudentDataPopup extends StatelessWidget {
  const DeleteStudentDataPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: popupBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: Text(
        ("Are you sure you want to delete this student record?"),
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
              child: Text("No"),
            ),
            SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Add functionality
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
