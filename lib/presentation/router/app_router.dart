import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gamified_habits/presentation/screens/home/home_screen.dart';
import 'package:flutter_gamified_habits/presentation/screens/home/add_habit_sheet.dart';
import 'package:flutter_gamified_habits/presentation/screens/detail/detail_screen.dart';
import 'package:flutter_gamified_habits/presentation/screens/profile/profile_screen.dart';
import 'package:flutter_gamified_habits/presentation/screens/rewards/rewards_screen.dart';
import 'package:flutter_gamified_habits/presentation/router/shell_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => ShellScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const HomeScreen(),
            transitionsBuilder: _fadeSlide,
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const ProfileScreen(),
            transitionsBuilder: _fadeSlide,
          ),
        ),
        GoRoute(
          path: '/rewards',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const RewardsScreen(),
            transitionsBuilder: _fadeSlide,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/detail/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return CustomTransitionPage(
          child: DetailScreen(habitId: id),
          transitionsBuilder: _slideUp,
        );
      },
    ),
    GoRoute(
      path: '/add',
      pageBuilder: (context, state) => CustomTransitionPage(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: const AddHabitSheet(),
          ),
        ),
        transitionsBuilder: _slideUp,
      ),
    ),
  ],
);

Widget _fadeSlide(
    BuildContext context, Animation<double> animation,
    Animation<double> _, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.02),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: child,
    ),
  );
}

Widget _slideUp(
    BuildContext context, Animation<double> animation,
    Animation<double> _, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    )),
    child: child,
  );
}
