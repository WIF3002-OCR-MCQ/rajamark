import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/const/constant.dart';
import 'package:rajamarkapp/popups/sample_answer_second_popup.dart';

class SampleAnswerFirstPopUp extends StatefulWidget {
  const SampleAnswerFirstPopUp({super.key});

  @override
  State<SampleAnswerFirstPopUp> createState() => _SampleAnswerFirstPopUpState();
}

class _SampleAnswerFirstPopUpState extends State<SampleAnswerFirstPopUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffbfd7ed),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: const Text('Please enter number of questions'),
      content: SizedBox(
        width: 300,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: const TextStyle(fontWeight: FontWeight.bold),
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of questions',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(
                  height: 20), // Add spacing between text field and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          backgroundColor, // Adjust button color as needed
                      foregroundColor: blueButtonText,
                    ),
                  ),
                  const SizedBox(width: 10), // Add spacing between buttons
                  ElevatedButton(
                    onPressed: () {
                      int enteredQuantity =
                          int.tryParse(_quantityController.text) ?? 0;
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => SampleAnswerSecondPopUp(
                          quantity: enteredQuantity,
                        ),
                      );
                    },
                    child: const Text('Next'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          backgroundColor, // Adjust button color as needed
                      foregroundColor: blueButtonText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
