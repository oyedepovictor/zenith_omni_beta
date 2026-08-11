import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zenith_omni/routing/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                  bottom: 10,
                  left: 30,
                  right: 30,
                ),
                child: SvgPicture.asset(
                  'assets/welcome_screen/onboarding_1_welcome.svg',
                  height: 300,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Welcome to',
                    style: GoogleFonts.poppins(
                      textStyle: text.headlineMedium?.copyWith(
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  Text(
                    'Zenith omni',
                    style: GoogleFonts.poppins(
                      textStyle: text.headlineMedium?.copyWith(
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  Text(
                    'All your favorite learning projects in one place',
                    style: GoogleFonts.poppins(
                      textStyle: text.bodyLarge?.copyWith(
                        color: scheme.primary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.lottieScreen.name);
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
    );
  }
}
