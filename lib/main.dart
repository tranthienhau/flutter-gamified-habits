import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gamified_habits/core/constants/default_habits.dart';
import 'package:flutter_gamified_habits/core/theme/app_theme.dart';
import 'package:flutter_gamified_habits/data/models/habit.dart';
import 'package:flutter_gamified_habits/data/models/completion.dart';
import 'package:flutter_gamified_habits/data/models/user_profile.dart';
import 'package:flutter_gamified_habits/data/repositories/habit_repository.dart';
import 'package:flutter_gamified_habits/data/repositories/profile_repository.dart';
import 'package:flutter_gamified_habits/presentation/providers/providers.dart';
import 'package:flutter_gamified_habits/presentation/router/app_router.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final habitRepo = HabitRepository();
  final profileRepo = ProfileRepository();
  await habitRepo.init();
  await profileRepo.init();

  // Seed default habits on first launch
  if (habitRepo.getAllHabits().isEmpty) {
    final habitIds = <String>[];
    for (int i = 0; i < defaultHabits.length; i++) {
      final d = defaultHabits[i];
      final id = const Uuid().v4();
      habitIds.add(id);
      await habitRepo.saveHabit(Habit(
        id: id,
        name: d.name,
        iconCodePoint: d.icon.codePoint,
        colorValue: d.color.toARGB32(),
        order: i,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ));
    }

    // Seed demo completions for rich screenshots
    final now = DateTime.now();
    for (int day = 14; day >= 0; day--) {
      final date = now.subtract(Duration(days: day));
      // Complete 2-4 habits per day
      final count = day % 3 == 0 ? 4 : (day % 2 == 0 ? 3 : 2);
      for (int h = 0; h < count && h < habitIds.length; h++) {
        await habitRepo.addCompletion(Completion(
          id: const Uuid().v4(),
          habitId: habitIds[h],
          completedAt: DateTime(date.year, date.month, date.day, 8 + h, 30),
          xpEarned: 50 + day * 3,
        ));
      }
    }

    // Complete 3 habits today
    for (int h = 0; h < 3; h++) {
      await habitRepo.addCompletion(Completion(
        id: const Uuid().v4(),
        habitId: habitIds[h],
        completedAt: now,
        xpEarned: 75,
      ));
    }

    // Seed profile with XP, streak, badges
    await profileRepo.saveProfile(UserProfile(
      totalXp: 2850,
      currentStreak: 15,
      longestStreak: 15,
      totalCompletions: 42,
      lastCompletionDate: now,
      unlockedBadgeIds: [
        'firstStep',
        'hatTrick',
        'perfectDay',
        'onFire',
        'weekWarrior',
        'fortnight',
        'diversified',
      ],
      freezesUsedThisWeek: 0,
    ));
  }

  runApp(
    ProviderScope(
      overrides: [
        habitRepositoryProvider.overrideWithValue(habitRepo),
        profileRepositoryProvider.overrideWithValue(profileRepo),
      ],
      child: const GamifiedHabitsApp(),
    ),
  );
}

class GamifiedHabitsApp extends ConsumerWidget {
  const GamifiedHabitsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Habit Quest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
