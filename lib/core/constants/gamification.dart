import 'dart:math';
import 'package:flutter/material.dart';

class GamificationConstants {
  GamificationConstants._();

  // XP
  static const int baseXp = 50;
  static const double maxStreakMultiplier = 2.0;
  static const int comboBonus = 10;

  // Streak multiplier: starts at 1.0, +0.1 per day, capped at 2.0
  static double streakMultiplier(int streakDays) {
    return min(1.0 + streakDays * 0.1, maxStreakMultiplier);
  }

  // Combo bonus: +10 XP per extra habit completed today (first is free)
  static int comboBonusXp(int habitsCompletedToday) {
    return max(0, (habitsCompletedToday - 1) * comboBonus);
  }

  // Total XP for a single completion
  static int calculateXp(int streakDays, int habitsCompletedToday) {
    final multiplier = streakMultiplier(streakDays);
    final combo = comboBonusXp(habitsCompletedToday);
    return (baseXp * multiplier).round() + combo;
  }

  // Levels
  static const int maxLevel = 10;

  static const List<String> levelNames = [
    'Seedling',
    'Sprout',
    'Sapling',
    'Bush',
    'Young Tree',
    'Tree',
    'Oak',
    'Ancient Oak',
    'Elder Tree',
    'World Tree',
  ];

  static const List<IconData> levelIcons = [
    Icons.grass,
    Icons.eco,
    Icons.yard,
    Icons.park,
    Icons.nature,
    Icons.forest,
    Icons.landscape,
    Icons.star,
    Icons.auto_awesome,
    Icons.public,
  ];

  // Level threshold: 100 * n^1.8
  static int xpForLevel(int level) {
    if (level <= 1) return 0;
    return (100 * pow(level, 1.8)).round();
  }

  static int levelFromXp(int totalXp) {
    for (int lvl = maxLevel; lvl >= 1; lvl--) {
      if (totalXp >= xpForLevel(lvl)) return lvl;
    }
    return 1;
  }

  static double levelProgress(int totalXp) {
    final currentLevel = levelFromXp(totalXp);
    if (currentLevel >= maxLevel) return 1.0;
    final currentThreshold = xpForLevel(currentLevel);
    final nextThreshold = xpForLevel(currentLevel + 1);
    return (totalXp - currentThreshold) / (nextThreshold - currentThreshold);
  }

  // Streak milestones (flame grows)
  static const List<int> streakMilestones = [3, 7, 14, 30, 60, 100];

  // Freeze
  static const int freezesPerWeek = 1;
}
