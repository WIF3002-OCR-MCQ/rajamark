import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajamarkapp/const/constant.dart';

class AnswerScheme extends StatelessWidget {
  const AnswerScheme({Key? key}) : super(key: key);

  void placeholderFunction() {
    // TODO: Implement Back Navigation
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width to conditionally render the search bar
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        if (screenWidth >=
            700) // Assuming 600px as the breakpoint for mobile view
          TopBar(),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                    onPressed: placeholderFunction,
                    icon: Icon(Icons.arrow_back)),
                Text(
                  ("Details"),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ]),
              Divider(
                thickness: 2.0,
                color: dividerColour,
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          alignment: Alignment.topLeft,
          child: Text(
            ("Final Exam 23/24"),
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                // Use Expanded for flex
                flex: 6,
                child: AnswerBox(),
              ),
              Expanded(
                flex: 6,
                child: StudentBox(),
              ),
            ],
          ),
        ), //TODO: Make Dynamic
      ],
    );
  }
}

class AnswerBox extends StatelessWidget {
  const AnswerBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: DecoratedBox(
        // Apply rounded corners
        decoration: BoxDecoration(
          color: blueButton,
          borderRadius: BorderRadius.circular(8.0), // Set corner radius
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              QuestionRow(),
              QuestionRow(),
              QuestionRow(),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentBox extends StatelessWidget {
  const StudentBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: DecoratedBox(
        // Apply rounded corners
        decoration: BoxDecoration(
          color: blueButton,
          borderRadius: BorderRadius.circular(8.0), // Set corner radius
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              StudentRow(),
              StudentRow(),
              StudentRow(),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionRow extends StatelessWidget {
  const QuestionRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: EdgeInsets.all(5.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 20.0, top: 15.0),
                    child: Text(
                      ("Question 1"),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 10.0,
                  top: 2.0,
                  bottom: 15.0,
                ),
                child: Row(
                  children: [
                    AnswerItem(
                      letter: "A",
                      isFilled: false,
                    ),
                    AnswerItem(
                      letter: "B",
                      isFilled: false,
                    ),
                    AnswerItem(
                      letter: "C",
                      isFilled: false,
                    ),
                    AnswerItem(
                      letter: "D",
                      isFilled: true,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class StudentRow extends StatelessWidget {
  const StudentRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: EdgeInsets.all(5.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                      padding:
                          EdgeInsetsDirectional.only(start: 20.0, top: 15.0),
                      child: Column(
                        children: [
                          Text(
                            ("Student ID  :   S2132421"),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            ("Student ID  :   S2132421"),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                ],
              ),
            ],
          )),
    );
  }
}

class AnswerItem extends StatefulWidget {
  final String letter;
  final bool isFilled;

  const AnswerItem({
    required this.letter,
    required this.isFilled,
    super.key,
  });

  @override
  State<AnswerItem> createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: widget.isFilled ? Colors.green : backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            )),
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.25),
            child: Text(
              widget.letter,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search box on the top left
          Expanded(
            flex: 1,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Exams',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // User profile icon and name on the top right
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'John Doe',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://example.com/user_profile.jpg'), // Placeholder image URL
                  radius: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
