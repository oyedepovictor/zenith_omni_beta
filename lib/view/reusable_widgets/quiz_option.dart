import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  const QuizOption({
    super.key,
    required this.text,
    required this.label,
    required this.onTap,
    required this.isSelected,
    required this.isCorrect,
    required this.hasAnswered,
  });

  final String text;
  final String label;
  final Function()? onTap;
  final bool isSelected;
  final bool isCorrect;
  final bool hasAnswered;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Color borderColor = scheme.outlineVariant;
    Widget? feedbackIcon;
    // or use Icon? but widget is better.

    if (hasAnswered) {
      if (isCorrect) {
        borderColor = Colors.green;
        feedbackIcon = const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else if (isSelected) {
        borderColor = Colors.red;
        feedbackIcon = const Icon(Icons.cancel, color: Colors.red, size: 20);
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: hasAnswered && isCorrect
              ? Colors.green.withValues(alpha: 0.1)
              : (isSelected
                    ? Colors.red.withValues(alpha: 0.1)
                    : scheme.surfaceContainer),
          border: Border.all(
            color: borderColor,
            width: hasAnswered && (isSelected || isCorrect) ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Text(
              "$label. ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
              ),
            ),
            Expanded(
              child: Text(text, style: TextStyle(color: scheme.onSurface)),
            ),
            feedbackIcon ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
