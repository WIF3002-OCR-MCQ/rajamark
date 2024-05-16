import 'package:flutter/material.dart';
import 'package:rajamarkapp/const/constant.dart';

class DeleteStudentDataPopup extends StatelessWidget {
  DeleteStudentDataPopup({
    super.key,
    required this.onDelete,
  });

  Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: popupBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: const Text(
        ("Are you sure you want to delete this student record?"),
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
              child: const Text("No"),
            ),
            const SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                onDelete();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: warningColour,
                foregroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text("Yes"),
            )
          ],
        ),
      ],
    );
  }
}
