class StudentInfo {
  String studentID;
  String studentName;
  List<String> studentAnswers;

  StudentInfo({
    required this.studentID,
    required this.studentName,
    required this.studentAnswers,
  });
}
 
StudentInfo parseInputString(String input) {
  String studentID = '';
  String studentName = '';
  List<String> studentAnswers = [];

  List<String> lines = input.split('\n');

  for (String line in lines) {
    String normalizedLine = line.trim().toLowerCase();

    if (normalizedLine.startsWith('student id')) {
      studentID = extractValue(line);
    }

    if (normalizedLine.startsWith('student name')) {
      studentName = extractValue(line);
    }

    // Attempt to extract student answers (assuming answers start with a digit followed by a space and a letter)
     List<String> tokens = normalizedLine.split(RegExp(r'\s+')).where((token) => token.isNotEmpty).toList();
    if (tokens.isNotEmpty && RegExp(r'^\d+$').hasMatch(tokens.first)) {
      // Extract individual answer choices
      for (int i = 0; i < tokens.length; i += 2) {
        if (i + 1 < tokens.length) {
          studentAnswers.add(tokens[i + 1]);
        }
      }
    }
  }

  return StudentInfo(
    studentID: studentID.trim(),
    studentName: studentName.trim(),
    studentAnswers: studentAnswers,
  );
}

  // Helper function to extract the value after the some character
  String extractValue(String line) {
    RegExp regExp = RegExp(r'Student (Id|Name)\s*[:=-]?\s*(.*)', caseSensitive: false);
    Match? match = regExp.firstMatch(line);
    if (match != null && match.groupCount >= 2) {
      return match.group(2)!; 
    }
    return '';
}