import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rajamarkapp/const/constant.dart';

class EditResultPopUp extends StatefulWidget {
  const EditResultPopUp({super.key});
  @override
  State<EditResultPopUp> createState() => _EditResultPopUpState();
}

class _EditResultPopUpState extends State<EditResultPopUp> {
  final _formKey = GlobalKey<FormState>();
  PlatformFile? file;
  Future<void> pickfile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      List<PlatformFile> platformfile = result.files;
    }
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Student ID :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Name :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Answer Sheet :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          pickfile();
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 1,
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
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Add functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          foregroundColor: blueButtonText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text("Edit Result"),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
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
