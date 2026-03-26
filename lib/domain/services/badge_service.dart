import 'package:flutter_gamified_habits/core/constants/badge_definitions.dart';
import 'package:flutter_gamified_habits/core/constants/gamification.dart';
import 'package:flutter_gamified_habits/data/models/completion.dart';
import 'package:flutter_gamified_habits/data/models/habit.dart';
import 'package:flutter_gamified_habits/data/models/user_profile.dart';

class BadgeService {
  List<BadgeId> checkNewBadges({
    required UserProfile profile,
    required List<Habit> habits,
    required List<Completion> allCompletions,
    required DateTime now,
  }) {
    final newBadges = <BadgeId>[];
    final unlocked =
        profile.unlockedBadgeIds.map((s) => BadgeId.values.byName(s)).toSet();

    // First Step: Complete your first habit
    if (!unlocked.contains(BadgeId.firstStep) &&
        profile.totalCompletions >= 1) {
      newBadges.add(BadgeId.firstStep);
    }

    // Hat Trick: 3 habits in one day
    if (!unlocked.contains(BadgeId.hatTrick)) {
      final todayCompletions = allCompletions.where((c) =>
          c.completedAt.year == now.year &&
          c.completedAt.month == now.month &&
          c.completedAt.day == now.day);
      final uniqueHabits = todayCompletions.map((c) => c.habitId).toSet();
      if (uniqueHabits.length >= 3) {
        newBadges.add(BadgeId.hatTrick);
      }
    }

    // Perfect Day: all habits in one day
    if (!unlocked.contains(BadgeId.perfectDay)) {
      final activeHabits = habits.where((h) => h.isActive).length;
      final todayCompletions = allCompletions.where((c) =>
          c.completedAt.year == now.year &&
          c.completedAt.month == now.month &&
          c.completedAt.day == now.day);
      final uniqueHabits = todayCompletions.map((c) => c.habitId).toSet();
      if (activeHabits > 0 && uniqueHabits.length >= activeHabits) {
        newBadges.add(BadgeId.perfectDay);
      }
    }

    // On Fire: 7-day streak
    if (!unlocked.contains(BadgeId.onFire) && profile.currentStreak >= 7) {
      newBadges.add(BadgeId.onFire);
    }

    // Week Warrior: all habits every day for a week (simplified: 7 streak + all complete today)
    if (!unlocked.contains(BadgeId.weekWarrior) &&
        profile.currentStreak >= 7) {
      final activeHabits = habits.where((h) => h.isActive).length;
      final todayCompletions = allCompletions.where((c) =>
          c.completedAt.year == now.year &&
          c.completedAt.month == now.month &&
          c.completedAt.day == now.day);
      final uniqueHabits = todayCompletions.map((c) => c.habitId).toSet();
      if (activeHabits > 0 && uniqueHabits.length >= activeHabits) {
        newBadges.add(BadgeId.weekWarrior);
      }
    }

    // Fortnight: 14-day streak
    if (!unlocked.contains(BadgeId.fortnight) &&
        profile.currentStreak >= 14) {
      newBadges.add(BadgeId.fortnight);
    }

    // Monthly Master: 30-day streak
    if (!unlocked.contains(BadgeId.monthlyMaster) &&
        profile.currentStreak >= 30) {
      newBadges.add(BadgeId.monthlyMaster);
    }

    // Centurion: 100 total completions
    if (!unlocked.contains(BadgeId.centurion) &&
        profile.totalCompletions >= 100) {
      newBadges.add(BadgeId.centurion);
    }

    // Early Bird: complete before 8 AM
    if (!unlocked.contains(BadgeId.earlyBird) && now.hour < 8) {
      newBadges.add(BadgeId.earlyBird);
    }

    // Night Owl: complete after 10 PM
    if (!unlocked.contains(BadgeId.nightOwl) && now.hour >= 22) {
      newBadges.add(BadgeId.nightOwl);
    }

    // Diversified: 5+ active habits
    if (!unlocked.contains(BadgeId.diversified)) {
      final activeCount = habits.where((h) => h.isActive).length;
      if (activeCount >= 5) {
        newBadges.add(BadgeId.diversified);
      }
    }

    // Level Five: reach level 5
    if (!unlocked.contains(BadgeId.levelFive)) {
      final level = GamificationConstants.levelFromXp(profile.totalXp);
      if (level >= 5) {
        newBadges.add(BadgeId.levelFive);
      }
    }

    return newBadges;
  }
}
