import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/src/widgets/scrollable.dart';

class UserManual extends StatefulWidget {
  const UserManual({Key? key}) : super(key: key);

  @override
  _UserManualState createState() => _UserManualState();
}

class _UserManualState extends State<UserManual> {
  late ScrollController _scrollController;
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  bool _showSearchResults = false;

  // To define global keys for each section to identify them
  final Map<String, GlobalKey> _sectionKeys = {
    'Introduction': GlobalKey(),
    'Getting Started': GlobalKey(),
    'Features': GlobalKey(),
    'Troubleshooting': GlobalKey(),
    'Best Practices': GlobalKey(),
    'Glossary': GlobalKey(),
    'FAQ': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // To scroll to a specific section when user clicks on Manual Index
  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _updateSearchResults(String query) {
    setState(() {
      _searchResults = _filterSections(query);
      _showSearchResults =
          _searchController.text.isNotEmpty && _searchResults.isNotEmpty;
    });
  }

  void _hideSearchResults() {
    setState(() {
      _searchResults.clear();
      _showSearchResults = false;
    });
  }

  // To filter sections based on search query
  List<String> _filterSections(String query) {
    query = query.toLowerCase();
    List<String> filteredSections = [];

    // Iterate over each section
    _sectionKeys.forEach((section, key) {
      // Get the content of the section
      Widget? contentWidget = _getContent(section);

      // Check if the contentWidget is not null
      if (contentWidget != null) {
        String content = contentWidget.toString().toLowerCase();

        // Check if the query exists in content
        if (content.contains(query)) {
          filteredSections.add(section);
        }
      }

      _aliasToSection(section, filteredSections, query);
    });

    return filteredSections;
  }

  List<String> _aliasToSection(section, filteredSections, query) {
    switch (query) {
      case 'requirements':
      case 'os':
      case 'install':
      case 'installation':
      case 'setup':
      case 'navigation':
        if (!filteredSections.contains('Getting Started')) {
          filteredSections.add('Getting Started');
        }
        break;
      case 'exam':
      case 'answer':
        if (!filteredSections.contains('Features')) {
          filteredSections.add('Features');
        }
        break;
      case 'support':
        if (!filteredSections.contains('Troubleshooting')) {
          filteredSections.add('Troubleshooting');
        }
        break;
      case 'tips':
        if (!filteredSections.contains('Best Practices')) {
          filteredSections.add('Best Practices');
        }
        break;
      default:
        break;
    }

    return filteredSections;
  }

  // To retrieve content widget for a given section
  Widget? _getContent(String section) {
    switch (section.toLowerCase()) {
      case 'introduction':
        return Introduction();
      case 'getting started':
        return GettingStarted();
      case 'features':
        return Features();
      case 'troubleshooting':
        return Troubleshooting();
      case 'best practices':
        return BestPractices();
      case 'glossary':
        return Glossary();
      case 'faq':
        return FAQ();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector is to detect taps outside the search container
      onTap: () {
        FocusScope.of(context).unfocus(); // Unfocus text field
        _hideSearchResults(); // Hide search results
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Manual'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.all(10.0),
            //   child: Container(
            //     width: 500,
            //     child: Column(
            //       children: [
            //         TextField(
            //           controller: _searchController,
            //           onChanged: _updateSearchResults,
            //           decoration: InputDecoration(
            //             labelText: "Find",
            //             hintText: "Find in user manual",
            //             prefixIcon: Icon(Icons.search),
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //         if (_showSearchResults)
            //           Container(
            //             decoration: BoxDecoration(
            //               color: Colors.grey[200],
            //               borderRadius: BorderRadius.circular(5.0),
            //             ),
            //             width: 500,
            //             padding: EdgeInsets.all(10.0),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: _searchResults.map((section) {
            //                 return InkWell(
            //                   onTap: () {
            //                     _scrollToSection(section);
            //                     _hideSearchResults(); // Hide search results after tapping section
            //                   },
            //                   child: Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(vertical: 5.0),
            //                     child: Text(section),
            //                   ),
            //                 );
            //               }).toList(),
            //             ),
            //           ),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ManualIndex(
                      scrollToSection: _scrollToSection,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ManualContent(
                      scrollController: _scrollController,
                      sectionKeys: _sectionKeys,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ManualIndex extends StatelessWidget {
  final Function(String) scrollToSection;

  ManualIndex({required this.scrollToSection});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Introduction'),
          onTap: () => scrollToSection('Introduction'),
        ),
        ListTile(
          title: Text('Getting Started'),
          onTap: () => scrollToSection('Getting Started'),
        ),
        ListTile(
          title: Text('Features'),
          onTap: () => scrollToSection('Features'),
        ),
        ListTile(
          title: Text('Troubleshooting'),
          onTap: () => scrollToSection('Troubleshooting'),
        ),
        ListTile(
          title: Text('Best Practices'),
          onTap: () => scrollToSection('Best Practices'),
        ),
        ListTile(
          title: Text('Glossary'),
          onTap: () => scrollToSection('Glossary'),
        ),
        ListTile(
          title: Text('FAQ'),
          onTap: () => scrollToSection('FAQ'),
        ),
      ],
    );
  }
}

class ManualContent extends StatelessWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  ManualContent({
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Introduction(key: sectionKeys['Introduction']),
          GettingStarted(key: sectionKeys['Getting Started']),
          Features(key: sectionKeys['Features']),
          Troubleshooting(key: sectionKeys['Troubleshooting']),
          BestPractices(key: sectionKeys['Best Practices']),
          Glossary(key: sectionKeys['Glossary']),
          FAQ(key: sectionKeys['FAQ']),
        ],
      ),
    );
  }
}

