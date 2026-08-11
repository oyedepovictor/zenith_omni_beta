class Questions {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Questions({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });
}

final Map<String, int> categories = {
  'Geography': 22,
  'History': 23,
  'Movies': 11,
  'Music': 12,
  'Nature': 17,
  'Science': 18,
  'Sports': 21,
  'Technology': 30,
};
