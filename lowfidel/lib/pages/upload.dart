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
  File? processedImageFile;
  Future<File?> processImage(File imageFile) async {
    try {
      img.Image? image = img.decodeImage(await imageFile.readAsBytes());

      int Dwidth = (image!.width * 1.5).toInt();
      int Dheight = (image!.height * 1.5).toInt();

      var resizedImage = img.copyResize(image, width: Dwidth, height: Dheight);

      var isBlurry = isImageBlurry(resizedImage);
      print("Blur: ");
      print(isBlurry);

      //Greyscale
      var greyscaleImage = img.grayscale(resizedImage);

      image = sharpenImage(greyscaleImage);

      final processedImageFile = File('${imageFile.path}_processed.jpg');
      await processedImageFile.writeAsBytes(img.encodeJpg(image));

      return processedImageFile;
    } catch (e) {
      print('Error processing image: $e');
      return null;
    }
  }

  img.Image sharpenImage(img.Image image) {
    // Create a sharpening kernel (e.g., Laplacian filter)
    final List<num> kernel = [
      0,
      -1,
      0,
      -1,
      5,
      -1,
      0,
      -1,
      0,
    ];

    // Apply the kernel as a convolution filter
    final sharpened = img.convolution(image, filter: kernel);

    return sharpened;
  }

  _imgFromGallery() async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      EasyLoading.show(status: 'loading...');
      if (image != null) {
        processedImageFile = await processImage(File(image.path));

        // Check if the processed image is blurry
        img.Image uploadedImage =
            img.decodeImage(await processedImageFile!.readAsBytes())!;
        if (isImageBlurry(uploadedImage)) {
          // If the image is blurry, set the pickerror variable and prompt the user to upload a new image
          setState(() {
            _pickerror =
                "The uploaded image is blurry. Please upload a clearer image.";
          });
          EasyLoading.dismiss();
          return;
        }

        // If the image is not blurry, proceed with text extraction
        extracted =
            await FlutterTesseractOcr.extractText(processedImageFile!.path);
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
        _pickerror =
            "Error: Select An Image (.PNG,.JPG,.JPEG,..) \nand Wait a Few Seconds";
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
      return Text(
        _pickerror.toString(),
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

  Widget afterpreview() {
    if (processedImageFile != null) {
      if (kIsWeb) {
        EasyLoading.dismiss();
        return Image.network(
          processedImageFile!.path,
          fit: BoxFit.cover,
        );
      } else {
        EasyLoading.dismiss();
        return Semantics(
            label: 'image_picked_image',
            child: Image.file(File(
              processedImageFile!.path,
            )));
      }
    } else if (_pickerror != null) {
      EasyLoading.dismiss();
      return Text(
        _pickerror.toString(),
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
                      child: Center(
                        child: Row(
                          children: [
                            Flexible(child: preview()),
                            Flexible(child: afterpreview()),
                          ],
                        ),
                      ),
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

  bool isImageBlurry(img.Image resizedImage) {
    const blurThreshold = 0.005;
    double blurFactor = calculateBlurFactor(resizedImage);
    return blurFactor < blurThreshold;
  }

  double calculateBlurFactor(img.Image resizedImage) {
    // Convert the image to grayscale
    img.Image grayscale = img.grayscale(resizedImage);

    // Calculate the variance of Laplacian
    double variance = calculateVarianceOfLaplacian(grayscale);

    return variance;
  }

  double calculateVarianceOfLaplacian(img.Image grayscale) {
    // Calculate the Laplacian
    List<num> laplacian = [
      -1,
      -1,
      -1,
      -1,
      8,
      -1,
      -1,
      -1,
      -1,
    ];

    img.Image filtered = img.convolution(grayscale, filter: laplacian);

    // Calculate the variance of the Laplacian
    double mean = 0.0;
    for (int y = 0; y < filtered.height; y++) {
      for (int x = 0; x < filtered.width; x++) {
        mean += filtered.getPixel(x, y).luminanceNormalized;
      }
    }
    mean /= (filtered.width * filtered.height);

    double variance = 0.0;
    for (int y = 0; y < filtered.height; y++) {
      for (int x = 0; x < filtered.width; x++) {
        variance += (filtered.getPixel(x, y).luminanceNormalized - mean).abs();
      }
    }
    variance /= (filtered.width * filtered.height);

    return variance;
  }
}
