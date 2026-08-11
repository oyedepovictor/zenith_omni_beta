import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultHeader extends StatelessWidget {
  const ResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.scale_rounded,
            color: Colors.orange,
            size: 28,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            'Your result',
            style: GoogleFonts.poppins(
              textStyle: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
