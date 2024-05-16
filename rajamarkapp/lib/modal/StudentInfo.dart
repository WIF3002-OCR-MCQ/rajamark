import 'package:flutter/material.dart';

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

StudentInfo parseInputString(String input, int answerLength) {
  String studentID = '';
  String studentName = '';
  List<String> studentAnswers = [];

  List<String> lines = input.split('\n');

  for (String line in lines) {
    String normalizedLine = line.trim().toUpperCase();

    if (normalizedLine.startsWith('STUDENT ID')) {
      studentID = extractValue(line);
    }

    if (normalizedLine.startsWith('STUDENT NAME')) {
      studentName = extractValue(line);
    }

    // Attempt to extract student answers (assuming answers start with a digit followed by a space and a letter)
    //  List<String> tokens = normalizedLine.split(RegExp(r'\s+')).where((token) => token.isNotEmpty).toList();
    // if (tokens.isNotEmpty && RegExp(r'^\d+$').hasMatch(tokens.first)) {
    //   // Extract individual answer choices
    //   for (int i = 0; i < tokens.length; i += 2) {
    //     if (i + 1 < tokens.length) {
    //       studentAnswers.add(tokens[i + 1]);
    //     }
    //   }
    // }

    // Attempt to extract student answers (assuming answers start with a digit followed by a dot and/or space then a letter)
    List<String> tokens = normalizedLine
        .split(RegExp(r'\s*\.\s*'))
        .where((token) => token.isNotEmpty)
        .toList();
    if (tokens.length == 2 &&
        RegExp(r'^\d+$').hasMatch(tokens.first) &&
        tokens.last.length == 1) {
      studentAnswers.add(tokens.last);
    }
  }

  if (studentAnswers.length != answerLength) {
    while (studentAnswers.length < answerLength) {
      studentAnswers.add('');
    }
  }

  return StudentInfo(
    studentID: studentID.trim().replaceAll(' ', ''),
    studentName: studentName.trim(),
    studentAnswers: studentAnswers,
  );
}

// Helper function to extract the value after the some character
String extractValue(String line) {
  RegExp regExp =
      RegExp(r'Student (Id|Name)\s*[:=-]?\s*(.*)', caseSensitive: false);
  Match? match = regExp.firstMatch(line);
  if (match != null && match.groupCount >= 2) {
    return match.group(2)!;
  }
  return '';
}
