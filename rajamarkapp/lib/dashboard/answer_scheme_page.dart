import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rajamarkapp/const/constant.dart';

import '../shared/top_row_widget.dart';

class AnswerSchemePage extends StatelessWidget {
  const AnswerSchemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnswerSchemeBody();
  }
}

class AnswerSchemeBody extends StatelessWidget {
  const AnswerSchemeBody({super.key});

  @override
  Widget build(context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TopRowWidget(),
          SecondRow(),
          SizedBox(
            child: Divider(
              thickness: 2,
              color: dividerColour,
            ),
          ),
          ThirdRow(),
          FourthRow(),
          SaveButton(),
        ],
      ),
    );
  }
}

class SecondRow extends StatelessWidget {
  const SecondRow({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 61, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleIconTextButtonWidget(),
        ],
      ),
    );
  }
}

class ThirdRow extends StatelessWidget {
  const ThirdRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                ("Final Exam 23/24"),
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Answer Scheme',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  width: 25,
                ),
              ),
              const Expanded(
                  flex: 1,
                  child: Text(
                    'Students',
                    style: TextStyle(fontSize: 24),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class FourthRow extends StatelessWidget {
  const FourthRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: constraints.maxHeight * 0.5,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffbfd7ed)),
                  child: const SizedBox(
                    width: 546,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          QuestionAnswers(
                            questionNum: 1,
                            selectedAnswer: "D",
                          ),
                          QuestionAnswers(
                            questionNum: 2,
                            selectedAnswer: "D",
                          ),
                          QuestionAnswers(
                            questionNum: 3,
                            selectedAnswer: "B",
                          ),
                          QuestionAnswers(
                            questionNum: 4,
                            selectedAnswer: "A",
                          ),
                          QuestionAnswers(
                            questionNum: 5,
                            selectedAnswer: "C",
                          ),
                          QuestionAnswers(
                            questionNum: 6,
                            selectedAnswer: "A",
                          ),
                          QuestionAnswers(
                            questionNum: 7,
                            selectedAnswer: "B",
                          ),
                          QuestionAnswers(
                            questionNum: 8,
                            selectedAnswer: "B",
                          ),
                          QuestionAnswers(
                            questionNum: 10,
                            selectedAnswer: "D",
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            width: 25,
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffbfd7ed)),
                  child: SizedBox(
                    width: 546,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StudentDetail(
                              studentId: "S2132421", studentName: "Ikhwan Lol"),
                          StudentDetail(
                              studentId: "S2132421", studentName: "Ikhwan Lol"),
                          AddStudent(),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        )
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 500,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: blueButtonText,
                foregroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                ("Save"),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class QuestionAnswers extends StatefulWidget {
  const QuestionAnswers({
    super.key,
    required this.questionNum,
    required this.selectedAnswer,
  });

  final int questionNum;
  final String selectedAnswer;

  @override
  State<QuestionAnswers> createState() => _QuestionAnswersState();
}

class _QuestionAnswersState extends State<QuestionAnswers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 750,
        height: 70,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${widget.questionNum}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: AnswerSelection(
                          letter: "A",
                          fill: widget.selectedAnswer == "A" ? true : false,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: AnswerSelection(
                          letter: "B",
                          fill: widget.selectedAnswer == "B" ? true : false,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: AnswerSelection(
                          letter: "C",
                          fill: widget.selectedAnswer == "C" ? true : false,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: AnswerSelection(
                          letter: "D",
                          fill: widget.selectedAnswer == "D" ? true : false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnswerSelection extends StatefulWidget {
  const AnswerSelection({
    super.key,
    required this.letter,
    required this.fill,
  });

  final String letter;
  final bool fill;

  @override
  State<AnswerSelection> createState() => _AnswerSelectionState();
}

class _AnswerSelectionState extends State<AnswerSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: widget.fill ? correctColour : backgroundColor,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.black, width: 1)),
        child: SizedBox(
          width: 30,
          height: 25,
          child: Center(
            child: Text(widget.letter),
          ),
        ));
  }
}

class StudentDetail extends StatefulWidget {
  const StudentDetail({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  final String studentId;
  final String studentName;

  @override
  State<StudentDetail> createState() => StudentDetailState();
}

class StudentDetailState extends State<StudentDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 750,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 100.0,
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    ("Student ID"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    (":"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      (widget.studentId),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: 100.0,
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    ("Name"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    (":"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      (widget.studentName),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 750,
        height: 70,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
                      iconSize: 30.0,
                    ),
                  ),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: Text("Click to add student data"),
              )
            ]),
          ],
        ),
      ),
    );
  }
}

class TitleIconTextButtonWidget extends StatelessWidget {
  const TitleIconTextButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/dashboard');
        },
        style: TextButton.styleFrom(
          iconColor: Colors.black,
          foregroundColor: Colors.black,
        ),
        icon: const Icon(Icons.arrow_back),
        label: const Text(
          'Details',
          style: TextStyle(fontSize: 32),
        ));
  }
}
