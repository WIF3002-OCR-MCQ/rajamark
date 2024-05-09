import 'package:flutter_test/flutter_test.dart';
import 'package:rajamarkapp/modal/student_info.dart';

void main() {
  test('Parsing valid input string should return correct StudentInfo object', () {
    String sampleText = '''
        sTudEnT NamE : John Cena
        stUDeNt iD : U9999999
        1 A 2 B 3 C 4 D
        5 D 6 C 7 B 8 A
        ''';
    StudentInfo studentInfo = parseInputString(sampleText);

    expect(studentInfo.studentID, 'U9999999');
    expect(studentInfo.studentName, 'John Cena');
    expect(studentInfo.studentAnswers, ['a', 'b', 'c', 'd', 'd', 'c', 'b', 'a']);
  });

  test('Parsing empty input string should return empty StudentInfo object', () {
    String emptyText = '';
    StudentInfo studentInfo = parseInputString(emptyText);

    expect(studentInfo.studentID, '');
    expect(studentInfo.studentName, '');
    expect(studentInfo.studentAnswers, isEmpty);
  });
}
