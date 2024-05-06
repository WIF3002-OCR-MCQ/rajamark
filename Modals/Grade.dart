class Grade {
  String gradeId;
  String examId;
  String gradeLabel;
  int upperScore;
  int lowerScore;

  Grade({
    required this.gradeId,
    required this.examId,
    required this.gradeLabel,
    required this.upperScore,
    required this.lowerScore,
  });

  Grade.fromJson(Map<String, dynamic> json)
      : gradeId = json['gradeId'],
        examId = json['examId'],
        gradeLabel = json['gradeLabel'],
        upperScore = json['upperScore'],
        lowerScore = json['lowerScore'];

  Map<String, dynamic> toJson() => {
        'gradeId': gradeId,
        'examId': examId,
        'gradeLabel': gradeLabel,
        'upperScore': upperScore,
        'lowerScore': lowerScore,
      };
}