class Introduction extends StatelessWidget {
  final GlobalKey? key;

  Introduction({this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Introduction',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Meet RajaMark, your reliable helper to automate the grading of multiple-choice question (MCQ) answer sheets. '
            'By leveraging Tesseract OCR for handwritten text recognition and OpenCV for image preprocessing, RajaMark can '
            'swiftly and accurately interpret handwritten answers (A-E) beside question numbers. This automation eliminates the '
            'tedious and error-prone manual grading process, making it ideal for educational institutions seeking a more efficient '
            'grading solution. ',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          Text(
            'In addition to grading, RajaMark offers tools to compile class results, allowing educators to '
            'aggregate individual scores and generate comprehensive reports on class performance in quizzes and tests. This '
            'feature helps teachers quickly identify trends and areas for improvement, streamlining the assessment process. '
            'Overall, RajaMark is a valuable resource for schools and universities aiming to improve the speed and accuracy of '
            'MCQ evaluation while reducing the workload on educators. ',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class GettingStarted extends StatelessWidget {
  final GlobalKey? key;
  final TextStyle _textStyle1 = TextStyle(fontSize: 18);
  final TextStyle _textStyle2 = TextStyle(fontSize: 14);

  GettingStarted({this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Getting Started',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Operating System Requirements',
            style: _textStyle1,
          ),
          const SizedBox(height: 10),
          Text(
            'RajaMark requires (either one):',
            style: _textStyle2,
          ),
          const SizedBox(height: 10),
          Text(
            '- the 64-bit version of Microsoft Windows 10 or later. These versions of Windows should include the required Windows PowerShell 5 or later.',
            style: _textStyle2,
          ),
          const SizedBox(height: 10),
          Text(
            '- ChromeOS.',
            style: _textStyle2,
          ),
          const SizedBox(height: 25),
          Text(
            'Installation Steps',
            style: _textStyle1,
          ),
          const SizedBox(height: 10),
          Text(
            'To install RajaMark:',
            style: _textStyle2,
          ),
          const SizedBox(height: 10),
          Text(
            '1. Click here to access our Google Drive.',
            style: _textStyle2,
          ),
          const SizedBox(height: 10),
          Text(
            '2. Download the .exe file.',
            style: _textStyle2,
          ),
          const SizedBox(height: 10),
          Text(
            '3. Click the .exe file and allow it to make changes to your computer for execution.',
            style: _textStyle2,
          ),
          const SizedBox(height: 10),
          Text(
            '4. You are all set.',
            style: _textStyle2,
          ),

          // Account Setup
          const SizedBox(height: 25),
          Text(
            'Account Setup',
            style: _textStyle1,
          ),

          // Register
          const SizedBox(height: 10),
          Text(
            'i. Register',
            style: _textStyle1,
          ),
          const SizedBox(height: 10),
          Text(
            '\t\t1. Upon first launch into the system, you will be asked to enter your email and password to log into your existing account in the Login page.',
            style: _textStyle2,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'Images/reg1.png',
          ),
          Text(
            '\n\t\t2. If you have not set up an account before, click the “Don’t have an account? Register here” button. If you have already registered an account, go to Login.',
            style: _textStyle2,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'Images/reg2.png',
          ),
          Text(
            '\n\t\t3. You will be asked to give your email and password that you intend to use. Upon completing the registration, you will have to enter your password once again for confirmation.',
            style: _textStyle2,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'Images/reg3.png',
          ),
          Text(
            '\n\t\t4. Click the “Register” button once you have filled up the required information for registration.',
            style: _textStyle2,
          ),
          const SizedBox(height: 20),
          Text(
            '\t\t5. You will be redirected to the Login page if you have registered successfully.',
            style: _textStyle2,
          ),

          //Login
          const SizedBox(height: 20),
          Text(
            'ii. Login',
            style: _textStyle1,
          ),
          const SizedBox(height: 10),
          Text(
            '\t\t1. In the Login page, fill in your email and password then click on the “Log in” button.',
            style: _textStyle2,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'Images/login1.png',
            height: 400,
          ),
          Text(
            '\n\t\t2. If you have forgotten your password and wish to create a new one, proceed to Forgot Password.',
            style: _textStyle2,
          ),

          // Forget Password
          const SizedBox(height: 20),
          Text(
            'iii. Forgot Password',
            style: _textStyle1,
          ),
          const SizedBox(height: 10),
          Text(
            '\t\t1. Click on the “Forgot Password?” button.',
            style: _textStyle2,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'Images/reg2.png',
          ),
          Text(
            '\n\t\t2. Enter your registered email address to receive a password reset link to change your password.',
            style: _textStyle2,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'Images/forgetpass2.png',
            height: 400,
          ),
          Text(
            '\n\t\t3. You will be shown with this message if you have entered a valid email address.',
            style: _textStyle2,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'Images/forgetpass3.png',
            height: 400,
          ),

          //LogOut
          const SizedBox(height: 20),
          Text(
            'iv. Logout',
            style: _textStyle1,
          ),
          const SizedBox(height: 10),
          Text(
            '\t\t1. After successfully logged in, you will now see the Homepage (dashboard page) like the picture below:',
            style: _textStyle2,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'Images/homepage.png',
            width: 700,
          ),
          Text(
            '\n\t\t2. If you wish to log out, navigate to the navigation bar located at the leftmost of the screen and click on the “Logout” button. You will then be redirected to the Login page again.',
            style: _textStyle2,
          ),

          const SizedBox(height: 20),
          Text(
            'Navigation',
            style: _textStyle1,
          ),
          Image.asset(
            'Images/nav.png',
            width: 700,
          ),
          const SizedBox(height: 10),
          Text(
            '1.\t\tExam Page\n\nThe Exam Page contains all exams that have been created. The exams can be edited or deleted from this table. The date of creation will also be displayed on this page. It is also possible to create a new exam from this page.\n\n'
            '2.\t\tUser Manual Page\n\nThe User Manual Page contains the documentation of the user manual that provides detailed instructions on how to use this system effectively.\n\n'
            '3.\t\tLogout\n\nNavigate to the navigation bar located at the leftmost of the screen and click on the “Logout” button if you wish to log out from your account.',
            style: _textStyle2,
          ),
        ],
      ),
    );
  }
}

class Features extends StatelessWidget {
  final GlobalKey? key;

