import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../reusable_widgets/bmi_gauge.dart';
import '../../reusable_widgets/result_header.dart';
import '../../reusable_widgets/stat_box.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
    required this.height,
    required this.weight,
    required this.age,
  });

  final String bmiResult;
  final String resultText;
  final String interpretation;
  final String height;
  final String weight;
  final String age;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                // 1. Header component
                const ResultHeader(),
                const SizedBox(height: 25),

                // 2. Row of summary boxes
                Row(
                  children: [
                    Expanded(
                      child: StatBox(
                        label: 'Height',
                        value: height,
                        unit: 'cm',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatBox(
                        label: 'Weight',
                        value: weight,
                        unit: 'kg',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatBox(label: 'Age', value: age, unit: 'yrs'),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // 3. Main Purple Result Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'YOUR BMI',
                        style: GoogleFonts.poppins(
                          color: scheme.onPrimary.withValues(alpha: 0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      FittedBox(
                        child: Text(
                          bmiResult,
                          style: GoogleFonts.poppins(
                            fontSize: 85,
                            fontWeight: FontWeight.w800,
                            color: scheme.onPrimary,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              resultText,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: scheme.onPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.check_rounded, color: scheme.onPrimary),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // 4. The Gauge component
                      BmiGauge(bmi: double.parse(bmiResult)),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // 5. Bottom Navigation
                OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 65),
                    side: BorderSide(color: scheme.outlineVariant),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Recalculate',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
