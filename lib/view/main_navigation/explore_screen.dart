import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenith_omni/routing/app_routes.dart';
import '../reusable_widgets/explore_widgets.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  bottom: 5,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  'Explore',
                  style: GoogleFonts.poppins(
                    textStyle: text.headlineMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'All projects',
                  style: GoogleFonts.poppins(
                    textStyle: text.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  ExploreWidgets(
                    onTap: () {
                      context.pushNamed(AppRoutes.selectGenre.name);
                    },
                    iconPath: 'assets/app_icons/icon_sound_studio.svg',
                    title: 'Sound Studio',
                    subtitle: 'Relaxing music & sounds',
                    tag: 'sound_studio',
                  ),
                  SizedBox(height: 15),
                  ExploreWidgets(
                    onTap: () {
                      context.pushNamed(AppRoutes.quizzler.name);
                    },
                    iconPath: 'assets/app_icons/icon_quizzler.svg',
                    title: 'Quizzler',
                    subtitle: 'Test your knowledge',
                    tag: 'quizzler',
                  ),
                  SizedBox(height: 15),
                  ExploreWidgets(
                    tag: 'BMI',
                    onTap: () {
                      context.pushNamed(AppRoutes.bmiCalculator.name);
                    },
                    iconPath: 'assets/app_icons/icon_bmi_calculator.svg',
                    title: 'BMI Calculator',
                    subtitle: 'Calculate your BMI',
                  ),
                  SizedBox(height: 15),
                  ExploreWidgets(
                    onTap: () {
                      context.pushNamed(AppRoutes.todoey.name);
                    },
                    iconPath: 'assets/app_icons/icon_todoey.svg',
                    title: 'Todoey',
                    subtitle: 'Organize your tasks',
                    tag: 'todoey',
                  ),
                  SizedBox(height: 15),
                  ExploreWidgets(
                    onTap: () {},
                    iconPath: 'assets/app_icons/icon_flash_chat.svg',
                    title: 'Flash Chat',
                    subtitle: 'Chat with friends',
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
