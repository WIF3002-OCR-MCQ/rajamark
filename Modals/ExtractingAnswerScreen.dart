/**
 * THIS IS JUST A REFERENCE FOR THE OCR TEAM TO HAVE AN IDEA ON HOW THE CONTROLLER WILL WORK FOR THEIR PART
 * 
 * import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:your_ocr_library/your_ocr_library.dart'; 
import 'DatabaseController.dart';

class GradeExamWidget extends StatefulWidget {
  @override
  _GradeExamWidgetState createState() => _GradeExamWidgetState();
}

class _GradeExamWidgetState extends State<GradeExamWidget> {
  final DatabaseController _databaseController = Get.find();
  String _ocrResult = '';

  void _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      _processImage(imageFile);
    }
  }

  void _processImage(XFile imageFile) async {
    setState(() { 
      _ocrResult = 'Processing...'; 
    });

    final ocrEngine = YourOCREngine(); // Replace with your OCR library
    String rawText = await ocrEngine.extractText(File(imageFile.path));

    // TODO: Implement parsing logic to extract studentId, studentName, and answers 
    final extractedStudentId = '...';
    final extractedStudentName = '...';
    // ... (Similarly extract answers)

 StudentResult studentResult = StudentResult(
      // ... other properties...
      answerText: extractedAnswers,
    );

    // Calculate score
    int calculatedScore = studentResult.calculateScore(sampleAnswers); 


    final studentData = {
      'studentId': extractedStudentId,
      'studentName': extractedStudentName,
      'examId': 'replaceWithExamId', // Get the correct examId
      'answerText': {
        'A': '...', 'B': '...', 'C': '...', 'D': '...' 
        // Replace with extracted answers
        'score':calculatedscore
      },
    };

    _databaseController.createStudentResult(studentData);
    setState(() { 
      _ocrResult = 'Student result saved!'; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            Text(_ocrResult),
          ],
        ),
      ),
    );
  }
}

 */