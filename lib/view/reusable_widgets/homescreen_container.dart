import 'package:flutter/material.dart';

class HomescreenContainer extends StatelessWidget {
  const HomescreenContainer({
    super.key,
    required this.child,
    required this.height,
    required this.color,
  });
  final Widget child;
  final double height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
