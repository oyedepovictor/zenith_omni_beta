import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenith_omni/controller/quiz_controller.dart';
import 'package:zenith_omni/view/reusable_widgets/quiz_option.dart';

class QuizPages extends StatefulWidget {
  const QuizPages({
    super.key,
    required this.categoryName,
    required this.categoryID,
  });
  final String categoryName;
  final String categoryID;
  @override
  State<QuizPages> createState() => _QuizPagesState();
}

class _QuizPagesState extends State<QuizPages> {
  QuizController quizController = QuizController();
  bool isLoading = true;
  String? selectedAnswer;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    try {
      setState(() => isLoading = true);
      await quizController.getQuizData(int.parse(widget.categoryID));
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void checkAnswer(String answer) {
    if (selectedAnswer != null) return;

    setState(() {
      selectedAnswer = answer;
      quizController.correctAnswer(answer);
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          selectedAnswer = null;
          if (quizController.isFinished()) {
            showResultDialog();
          } else {
            quizController.nextQuestion();
          }
        });
      }
    });
  }

  void showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text(
          'Your Score: ${quizController.score}/${quizController.questions.length}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: const Text('Finish'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() {
                isLoading = true;
                quizController.reset();
              });
              // Pass refresh: true to force the API to get new questions
              await quizController.getQuizData(
                int.parse(widget.categoryID),
                refresh: true,
              );
              if (mounted) {
                setState(() => isLoading = false);
              }
            },
            child: const Text('New Questions'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 1. Show spinner while fetching
    if (isLoading) {
      return Scaffold(
        backgroundColor: scheme.surface,
        body: Center(child: CircularProgressIndicator(color: scheme.primary)),
      );
    }

    // 2. Show error if finished loading but list is still empty
    if (quizController.questions.isEmpty) {
      return Scaffold(
        backgroundColor: scheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 50, color: Colors.red),
              const SizedBox(height: 10),
              const Text("Failed to load questions."),
              TextButton(onPressed: loadData, child: const Text("Try Again")),
            ],
          ),
        ),
      );
    }

    // 3. Main Quiz UI
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.categoryName} • Q${quizController.questionIndex + 1} of ${quizController.questions.length}",
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Score ${quizController.score}",
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: List.generate(quizController.questions.length, (
                  index,
                ) {
                  return Expanded(
                    child: Container(
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index <= quizController.questionIndex
                            ? scheme.primary
                            : Colors.grey.shade300,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quizController
                            .questions[quizController.questionIndex]
                            .questionText,
                        style: GoogleFonts.poppins(
                          textStyle: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ...List.generate(
                        quizController
                            .questions[quizController.questionIndex]
                            .options
                            .length,
                        (i) {
                          final option = quizController
                              .questions[quizController.questionIndex]
                              .options[i];
                          return QuizOption(
                            text: option,
                            label: String.fromCharCode(65 + i),
                            onTap: () => checkAnswer(option),
                            isSelected: selectedAnswer == option,
                            isCorrect:
                                quizController
                                    .questions[quizController.questionIndex]
                                    .correctAnswer ==
                                option,
                            hasAnswered: selectedAnswer != null,
                          );
                        },
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Tap an answer",
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Code for building an option
}
