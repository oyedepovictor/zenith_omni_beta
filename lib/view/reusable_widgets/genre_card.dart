import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenreCard extends StatelessWidget {
  final String title;
  final String tracks;
  final String iconPath;
  final Color color;
  final VoidCallback onTap;

  const GenreCard({
    super.key,
    required this.title,
    required this.tracks,
    required this.iconPath,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              color.withValues(alpha: 0.6), // Smooth mood gradient
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                Text(
                  '$tracks tracks',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                iconPath,
                height: 60,
                // Creates a glass-morphism effect
              ),
            ),
          ],
        ),
      ),
    );
  }
}
