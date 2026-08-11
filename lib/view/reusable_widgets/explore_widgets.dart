import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreWidgets extends StatelessWidget {
  const ExploreWidgets({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.tag,
  });
  final String iconPath;
  final String title;
  final String subtitle;
  final Function()? onTap;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: tag != null
                    ? Hero(
                        tag: tag!,
                        child: SvgPicture.asset(iconPath, height: 40),
                      )
                    : SvgPicture.asset(iconPath, height: 40),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        textStyle: text.headlineMedium?.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        textStyle: text.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Icon(Icons.chevron_right, size: 50, color: Colors.grey.shade700),
            ],
          ),
        ),
      ),
    );
  }
}
