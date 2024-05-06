import 'package:flutter/material.dart';
import 'package:lowfidel/pages/upload.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OCR App",
      color: Colors.grey.shade500,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          title: const Text(
            "OCR Application",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          leading: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          backgroundColor: Colors.grey.shade100,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: const Key("upload"),
                    child: Card(
                      color: Colors.grey.shade700,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const UploadPage(),
                                transitionsBuilder:
                                    (context, animation1, animation2, child) {
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: 0.0, end: 1.0)
                                      .chain(CurveTween(curve: curve));
                                  var opacityAnimation =
                                      animation1.drive(tween);

                                  return FadeTransition(
                                      opacity: opacityAnimation, child: child);
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                              ));
                          setState(() {});
                        },
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
                ],
              ),
            ),
          ),
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