  Features({this.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle1 = TextStyle(fontSize: 18);
    final TextStyle textStyle2 = TextStyle(fontSize: 14);

    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Exam Creation',
            style: textStyle1,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _buildStepWithImage('1. Go to the Exam page.', ''),
              SizedBox(height: 10),
              _buildStepWithImage(
                  '2. Click on the “Create” button to create a new examination/quiz.',
                  'EC1.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '3. Enter the examination’s details and grading criteria.',
                  'EC2.png'),
              _buildStepWithImage(
                  '4. Scroll down to enter the answer scheme.', 'EC3.png'),
              _buildStepWithImage(
                  '5. Click the “save” button to create the examination record.',
                  ''),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '6. The examination record is successfully created.', ''),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Edit Examination',
            style: textStyle1,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _buildStepWithImage('1. Go to the Exam page.', ''),
              SizedBox(height: 10),
              _buildStepWithImage(
                  '2. Click on the “edit” icon for the specific exam to be edited.',
                  'EE1.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '3. Enter the changes required in the Edit Exam page.',
                  'EE2.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '4. Scroll down and click the “save” button to apply the changes.',
                  ''),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "View Exam's Details",
            style: textStyle1,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _buildStepWithImage('1. Go to the Exam page', ''),
              SizedBox(height: 10),
              _buildStepWithImage(
                  '2. Click on the “eye” icon for a specific exam to view the exam’s details..',
                  'VED1.png'),
              SizedBox(height: 10),
              _buildStepWithImage(
                  '3. You will be directed to the Exam Details page.',
                  'VED2.png'),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Manage student’s answer',
            style: textStyle1,
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              _buildStepWithImage('1. Go to the Exam page.', ''),
              SizedBox(height: 10),
              _buildStepWithImage(
                  '2. Click on the “eye” icon to view the exam’s details.',
                  'MSA1.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '3. Once redirected into the Exam Details page, navigate to the list of students’ records and '
                      'click on the “eye” icon to view the student’s details, “note” icon to edit the student\'s '
                      'details or “trash” icon to delete the student\'s information',
                  'MSA2.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '4. On the Student’s Details page, make the changes and click the “Save” button to save changes to the student\'s answer.',
                  'MSA3.png'),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Upload Sample Answer',
            style: textStyle1,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _buildStepWithImage('1. Go to the Exam page.', ''),
              SizedBox(height: 10),
              _buildStepWithImage(
                  '2. Click on the “eye” icon to view the exam’s details.',
                  'USAns1.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '3. Click on the “Upload answer” button to upload the sample answer scheme.',
                  'USAns2.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '4. Once redirected into the Answer Scheme page, click the “+” icon to upload the sample answer scheme.',
                  'USAns3.png'),
              _buildStepWithImage(
                  '5. Upload the answer scheme file.', 'USAns4.png'),
              _buildStepWithImage(
                  '6. If the image processing fails, try to upload another file with a clearer view of the answer scheme.',
                  'USAns5.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '7. Wait for the file to be processed.', 'USAns6.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '8. Click the “confirm” button to apply the answer scheme.',
                  'USAns8.png'),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Upload Student Answer',
            style: textStyle1,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _buildStepWithImage('1. Go to the Exams page.', ''),
              SizedBox(height: 10),
              _buildStepWithImage(
                  '2. Select the “eye icon” of the exam you wish to grade.',
                  'USA2.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '3. Click the “View Answer” button at the top right corner.',
                  'USA3.png'),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '4. Click the "+" button to upload the student\'s answer sheet.',
                  'USA4.png'),
              _buildStepWithImage(
                  '5.After selecting a file, the system will automatically extract the data from the image. (Please refer to Best Practices to learn more about the guidelines for uploading the answer sheet)',
                  ''),
              SizedBox(height: 15),
              _buildStepWithImage(
                  '6. The extracted student\'s answer sheet will be displayed.',
                  'USA6.png'),
              _buildStepWithImage(
                  '\t6.1 If the user wants to edit the answer sheet:', ''),
              _buildStepWithImage(
                  '\t\t6.1.1 Click the pen icon to edit.', 'USA6.1.1.png'),
              _buildStepWithImage(
                  '\t\t6.1.2 Modify the answer sheet and click on the save button to save the changes made.',
                  'USA6.1.2.png'),
              _buildStepWithImage(
                  '\t6.2 If the user wants to delete the record: ', ''),
              _buildStepWithImage(
                  '\t\t6.2.1 Click on the trash icon.', 'USA6.2.1.png'),
              _buildStepWithImage(
                  '\t\t6.2.2 A confirmation dialog will be shown.',
                  'USA6.2.2.png'),
              _buildStepWithImage(
                  '7. Repeat steps 4 to 6 to add more students as necessary.',
                  ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepWithImage(String text, String imageName) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.justify,
          ),
          if (imageName.isNotEmpty)
            Image.asset(
              'Images/$imageName', // Assuming the images are in the assets folder
              width: 500,
              height: 300,
              fit: BoxFit.contain,
            ),
        ],
      ),
    );
  }
}

