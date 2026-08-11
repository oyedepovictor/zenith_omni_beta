import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routing/app_routes.dart';

class BreathLottieScreen extends StatefulWidget {
  const BreathLottieScreen({super.key});

  @override
  State<BreathLottieScreen> createState() => _BreathLottieScreenState();
}

class _BreathLottieScreenState extends State<BreathLottieScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFE8F5E9),
                        scheme.primary.withValues(alpha: 0),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Lottie.asset(
                          'assets/lottie/onboarding_breathing_circle.json',
                          controller: controller,
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isTap = !isTap;
                              if (isTap) {
                                controller.repeat();
                              } else {
                                controller.stop();
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 5,
                                top: 2,
                                bottom: 2,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isTap ? Icons.pause : Icons.play_arrow,
                                    size: 30,
                                    color: scheme.primary,
                                  ),
                                  Text(
                                    isTap ? '' : 'Animation',
                                    style: text.bodyMedium?.copyWith(
                                      color: scheme.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Take a Breath.',
                      style: GoogleFonts.poppins(
                        textStyle: text.headlineMedium?.copyWith(
                          color: scheme.primary,
                        ),
                      ),
                    ),
                    Text(
                      'Find Your Calm.',
                      style: GoogleFonts.poppins(
                        textStyle: text.headlineMedium?.copyWith(
                          color: scheme.primary,
                        ),
                      ),
                    ),
                    Text(
                      'Unwind with guided breathing before you dive in.',
                      style: GoogleFonts.poppins(
                        textStyle: text.bodyLarge?.copyWith(color: Colors.grey),
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.learnScreen.name);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: scheme.primary,
                      foregroundColor: scheme.surface,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Next',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
