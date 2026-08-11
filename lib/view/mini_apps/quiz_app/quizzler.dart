import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routing/app_routes.dart';
import '../../reusable_widgets/quizzler_container.dart';

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Hero(
                      tag: 'quizzler',
                      child: SvgPicture.asset(
                        'assets/app_icons/icon_quizzler.svg',
                        height: 50,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Quizzler',
                          style: GoogleFonts.poppins(
                            textStyle: textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Pick your topics',
                        style: GoogleFonts.poppins(
                          textStyle: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QuizzlerContainer(
                        iconPath:
                            'assets/quiz_category_icons/icon_geography.svg',
                        title: 'Geography',
                        subtitle: '10 Questions',
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.quizPages.name,
                            pathParameters: {'name': 'Geography', 'id': '22'},
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      QuizzlerContainer(
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.quizPages.name,
                            pathParameters: {'name': 'History', 'id': '23'},
                          );
                        },
                        iconPath: 'assets/quiz_category_icons/icon_history.svg',
                        title: 'History',
                        subtitle: '10 Questions',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuizzlerContainer(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.quizPages.name,
                      pathParameters: {'name': 'Movies', 'id': '11'},
                    );
                  },
                  iconPath: 'assets/quiz_category_icons/icon_movies.svg',
                  title: 'Movies',
                  subtitle: '10 Questions',
                ),
                SizedBox(width: 10),
                QuizzlerContainer(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.quizPages.name,
                      pathParameters: {'name': 'Music', 'id': '12'},
                    );
                  },
                  iconPath: 'assets/quiz_category_icons/icon_music.svg',
                  title: 'Music',
                  subtitle: '10 Questions',
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuizzlerContainer(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.quizPages.name,
                      pathParameters: {'name': 'Nature', 'id': '17'},
                    );
                  },
                  iconPath: 'assets/quiz_category_icons/icon_nature.svg',
                  title: 'Nature',
                  subtitle: '10 Questions',
                ),
                SizedBox(width: 10),
                QuizzlerContainer(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.quizPages.name,
                      pathParameters: {'name': 'Science', 'id': '18'},
                    );
                  },
                  iconPath: 'assets/quiz_category_icons/icon_science.svg',
                  title: 'Science',
                  subtitle: '10 Questions',
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuizzlerContainer(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.quizPages.name,
                      pathParameters: {'name': 'Sports', 'id': '21'},
                    );
                  },
                  iconPath: 'assets/quiz_category_icons/icon_sports.svg',
                  title: 'Sports',
                  subtitle: '10 Questions',
                ),
                SizedBox(width: 10),
                QuizzlerContainer(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.quizPages.name,
                      pathParameters: {'name': 'Technology', 'id': '30'},
                    );
                  },
                  iconPath: 'assets/quiz_category_icons/icon_technology.svg',
                  title: 'Technology',
                  subtitle: '10 Questions',
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
