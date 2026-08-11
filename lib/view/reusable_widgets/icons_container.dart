import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'homescreen_container.dart';
import 'package:google_fonts/google_fonts.dart';

class IconsContainer extends StatelessWidget {
  const IconsContainer({super.key, required this.iconPath, required this.text});
  final String iconPath;
  final String text;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: HomescreenContainer(
        color: scheme.surface,
        height: 100,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(iconPath, height: 40),
              SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: GoogleFonts.poppins(
                  textStyle: textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
