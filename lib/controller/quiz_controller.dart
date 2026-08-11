import '../models/questions.dart';
import '../services/quiz_networking.dart';
import 'package:html_unescape/html_unescape.dart';

const openTriviaDB = 'https://opentdb.com/api.php?amount=10';

class QuizController {
  // STATIC CACHE: Remembers questions so navigating is INSTANT
  static final Map<int, List<Questions>> questionsCache = {};

  List<Questions> questions = [];
  int questionIndex = 0;
  int score = 0;
  var unescape = HtmlUnescape();

  Future<void> getQuizData(int category, {bool refresh = false}) async {
    // 1. Check Cache first (Makes it faster!)
    if (!refresh && questionsCache.containsKey(category)) {
      questions = questionsCache[category]!;
      reset();
      return;
    }

    // 2. Clear previous questions to prevent RangeError during loading
    questions = [];
    reset();

    var url = '$openTriviaDB&category=$category&type=multiple';
    NetworkHelper networkHelper = NetworkHelper(url);
    var quizData = await networkHelper.getData();

    if (quizData != null && quizData['response_code'] == 0) {
      List<dynamic> results = quizData['results'];
      questions = results.map((item) {
        List<String> options = List<String>.from(item['incorrect_answers']);
        options.add(item['correct_answer']);
        options.shuffle();
        return Questions(
          questionText: unescape.convert(item['question']),
          options: options,
          correctAnswer: item['correct_answer'],
        );
      }).toList();

      // Save to cache only if we actually got questions
      if (questions.isNotEmpty) {
        questionsCache[category] = questions;
      }
    }
  }

  void correctAnswer(String answer) {
    // Safety check: only check if the list is not empty
    if (questions.isNotEmpty &&
        answer == questions[questionIndex].correctAnswer) {
      score++;
    }
  }

  void nextQuestion() {
    if (questions.isNotEmpty && questionIndex < questions.length - 1) {
      questionIndex++;
    }
  }

  bool isFinished() {
    // Safety check: finished if empty or at the last index
    return questions.isEmpty || questionIndex >= questions.length - 1;
  }

  void reset() {
    questionIndex = 0;
    score = 0;
  }
}
