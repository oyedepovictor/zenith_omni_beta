import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BmiSlidersContainer extends StatefulWidget {
  const BmiSlidersContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.initialValue,
    required this.min,
    required this.max,
    required this.onChanged,
  });
  final String title;
  final String subtitle;
  final int initialValue;
  final double min;
  final double max;
  final ValueChanged<int> onChanged;
  @override
  State<BmiSlidersContainer> createState() => _BmiSlidersContainerState();
}

class _BmiSlidersContainerState extends State<BmiSlidersContainer> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // REMOVED: int height = 180; (This was causing the crash)

    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: scheme.surfaceContainerLow,
        border: Border.all(color: scheme.outlineVariant, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    textStyle: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      currentValue.toString(), // Use currentValue here
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.subtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              activeTrackColor: scheme.primary,
              inactiveTrackColor: scheme.outlineVariant,
              thumbColor: scheme.primary,
            ),
            child: Slider(
              value: currentValue.toDouble(), // Use currentValue here
              min: widget.min,
              max: widget.max,
              onChanged: (double newValue) {
                setState(() {
                  currentValue = newValue.round();
                });
                widget.onChanged(
                  currentValue,
                ); // Pass the new value to the parent widget
              },
            ),
          ),
        ],
      ),
    );
  }
}
