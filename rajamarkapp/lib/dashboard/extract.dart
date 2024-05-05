import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';

class ExtractingPopup extends StatelessWidget {
  final String? filePath;

  const ExtractingPopup({Key? key, this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double popupWidth = MediaQuery.of(context).size.width * 0.7;
    double imageSize = popupWidth * 0.4;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        width: popupWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFFBFD7ED),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 36.0),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    'Extract',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 48.0),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'images/ocr.png', //TODO: Image based on the choosen file
                    width: imageSize,
                    height: imageSize,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1.0,
                          ),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Extracting',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); 
              },
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(right: 0, bottom: 0),
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                    color: Color(0xFF0074B7),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'images/4.png', 
                        width: 24,
                        height: 24,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
