import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rajamarkapp/modal/StudentInfo.dart';
import 'package:rajamarkapp/popups/processing.dart';
import 'package:google_vision/google_vision.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'dart:async';

class DropboxWidget extends StatefulWidget {
  @override
  _DropboxWidgetState createState() => _DropboxWidgetState();
}

class _DropboxWidgetState extends State<DropboxWidget> {

  List<String> _droppedFiles = [];

  @override
  Widget build(BuildContext context) {
    double popupWidth = MediaQuery.of(context).size.width * 0.5;
    //double imageSize =  MediaQuery.of(context).size.width >= 600 ? popupWidth * 0.4 : popupWidth * 0.8;
    
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: popupWidth*0.7,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10), 
          ),
          child: Center(
            child: _droppedFiles.isEmpty
                ? const Text(
                    'Drag to Upload Files',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.attach_file,
                        size: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Uploaded ${_droppedFiles.length} file(s)',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          _droppedFiles.add(data);
        });
      },
    );
  }
}

class FilePickerPopup extends StatelessWidget {

  final bool isUploadMode;

    bool isDesktop (BuildContext context)=>
    MediaQuery.of(context).size.width >= 850;

  bool isMobile (BuildContext context) =>
    MediaQuery.of(context).size.width < 600;

  const FilePickerPopup({Key? key, required this.isUploadMode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double popupWidth = MediaQuery.of(context).size.width * 0.7;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),

      child: Container(
        width: popupWidth,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'File Picker',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row( // the container should be hide and show only icon when mobile size is less than 400
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop(context))
                Container(
                  width: 250,
                  child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/recent-files.png',
                            width: 80.0,
                            height: 80.0,
                          ),
                          const Text(
                            'Recent Files',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/upload-file.png', 
                            width: 80.0,
                            height: 80.0,
                          ),
                          const Text(
                            'Upload a File',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/private-file.png', 
                            width: 80.0,
                            height: 80.0,
                          ),
                          const Text(
                            'Private Files',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/gdrive.png', 
                            width: 80.0,
                            height: 80.0,
                          ),
                          const Text(
                            'Google Drive',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),             
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Center(child: DropboxWidget(),),
                    ),
                    const SizedBox(height: 32.0),
                    const Text(
                      'Attachment',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        _showFilePicker(context);
                      },
                      child: const Text('Choose Files'),
                    ),
                    
                    const SizedBox(height: 32.0),
                    const Text(
                      'Save As',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 50.0, 
                      width:  popupWidth < 500 ? popupWidth * 0.7 : popupWidth * 0.5,  
                      child:
                      const TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter File Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ),
                    const SizedBox(height: 32.0),
                    const Text(
                      'Author',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 50.0, 
                      width:  popupWidth < 500 ? popupWidth * 0.7 : popupWidth * 0.5, 
                      child:
                      const TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Author Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ),
                    const SizedBox(height: 48.0),
                    Center(
                      child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                        onPressed: () {
                          if (isUploadMode) {
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const processingPopup(isUploadMode:true);
                            },
                          );
                          //TODO, after succesful uploading, close processing popup and do next step

                          } else {
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const processingPopup(isUploadMode:false);
                            },
                          );
                          //TODO, after succesful extraction, close processing popup and do next step
                          
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: 
                          Center(
                            child:
                              Text(
                              isUploadMode ? 'Upload This File' : 'Extract This File',
                              style: const TextStyle(
                                fontSize: 16.0, 
                                color: Colors.white, 
                              ),
                            ),
                          ),
                          
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilePicker(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    String? filePath = '';
    if (result != null) {
      String extracted='';

    if (kIsWeb) {
      // Handle web platform
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

       if (fileBytes != null) {
        // Convert Uint8List to ByteBuffer
        ByteBuffer buffer = fileBytes.buffer;
        JsonImage jsonImage = JsonImage.fromBuffer(buffer);
        
        // Assuming Google Vision can process JsonImage directly
        final String authString = await rootBundle.loadString('assets/auth/auth.json');
        final googleVision = await GoogleVision.withJwt(authString);
        List<EntityAnnotation> annotations = await googleVision.textDetection(jsonImage);
        extracted = annotations[0].description;
      }
    } else {
      // Handle non-web platforms
      filePath = result.files.single.path;

      if (filePath != null) {
        if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
          final String authString = await rootBundle.loadString('assets/auth/auth.json');
          final googleVision = await GoogleVision.withJwt(authString);
          List<EntityAnnotation> annotations = await googleVision.textDetection(
            JsonImage.fromFilePath(filePath)
          );
          extracted = annotations[0].description;
        } else {
          extracted = await FlutterTesseractOcr.extractText(filePath, args: {
            "tessedit_char_whitelist": "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:. ",
            "preserve_interword_spaces": "1",
            "tessedit_pageseg_mode": "1",
          });
        }
      }
    }

      // ***** Remove later ******
          // This is how to access student info object
          StudentInfo studentInfo = parseInputString(extracted);
            print('Student ID: ${studentInfo.studentID}');
            print('Student Name: ${studentInfo.studentName}');
            print('Student Answers:'); 
            for(var answer in studentInfo.studentAnswers){
              print(answer);
            }   

      if (filePath != null && filePath.isNotEmpty) {
        // Close initial popup
        Navigator.of(context).pop();
        //extract value
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Extracted Text'),
              content: Text(extracted.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ],
            );
          },
        );

        // show processing popup for a while (if success do next step if not show error_popup)
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return processPopup(filePath: filePath);
        //   },
        // );
        // Automatically dismiss the popup after a delay (e.g., 5 seconds)
        // Timer(Duration(seconds: 5), () {
        //   Navigator.pop(context); // Dismiss the popup after 5 seconds
        // });
      }
    }
  }
}