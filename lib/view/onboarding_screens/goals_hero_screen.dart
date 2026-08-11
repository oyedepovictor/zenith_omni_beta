import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routing/app_routes.dart';

class GoalsHeroScreen extends StatelessWidget {
  const GoalsHeroScreen({super.key});

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
                  'assets/welcome_screen/onboarding_4_hero_sunrise.svg',
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Ready to start',
                    style: GoogleFonts.poppins(
                      textStyle: text.headlineMedium?.copyWith(
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  Text(
                    'your journey?',
                    style: GoogleFonts.poppins(
                      textStyle: text.headlineMedium?.copyWith(
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Let\'s begin your journey with Zenith omni',
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
                    context.pushNamed(AppRoutes.loginScreen.name);
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
                    'Get Started',
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
