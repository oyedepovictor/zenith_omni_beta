import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zenith_omni/models/songs.dart';
import 'package:zenith_omni/view/main_navigation/home_screen.dart';
import 'package:zenith_omni/view/main_navigation/profile.dart';
import 'package:zenith_omni/view/mini_apps/bmiCalculator_app/bmi_calculator.dart';
import 'package:zenith_omni/view/mini_apps/bmiCalculator_app/result_page.dart';
import 'package:zenith_omni/view/mini_apps/quiz_app/quizzler.dart';
import 'package:zenith_omni/view/mini_apps/sound_studio/music_player.dart';
import 'package:zenith_omni/view/mini_apps/sound_studio/select_genre.dart';
import 'package:zenith_omni/view/mini_apps/todoey.dart';
import '../view/main_navigation/explore_screen.dart';
import '../view/main_navigation/layout_scaffold.dart';
import '../view/auth/login_screen.dart';
import '../view/auth/register_screen.dart';
import '../view/mini_apps/quiz_app/quiz_pages.dart';
import '../view/onboarding_screens/breath_lottie_screen.dart';
import '../view/onboarding_screens/goals_hero_screen.dart';
import '../view/onboarding_screens/learn_lottie_screen.dart';
import '../view/onboarding_screens/welcome_screen.dart';

enum AppRoutes {
  lottieScreen,
  learnScreen,
  goalScreen,
  heroScreen,
  loginScreen,
  registerScreen,
  homeScreen,
  exploreScreen,
  chatScreen,
  profileScreen,
  todoey,
  quizzler,
  quizPages,
  bmiCalculator,
  resultPage,
  selectGenre,
  musicPlayer,
}

final _rootNavigatorkey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorkey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => WelcomeScreen()),
    GoRoute(
      path: '/lottieScreen',
      name: AppRoutes.lottieScreen.name,
      builder: (context, state) => const BreathLottieScreen(),
    ),
    GoRoute(
      path: '/learnScreen',
      name: AppRoutes.learnScreen.name,
      builder: (context, state) => const LearnLottieScreen(),
    ),
    GoRoute(
      path: '/goalScreen',
      name: AppRoutes.goalScreen.name,
      builder: (context, state) => const GoalsHeroScreen(),
    ),
    GoRoute(
      path: '/loginScreen',
      name: AppRoutes.loginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/registerScreen',
      name: AppRoutes.registerScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/todoey',
      name: AppRoutes.todoey.name,
      builder: (context, state) => const Todoey(),
    ),
    GoRoute(
      path: '/quizzler',
      name: AppRoutes.quizzler.name,
      builder: (context, state) => const Quizzler(),
    ),
    GoRoute(
      path: '/quizPages/:name/:id',
      name: AppRoutes.quizPages.name,
      builder: (context, state) => QuizPages(
        categoryName: state.pathParameters['name']!,
        categoryID: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/bmiCalculator',
      name: AppRoutes.bmiCalculator.name,
      builder: (context, state) => const BmiCalculator(),
    ),
    GoRoute(
      path: '/resultPage',
      name: AppRoutes.resultPage.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        return ResultPage(
          bmiResult: extra['bmiResult']!,
          resultText: extra['resultText']!,
          interpretation: extra['interpretation']!,
          height: extra['height']!,
          weight: extra['weight']!,
          age: extra['age']!,
        );
      },
    ),
    GoRoute(
      path: '/selectGenre',
      name: AppRoutes.selectGenre.name,
      builder: (context, state) => const SelectGenre(),
    ),
    GoRoute(
      path: '/musicPlayer',
      name: AppRoutes.musicPlayer.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return MusicPlayer(
          playlist: extra['playlist'] as List<Songs>,
          initialIndex: extra['initialIndex'] as int,
        );
      },
    ),

    // code for route navigation in passing data to another screen.
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/homeScreen',
              name: AppRoutes.homeScreen.name,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/exploreScreen',
              name: AppRoutes.exploreScreen.name,
              builder: (context, state) => const ExploreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profileScreen',
              name: AppRoutes.profileScreen.name,
              builder: (context, state) => const Profile(),
            ),
          ],
        ),
      ],
    ),
  ],
);
