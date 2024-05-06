import 'package:flutter/material.dart';
import 'package:rajamarkapp/const/constant.dart';

class SampleAnswerSecondPopUp extends StatefulWidget {
  SampleAnswerSecondPopUp(
      {super.key, required this.quantity, this.showRedText = false});
  final int quantity;
  bool showRedText;

  @override
  State<SampleAnswerSecondPopUp> createState() =>
      _SampleAnswerSecondPopUpState(this.quantity);
}

class _SampleAnswerSecondPopUpState extends State<SampleAnswerSecondPopUp> {
  final _formKey = GlobalKey<FormState>();
  final int quantity;
  bool showRedText = false;

  List<bool>? _answerFilled;

  _SampleAnswerSecondPopUpState(this.quantity);

  @override
  void initState() {
    super.initState();
    _answerFilled = List<bool>.filled(quantity, false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffbfd7ed),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: SizedBox(
        width: 800,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Please fill in the answers of each question')
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(
                      flex: 4,
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Questions',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Answers',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 4,
                    ),
                  ],
                ),
              ),
              widget.quantity > 0
                  ? SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 300),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: widget.quantity,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(
                                      flex: 4,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                          child: TextFormField(
                                            onChanged: (value) => setState(() {
                                              _answerFilled?[index] =
                                                  value.isNotEmpty;
                                            }),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                fillColor: Colors.white,
                                                filled: true),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 4,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    )
                  : const Center(
                      child: Text(
                        "Invalid Quantity",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
              widget.showRedText
                  ? Text(
                      ("Please ensure all questions are filled up"),
                      style: TextStyle(
                          color: warningColour, fontWeight: FontWeight.bold),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 4,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: ElevatedButton(
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
                          child: Text("Cancel"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_answerFilled?.every((element) => element) ??
                              false) {
                            // Insert API/DB logic
                          } else {
                            setState(() => widget.showRedText = true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          foregroundColor: blueButtonText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text("Upload"),
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
