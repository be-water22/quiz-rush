class Question {
  final String questionId;
  final String text;
  final List<String> options;
  final String difficulty;
  final int timeLimitSecs;
  final int round;

  const Question({
    required this.questionId,
    required this.text,
    required this.options,
    required this.difficulty,
    this.timeLimitSecs = 15,
    this.round = 1,
  });
}
