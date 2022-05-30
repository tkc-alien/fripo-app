class AnswerInfo {
  AnswerInfo({
    required this.userId,
    required this.answer,
    required this.score,
    required this.parentMarkedPoint,
  });

  factory AnswerInfo.fromMap(Map<dynamic, dynamic> map) {
    return AnswerInfo(
      userId: map['userId'],
      answer: map['answer'],
      score: map['score'],
      parentMarkedPoint: map['parentMarkedPoint'],
    );
  }

  final String userId;
  final String answer;
  final int score;
  final int parentMarkedPoint;
}
