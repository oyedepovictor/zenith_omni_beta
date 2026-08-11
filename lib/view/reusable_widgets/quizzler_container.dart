import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizzlerContainer extends StatelessWidget {
  const QuizzlerContainer({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: scheme.primary, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: SvgPicture.asset(iconPath, height: 60),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                subtitle,
                style: GoogleFonts.poppins(
                  textStyle: text.bodySmall?.copyWith(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
