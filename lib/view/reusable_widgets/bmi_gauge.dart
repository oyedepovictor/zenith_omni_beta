import 'package:flutter/material.dart';

import 'gauge_segment.dart';

class BmiGauge extends StatelessWidget {
  final double bmi;
  const BmiGauge({super.key, required this.bmi});

  @override
  Widget build(BuildContext context) {
    double dotPos = -0.75;
    if (bmi >= 18.5 && bmi < 25) {
      dotPos = -0.25;
    } else if (bmi >= 25 && bmi < 30) {
      dotPos = 0.25;
    } else if (bmi >= 30) {
      dotPos = 0.75;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          children: [
            GaugeSegment(color: Colors.blue, label: 'Under'),
            GaugeSegment(color: Colors.green, label: 'Normal'),
            GaugeSegment(color: Colors.orange, label: 'Over'),
            GaugeSegment(color: Colors.red, label: 'Obese'),
          ],
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            const SizedBox(height: 14, width: double.infinity),
            Align(
              alignment: Alignment(dotPos, 0),
              child: Container(
                height: 14,
                width: 14,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
