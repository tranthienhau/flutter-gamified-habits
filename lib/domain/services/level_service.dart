import 'package:flutter/material.dart';
import 'package:flutter_gamified_habits/core/constants/gamification.dart';

class LevelResult {
  final int level;
  final String levelName;
  final IconData icon;
  final double progress;
  final bool didLevelUp;
  final int xpToNext;

  const LevelResult({
    required this.level,
    required this.levelName,
    required this.icon,
    required this.progress,
    this.didLevelUp = false,
    required this.xpToNext,
  });
}

class LevelService {
  LevelResult calculateLevel(int totalXp, {int? previousLevel}) {
    final level = GamificationConstants.levelFromXp(totalXp);
    final progress = GamificationConstants.levelProgress(totalXp);
    final didLevelUp = previousLevel != null && level > previousLevel;

    int xpToNext;
    if (level >= GamificationConstants.maxLevel) {
      xpToNext = 0;
    } else {
      xpToNext = GamificationConstants.xpForLevel(level + 1) - totalXp;
    }

    return LevelResult(
      level: level,
      levelName: GamificationConstants.levelNames[level - 1],
      icon: GamificationConstants.levelIcons[level - 1],
      progress: progress,
      didLevelUp: didLevelUp,
      xpToNext: xpToNext,
    );
  }
}
