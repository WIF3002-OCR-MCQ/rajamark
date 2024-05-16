import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadError extends StatelessWidget {
  const UploadError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: Colors.white,
        child: Container(
            width: 800,
            height: 500,
            child: Column(children: [
              const SizedBox(
                width: 10,
                height: 50,
              ),
              Container(
                width: 900,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 500,
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        border: Border.symmetric(
                          vertical: BorderSide(
                            color: Colors.red.shade900,
                            width: 10.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Image processing failed.\nPlease try again",
                        style: TextStyle(
                          color: Colors.red.shade900, // Dark red text color
                          fontSize: 20.0,
                          fontFamily: GoogleFonts.poppins()
                              .fontFamily, // Use GoogleFonts.poppins font family
                          fontWeight: FontWeight.bold, // Use normal font weight
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  foregroundColor: Colors.black,
                ),
                onPressed: () {},
                child: SizedBox(
                  // Wrap the Stack in a SizedBox to provide size constraints
                  width: 200.0, // Adjust width as needed
                  height: 50.0, // Adjust height as needed
                  child: Stack(
                    children: [
                      DropzoneView(
                        onDrop: (dynamic event) {},
                      ),
                      const Center(
                        child: Text("Drop files to Upload"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              const Text("or"),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[350],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Choose Files",
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.normal),
                  )),
              const SizedBox(
                width: 10,
                height: 100,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.close_rounded)),
              const Text("Cancel")
            ])));
  }
}
