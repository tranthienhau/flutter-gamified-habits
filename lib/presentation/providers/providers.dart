import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gamified_habits/data/models/habit.dart';
import 'package:flutter_gamified_habits/data/models/completion.dart';
import 'package:flutter_gamified_habits/data/models/user_profile.dart';
import 'package:flutter_gamified_habits/data/repositories/habit_repository.dart';
import 'package:flutter_gamified_habits/data/repositories/profile_repository.dart';
import 'package:flutter_gamified_habits/domain/services/xp_service.dart';
import 'package:flutter_gamified_habits/domain/services/streak_service.dart';
import 'package:flutter_gamified_habits/domain/services/level_service.dart';
import 'package:flutter_gamified_habits/domain/services/badge_service.dart';
import 'package:flutter_gamified_habits/domain/usecases/complete_habit.dart';

// Repositories
final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  throw UnimplementedError('Must be overridden');
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  throw UnimplementedError('Must be overridden');
});

// Services
final xpServiceProvider = Provider((ref) => XpService());
final streakServiceProvider = Provider((ref) => StreakService());
final levelServiceProvider = Provider((ref) => LevelService());
final badgeServiceProvider = Provider((ref) => BadgeService());

// Use case
final completeHabitUseCaseProvider = Provider((ref) {
  return CompleteHabitUseCase(
    habitRepo: ref.read(habitRepositoryProvider),
    profileRepo: ref.read(profileRepositoryProvider),
    xpService: ref.read(xpServiceProvider),
    streakService: ref.read(streakServiceProvider),
    levelService: ref.read(levelServiceProvider),
    badgeService: ref.read(badgeServiceProvider),
  );
});

// Theme mode
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.light);

  void toggle() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

// Habit list
final habitListProvider =
    StateNotifierProvider<HabitListNotifier, List<Habit>>((ref) {
  return HabitListNotifier(ref.read(habitRepositoryProvider));
});

class HabitListNotifier extends StateNotifier<List<Habit>> {
  final HabitRepository _repo;

  HabitListNotifier(this._repo) : super([]) {
    _load();
  }

  void _load() {
    state = _repo.getAllHabits();
  }

  Future<void> addHabit(Habit habit) async {
    await _repo.saveHabit(habit);
    _load();
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final items = [...state];
    if (newIndex > oldIndex) newIndex--;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    await _repo.reorderHabits(items);
    _load();
  }

  void refresh() => _load();
}

// Completions
final completionsProvider =
    StateNotifierProvider<CompletionsNotifier, List<Completion>>((ref) {
  return CompletionsNotifier(ref.read(habitRepositoryProvider));
});

class CompletionsNotifier extends StateNotifier<List<Completion>> {
  final HabitRepository _repo;

  CompletionsNotifier(this._repo) : super([]) {
    _load();
  }

  void _load() {
    state = _repo.getAllCompletions();
  }

  void refresh() => _load();
}

// Profile
final profileProvider =
    StateNotifierProvider<ProfileNotifier, UserProfile>((ref) {
  return ProfileNotifier(ref.read(profileRepositoryProvider));
});

class ProfileNotifier extends StateNotifier<UserProfile> {
  final ProfileRepository _repo;

  ProfileNotifier(this._repo) : super(const UserProfile()) {
    _load();
  }

  void _load() {
    state = _repo.getProfile();
  }

  void refresh() => _load();
}

// Today's completions helper
final todayCompletedHabitIdsProvider = Provider<Set<String>>((ref) {
  final completions = ref.watch(completionsProvider);
  final now = DateTime.now();
  return completions
      .where((c) =>
          c.completedAt.year == now.year &&
          c.completedAt.month == now.month &&
          c.completedAt.day == now.day)
      .map((c) => c.habitId)
      .toSet();
});

// Daily progress
final dailyProgressProvider = Provider<double>((ref) {
  final habits = ref.watch(habitListProvider);
  final completed = ref.watch(todayCompletedHabitIdsProvider);
  final activeHabits = habits.where((h) => h.isActive).length;
  if (activeHabits == 0) return 0;
  return completed.length / activeHabits;
});