class Troubleshooting extends StatelessWidget {
  final GlobalKey? key;

  Troubleshooting({this.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle _textStyle1 = TextStyle(fontSize: 18);
    final TextStyle _textStyle2 = TextStyle(fontSize: 14);

    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Troubleshooting',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Common Issues',
            style: _textStyle1,
          ),
          const SizedBox(height: 20),
          Container(
            width: 800,
            child: Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(0.3),
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('NO'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Issues'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Issue Description'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Solution'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('1'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Poor Image Quality')),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'OCR accuracy may decrease if the input images are of low resolution or contain artifacts such as blurriness or distortion.')),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Ensure that input images are clear, well-lit, and have sufficient resolution. Avoid using images with excessive noise or compression artifacts.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('2'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Unsupported Fonts')),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Certain fonts or styles may not be recognized accurately by the OCR system, leading to errors in text extraction.')),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Whenever possible, use standard fonts and avoid decorative or obscure fonts that may not be recognized reliably by the OCR system.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('3'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Complex Layouts')),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Documents with complex layouts, such as tables, columns, or mixed fonts, can pose challenges for OCR algorithms and result in incorrect text extraction.')),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'If possible, preprocess documents to remove complex layouts or convert them into simpler formats before performing OCR. This can help improve accuracy and reduce errors.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('4'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Handwritten Text')),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Our product is encountering difficulties accurately recognizing handwritten text')),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'For handwritten text, please ensure that the handwriting is clear and legible, and that the document is properly scanned or photographed for optimal results.')),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Support Contact',
            style: _textStyle1,
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'If you encounter any issues with the OCR system that cannot be resolved using the provided solutions, please contact our support team for assistance:',
                style: _textStyle2,
              ),
              Text(
                "",
                style: _textStyle2,
              ),
              Text(
                'Email: spqprojectmanager@gmail.com',
                style: _textStyle2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BestPractices extends StatelessWidget {
  final GlobalKey? key;

  BestPractices({this.key});

  @override
  Widget build(BuildContext context) {
    final List<BestPracticeItem> bestPractices = [
      BestPracticeItem(
        title: 'Student Answer Guidelines',
        items: [
          PracticeItem(
            description:
                '1. Student names and student IDs do not need to follow a specific order. Either one can be written first.',
          ),
          PracticeItem(
            description:
                '2. The system will recognize student names and IDs after the colon (:) symbol. Avoid using other symbols such as arrows (->) or hyphens (-) before writing the name and ID.',
          ),
          PracticeItem(
            description:
                '3. The phrases "Student Name" and "Student ID" are case-insensitive. You can write them as "sTuDeNt nAmE" or "sTUDENT ID", and the system will still recognize them.',
          ),
          PracticeItem(
            description:
                '4. Student Name and Student ID must be written in a single line only.',
          ),
          PracticeItem(
            description:
                '5. Student answers must be written in vertical format and each answer is separated by a new line.',
          ),
          PracticeItem(
            description:
                '6. For best OCR text extraction, use white blank paper only instead of foolscap paper or grid-lined paper.',
            imagePath: 'Images/tip0.jpg',
          ),
        ],
      ),
      BestPracticeItem(
        title: 'Sample Answer Guidelines',
        items: [
          PracticeItem(
            description:
                '1. Sample answers must be written in vertical format and each answer is separated by a new line.',
          ),
          PracticeItem(
            description:
                '2. For each line, include the question number and answer, separated by a space.',
                imagePath: 'Images/tip7.png',
          ),
        ],
      ),
      BestPracticeItem(
        title: 'Grading Tips',
        items: [
          PracticeItem(
            description:
                '1. Ensure students format answers consistently and legibly to aid OCR accuracy.',
            imagePath: 'Images/tip1.jpg',
          ),
          PracticeItem(
            description:
                '2. Advise clear separation of answers for each question to minimize ambiguity.',
            imagePath: 'Images/tip2.jpg',
          ),
          PracticeItem(
            description:
                '3. Caution against overlapping answers to enhance OCR interpretation.',
            imagePath: 'Images/tip3.jpg',
          ),
          PracticeItem(
            description:
                '4. Scan answers at high resolution in well-lit conditions for optimal recognition.',
          ),
          PracticeItem(
            description:
                '5. Encourage manual review of extracted text for clarity before submission.',
          ),
          PracticeItem(
            description:
                '6. Ensure students use dark, bold pens or pencils for writing to improve OCR readability.',
            imagePath: 'Images/tip4.jpg',
          ),
          PracticeItem(
            description:
                '7. Remind students to avoid excessive use of decorative elements or symbols that may interfere with OCR recognition.',
            imagePath: 'Images/tip5.jpg',
          ),
          PracticeItem(
            description:
                '8. Provide guidelines for students to write numbers and symbols clearly, especially those prone to misinterpretation.',
          ),
          PracticeItem(
            description:
                '9. Advise against folding or creasing answer sheets, as it can distort text and hinder OCR accuracy.',
          ),
          PracticeItem(
            description:
                '10. Recommend students to use a ruler or straight edge for neat alignment of answers to improve OCR alignment.',
            imagePath: 'Images/tip6.jpg',
          ),
        ],
      ),
      BestPracticeItem(
        title: 'Accuracy Recommendations',
        items: [
          PracticeItem(
            description:
                '1. Provide clear handwriting guidelines to optimize OCR recognition; for example, require all multiple-choice answers to be in capital letters.',
          ),
          PracticeItem(
            description:
                '2. Conduct regular practice sessions to familiarize students with handwriting recognition and improve their writing.',
          ),
          PracticeItem(
            description:
                '3. Offer constructive feedback to students to enhance handwriting quality and OCR accuracy.',
          ),
          PracticeItem(
            description:
                '4. Provide comprehensive user training to educators to address accuracy challenges effectively.',
          ),
          PracticeItem(
            description:
                '5. Develop a standardized answer sheet template with clear instructions and designated areas for answers to facilitate OCR processing.',
          ),
          PracticeItem(
            description:
                '6. Encourage students to practice writing in a consistent style and size to aid OCR recognition.',
          ),
        ],
      ),
    ];

    final TextStyle textStyle1 = TextStyle(fontSize: 18);
    final TextStyle textStyle2 = TextStyle(fontSize: 14);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Best Practices',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                for (final practice in bestPractices)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        practice.title,
                        style: textStyle1,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: practice.items.map((item) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.description,
                                style: textStyle2,
                              ),
                              if (item.imagePath !=
                                  null) // Only show image if imagePath is provided
                                const SizedBox(height: 10),
                              if (item.imagePath != null)
                                Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5, // Adjust the percentage as needed
                                    child: Image.asset(
                                      item.imagePath!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BestPracticeItem {
  final String title;
  final List<PracticeItem> items;

  BestPracticeItem({required this.title, required this.items});
}

class PracticeItem {
  final String description;
  final String? imagePath;

  PracticeItem({required this.description, this.imagePath});
}

class Glossary extends StatelessWidget {
  final GlobalKey? key;

  Glossary({this.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle _textStyle1 = TextStyle(fontSize: 18);
    final TextStyle _textStyle2 = TextStyle(fontSize: 14);

    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Glossary',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            width: 800,
            child: Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(0.3),
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Term'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Definition'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Optical Character Recognition (OCR)'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'The technology used to convert different types of documents, '
                              'such as scanned paper documents, PDF files, or images captured by a digital camera, into editable and '
                              'searchable data.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Resolution'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'The level of detail that an image holds. In the context of scanning, it measures the '
                              'number of pixels per inch (PPI) or dots per inch (DPI) in a digital image.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Layout'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'The arrangement of text, images, and other elements on a document or webpage.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Handwriting Recognition'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'The process of converting handwritten text into digital text. It involves analyzing '
                              'and interpreting handwritten characters to recognize and convert them into machine-readable text.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Calibration'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'The process of adjusting and fine-tuning equipment or software to ensure accuracy and '
                              'consistency in performance. In the context of scanning, calibration may involve adjusting settings '
                              'such as brightness, contrast, and color balance to optimize image quality.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Standardized Format'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'A predefined layout or structure that follows specific guidelines or conventions. '
                              'In the context of answer sheets, a standardized format ensures consistency in the presentation of '
                              'questions and answers, facilitating accurate interpretation and grading.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Alignment'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'The positioning of text or objects relative to a reference point or line. In the '
                              'context of OCR, alignment ensures that text is accurately detected and interpreted within '
                              'predefined boundaries or regions.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Noise'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Random variations or interference in an image that can degrade quality and affect '
                              'OCR accuracy.')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Preprocessing'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'The process of applying various techniques to raw data, such as images or text, to '
                              'improve quality, enhance features, or prepare it for further analysis.')),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
  final GlobalKey? key;
  FAQ({this.key});
}

class _FAQState extends State<FAQ> {
  final List<FAQItem> _faqs = [
    FAQItem(
        question: '1. Which platforms are RajaMark compatible with?',
        answer:
            'RajaMark is designed to be compatible with multiple operating systems, which are Windows, '
            'macOS, Linux, Android and iOS.'),
    FAQItem(
        question: '2. How does RajaMark automate answer sheet grading?',
        answer:
            'RajaMark assumes the adherence of the answer sheets uploaded to a standardized format and '
            'layout, and conducts recognition of students’ handwriting with OCR technology to compare the answers with '
            'the sample provided.'),
    FAQItem(
        question: '3. What format should the answer sheets uploaded be in?',
        answer:
            'The answer sheets (PNG) should have the answers consistently written next to the corresponding '
            'question numbers in a predetermined manner and written in Capital Letters (e.g., letters A-E)'),
    FAQItem(
        question:
            '4. How does RajaMark ensure its accuracy in text recognition to compare uploaded answer sheets with '
            'the sample answers?',
        answer:
            'While we try our best to produce the most accurate text recognition results using OCR technology, it '
            'is inevitable to face minor inaccuracies in detecting the handwritten answers. Hence, we highly advise users '
            'to conduct a thorough checking of the graded answers and make the necessary corrections on the Student Answer Page.'),
    FAQItem(
        question: '5. Can I modify the grading system for a subject?',
        answer:
            'Yes! After the user has created a subject under the Exam Details page, a default grade will be automatically '
            'set for the subject and users can click “Edit” to amend the existing grading system.'),
  ];

  @override
  Widget build(BuildContext context) {
    final TextStyle _textStyle1 = TextStyle(fontSize: 18);
    final TextStyle _textStyle2 = TextStyle(fontSize: 14);

    return Container(
      width: 900,
      padding: EdgeInsets.only(top: 0.0, right: 24.0, bottom: 28.0, left: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          for (int i = 0; i < _faqs.length; i++)
            GFAccordion(
              collapsedIcon: Icon(Icons.add),
              expandedIcon: Icon(Icons.minimize),
              collapsedTitleBackgroundColor:
                  const Color.fromARGB(255, 162, 180, 212),
              expandedTitleBackgroundColor:
                  const Color.fromARGB(255, 111, 143, 199),
              title: _faqs[i].question,
              content: _faqs[i].answer,
            ),
        ],
      ),
    );
  }
}

class FAQItem {
  String question;
  String answer;
  bool isExpanded;

  FAQItem(
      {required this.question, required this.answer, this.isExpanded = false});
}
