import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIContainer extends StatelessWidget {
  const BMIContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  final String title;
  final Icon icon;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          // Soft primary tint when selected, clean white/grey when not
          color: isSelected
              ? scheme.primary.withValues(alpha: 0.1)
              : scheme.surfaceContainerLow,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            // Highlight border when selected
            color: isSelected ? scheme.primary : scheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon color changes to primary when active
            Icon(
              icon.icon,
              size: 60,
              color: isSelected ? scheme.primary : scheme.onSurfaceVariant,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                textStyle: textTheme.titleMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? scheme.primary : scheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
