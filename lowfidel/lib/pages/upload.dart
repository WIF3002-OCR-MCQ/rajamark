import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image/image.dart' as img;

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  XFile? _imageFile;
  dynamic _pickerror;
  String? extracted = 'Recognised Extracted Text Will Appear Here';
  final picker = ImagePicker();
  Future<File?> processImage(File imageFile) async {
    try {
      img.Image? image = img.decodeImage(await imageFile.readAsBytes());

      image =
          img.copyResize(image!, width: 800);

      image = img.grayscale(image);

      final processedImageFile = File('${imageFile.path}_processed.jpg');
      await processedImageFile.writeAsBytes(img.encodeJpg(image));

      return processedImageFile;
    } catch (e) {
      print('Error processing image: $e');
      return null;
    }
  }

  _imgFromGallery() async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      EasyLoading.show(status: 'loading...');
      if (image != null) {
        final processedImageFile = await processImage(File(image.path));
        extracted = await FlutterTesseractOcr.extractText(processedImageFile!.path);
      } else {
        extracted = "Recognised extracted text will be shown here";
      }
      print(extracted);

      setState(() {
        if (image != null) {
          _imageFile = image;
        }
      });
    } catch (e) {
      setState(() {
        _pickerror = e;
        if (kDebugMode) {
          print(e);
        }
      });
    }
  }

  Widget preview() {
    if (_imageFile != null) {
      if (kIsWeb) {
        EasyLoading.dismiss();
        return Image.network(
          _imageFile!.path,
          fit: BoxFit.cover,
        );
      } else {
        EasyLoading.dismiss();
        return Semantics(
            label: 'image_picked_image',
            child: Image.file(File(
              _imageFile!.path,
            )));
      }
    } else if (_pickerror != null) {
      EasyLoading.dismiss();
      return const Text(
        'Error: Select An Image (.PNG,.JPG,.JPEG,..) \nand Wait a Few Seconds',
        textAlign: TextAlign.center,
      );
    } else {
      EasyLoading.dismiss();
      return const Text(
        'You have not yet picked an image\nUpload an Image And Wait A few Seconds',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OCR App",
      color: Colors.grey.shade500,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              "Extract text from image",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            backgroundColor: Colors.grey.shade100,
            iconTheme: const IconThemeData(
              color: Colors.black,
            )),
        body: Material(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.grey.shade100),
                      height: 250,
                      width: 650,
                      child: Center(child: preview()),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Hero(
                      tag: const Key("upload"),
                      child: Card(
                        color: Colors.grey.shade700,
                        child: InkWell(
                          onTap: () {
                            _imgFromGallery();
                          },
                          // hoverColor: Colors.orange,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                            ),
                            height: 40,
                            width: 400,
                            child: const Center(
                              child: Text(
                                "Upload Image",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      color: Colors.grey.shade600,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          color: Colors.grey.shade500,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SelectableText(
                              extracted.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
        ),
        bottomNavigationBar: Container(
          width: 500,
          height: 10,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }
}