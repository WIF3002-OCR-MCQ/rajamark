import 'package:flutter/material.dart';
import 'package:rajamarkapp/auth/login.dart';
import 'package:rajamarkapp/dashboard/account.dart';
import 'package:rajamarkapp/dashboard/exam.dart';
import 'package:rajamarkapp/dashboard/exam_detail.dart';
import 'package:rajamarkapp/dashboard/user_manual.dart';
import 'package:rajamarkapp/shared/sidebar.dart';
import 'package:rajamarkapp/shared/top_row_widget.dart';

class StudentAnswerPage extends StatefulWidget {
  const StudentAnswerPage({
    Key? key,
  }) : super(key: key);

  @override
  _StudentAnswerPageState createState() => _StudentAnswerPageState();
}

class _StudentAnswerPageState extends State<StudentAnswerPage> {
  Widget _currentContent = const StudentAnswerBody();


  void _showExamDashboard() {
    setState(() {
      _currentContent = const ExamDashboard();
    });
  }

  void _userManualView() {
    setState(() {
      _currentContent = const UserManual();
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            // Mobile layout
            return Column(
              children: [
                Sidebar(
                  onExamTap: _showExamDashboard,
                  onManualTap: _userManualView, 
                  onLogoutTap: _logout,
                ),
                Expanded(
                  child: _currentContent,
                ),
              ],
            );
          } else {
            // Desktop layout
            return Row(
              children: [
                Sidebar(
                  onExamTap: _showExamDashboard,
                  onManualTap: _userManualView, 
                  onLogoutTap: _logout,
                ),
                Expanded(
                  child: _currentContent,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class StudentAnswerBody extends StatelessWidget {
  const StudentAnswerBody({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopRowWidget(),
            SecondRow(),
            SizedBox(child: Divider(thickness: 2, color: Color(0xff88899D))),
            ThirdRow(),
            FourthRow(),
          ],
        ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(flex: 1, child: StudentAnswerTitle()),
          Expanded(
            flex: 0,
            child: Container(
              width: 25,
            ),
          ),
          const Expanded(
              flex: 1,
              child: Text(
                'Paper Image',
                style: TextStyle(fontSize: 24),
              )),
        ],
      ),
    );
  }
}

class FourthRow extends StatelessWidget {
  const FourthRow({super.key});
  @override
  Widget build(BuildContext context) {
    //Insert student answer API
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffbfd7ed)),
            child: const SizedBox(
              width: 546,
              height: 582,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //Insert listView builder here with student answer API
                    StudentAnswerQuestion(
                        questionNum: 1,
                        answer: [1, 1, 0, 1],
                        selectedAnswer: [0, 0, 0, 1]),
                    StudentAnswerQuestion(
                        questionNum: 2,
                        answer: [0, 0, 0, 1],
                        selectedAnswer: [0, 0, 0, 1]),
                    StudentAnswerQuestion(
                        questionNum: 3,
                        answer: [0, 0, 0, 1],
                        selectedAnswer: [0, 0, 0, 1]),
                    StudentAnswerQuestion(
                        questionNum: 4,
                        answer: [0, 0, 0, 1],
                        selectedAnswer: [0, 0, 1, 1]),
                    StudentAnswerQuestion(
                        questionNum: 5,
                        answer: [0, 0, 0, 1],
                        selectedAnswer: [0, 0, 0, 1]),
                    StudentAnswerQuestion(
                        questionNum: 6,
                        answer: [0, 1, 0, 1],
                        selectedAnswer: [0, 0, 0, 1]),
                  ],
                ),
              ),
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
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffbfd7ed)),
            child: SizedBox(
              width: 546,
              height: 582,
              child: Image.asset(
                'images/4.png',
                width: 750,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class StudentAnswerQuestion extends StatefulWidget {
  const StudentAnswerQuestion(
      {super.key,
      required this.questionNum,
      required this.answer,
      required this.selectedAnswer});
  final int questionNum;
  final List<int> answer;
  final List<int> selectedAnswer;
  @override
  State<StudentAnswerQuestion> createState() => _StudentAnswerQuestionState();
}

class _StudentAnswerQuestionState extends State<StudentAnswerQuestion> {
  @override
  Widget build(BuildContext context) {
    int points = 0;
    List<int> choice = [0, 0, 0, 0];

    for (int i = 0; i < widget.answer.length; i++) {
      if (widget.answer[i] == 1 && widget.selectedAnswer[i] == 1) {
        points++;
        choice[i] = 1;
      } else if (widget.answer[i] == 0 && widget.selectedAnswer[i] == 0) {
        continue;
      } else {
        choice[i] = -1;
        points--;
      }
    }

    if (points < 0) {
      points = 0;
    }

    Color getColor(int correct) {
      if (correct == 1) {
        return Color(0xff6fb293);
      } else if (correct == -1) {
        return Color(0xffe54a50);
      } else {
        return Colors.white;
      }
    }

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
                  style: const TextStyle(fontSize: 15),
                ),
                Row(
                  children: [
                    const Text(
                      'Points',
                      style: TextStyle(fontSize: 15),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: Text('$points'),
                          ),
                        )),
                  ],
                )
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
                          decoration: BoxDecoration(
                              color: getColor(choice[0]),
                              borderRadius: BorderRadius.circular(3),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const SizedBox(
                            width: 30,
                            height: 25,
                            child: Center(
                              child: Text('A'),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: getColor(choice[1]),
                              borderRadius: BorderRadius.circular(3),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const SizedBox(
                            width: 30,
                            height: 25,
                            child: Center(
                              child: Text('B'),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: getColor(choice[2]),
                              borderRadius: BorderRadius.circular(3),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const SizedBox(
                            width: 30,
                            height: 25,
                            child: Center(
                              child: Text('C'),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: getColor(choice[3]),
                              borderRadius: BorderRadius.circular(3),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const SizedBox(
                            width: 30,
                            height: 25,
                            child: Center(
                              child: Text('D'),
                            ),
                          )),
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

class StudentAnswerTitle extends StatelessWidget {
  const StudentAnswerTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text(
            'Student Answer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: const BoxDecoration(
                color: Color(0xffbfd7ed),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            width: 203,
            height: 36,
            child: const Center(
              child: Text(
                '3/4',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
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
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(
          iconColor: Colors.black,
          foregroundColor: Colors.black,
        ),
        icon: const Icon(Icons.arrow_back),
        label: const Text(
          'Results (View)',
          style: TextStyle(fontSize: 32),
        ));
  }
}
