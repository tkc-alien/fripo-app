class AnswerInfo {
  AnswerInfo({
    required this.answer,
    required this.difference,
    required this.point,
  });

  factory AnswerInfo.fromMap(Map<dynamic, dynamic> map) {
    return AnswerInfo(
      answer: map['answer'],
      difference: map['difference'],
      point: map['point'],
    );
  }

  final String answer;
  final int? difference;
  final int? point;
}
