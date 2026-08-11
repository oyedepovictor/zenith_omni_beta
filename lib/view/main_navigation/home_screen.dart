import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:zenith_omni/view/reusable_widgets/homescreen_container.dart';
import 'package:zenith_omni/view/reusable_widgets/icons_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning,John!',
                  style: GoogleFonts.poppins(
                    textStyle: text.headlineMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Let\'s make today productive',
                  style: GoogleFonts.poppins(textStyle: text.bodySmall),
                ),
                SizedBox(height: 30),
                HomescreenContainer(
                  color: scheme.surface,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today\'s progress',
                          style: GoogleFonts.poppins(
                            textStyle: text.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          '60%',
                          style: GoogleFonts.poppins(
                            color: scheme.primary,
                            textStyle: text.headlineMedium?.copyWith(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        LinearPercentIndicator(
                          lineHeight: 12,
                          percent: 0.6,
                          backgroundColor: Colors.grey.shade300,
                          progressColor: scheme.primary,
                          barRadius: Radius.circular(12),
                          padding: EdgeInsets.zero,
                          animation: true,
                          animationDuration: 1000,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Great job! Keep it up',
                          style: GoogleFonts.poppins(textStyle: text.bodySmall),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Quick Access',
                  style: GoogleFonts.poppins(
                    textStyle: text.headlineMedium?.copyWith(
                      fontSize: 18,
                      color: scheme.surface,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  spacing: 15,
                  children: [
                    IconsContainer(
                      iconPath: 'assets/app_icons/icon_sound_studio.svg',
                      text: 'Sound Studio',
                    ),

                    IconsContainer(
                      iconPath: 'assets/app_icons/icon_quizzler.svg',
                      text: 'Quizzler',
                    ),
                    IconsContainer(
                      iconPath: 'assets/app_icons/icon_bmi_calculator.svg',
                      text: 'BMI Calculator',
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  spacing: 15,
                  children: [
                    IconsContainer(
                      iconPath: 'assets/app_icons/icon_todoey.svg',
                      text: 'Todoey',
                    ),
                    IconsContainer(
                      iconPath: 'assets/app_icons/icon_flash_chat.svg',
                      text: 'Chat',
                    ),
                  ],
                ),
                SizedBox(height: 25),
                HomescreenContainer(
                  height: 100,
                  color: Color(0xFFF0F8FF),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '"Small daily progress',
                          style: GoogleFonts.poppins(
                            textStyle: text.bodyMedium?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          'leads to big results"',
                          style: GoogleFonts.poppins(
                            textStyle: text.bodyMedium?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '— Keep going',
                          style: GoogleFonts.poppins(textStyle: text.bodySmall),
                        ),
                      ],
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
