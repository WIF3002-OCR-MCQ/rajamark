import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rajamarkapp/dashboard/extract.dart';

class DropboxWidget extends StatefulWidget {
  @override
  _DropboxWidgetState createState() => _DropboxWidgetState();
}

class _DropboxWidgetState extends State<DropboxWidget> {
  List<String> _droppedFiles = [];

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 500,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10), 
          ),
          child: Center(
            child: _droppedFiles.isEmpty
                ? Text(
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
                      Icon(
                        Icons.attach_file,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Uploaded ${_droppedFiles.length} file(s)',
                        style: TextStyle(
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

  const FilePickerPopup({Key? key, required this.isUploadMode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double popupWidth = MediaQuery.of(context).size.width * 0.7;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: popupWidth,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'File Picker',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          Text(
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
                          Text(
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
                          Text(
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
                          Text(
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
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Center(child: DropboxWidget(),),
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'Attachment',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        _showFilePicker(context);
                      },
                      child: Text('Choose Files'),
                    ),
                    
                    SizedBox(height: 32.0),
                    Text(
                      'Save As',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 50.0, 
                      width: 500.0, 
                      child:
                      TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter File Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'Author',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 50.0, 
                      width: 500.0, 
                      child:
                      TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Author Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ),
                    SizedBox(height: 48.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (isUploadMode) {
                            // TODO: File upload action
                          } else {
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ExtractingPopup();
                            },
                          );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                           shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: 
                          Center(
                            child:
                              Text(
                              isUploadMode ? 'Upload This File' : 'Extract This File',
                              style: TextStyle(
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
    if (result != null) {
      String? filePath = result.files.single.path;

      if (filePath != null) {
        // Close initial popup
        Navigator.of(context).pop();
        
        // File picked successfully, show extracting popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ExtractingPopup(filePath: filePath);
          },
        );
      }
    }
  }
}