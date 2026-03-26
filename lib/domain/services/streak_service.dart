import 'package:flutter_gamified_habits/core/constants/gamification.dart';
import 'package:flutter_gamified_habits/data/models/user_profile.dart';

class StreakResult {
  final int newStreak;
  final int longestStreak;
  final bool isMilestone;
  final int? milestoneReached;

  const StreakResult({
    required this.newStreak,
    required this.longestStreak,
    this.isMilestone = false,
    this.milestoneReached,
  });
}

class StreakService {
  StreakResult updateStreak(UserProfile profile, DateTime now) {
    final lastDate = profile.lastCompletionDate;
    int newStreak;

    if (lastDate == null) {
      newStreak = 1;
    } else {
      final lastDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
      final today = DateTime(now.year, now.month, now.day);
      final diff = today.difference(lastDay).inDays;

      if (diff == 0) {
        // Same day, no streak change
        newStreak = profile.currentStreak;
      } else if (diff == 1) {
        // Consecutive day
        newStreak = profile.currentStreak + 1;
      } else {
        // Streak broken
        newStreak = 1;
      }
    }

    final longestStreak =
        newStreak > profile.longestStreak ? newStreak : profile.longestStreak;

    int? milestoneReached;
    for (final milestone in GamificationConstants.streakMilestones) {
      if (newStreak == milestone) {
        milestoneReached = milestone;
        break;
      }
    }

    return StreakResult(
      newStreak: newStreak,
      longestStreak: longestStreak,
      isMilestone: milestoneReached != null,
      milestoneReached: milestoneReached,
    );
  }

  bool canFreeze(UserProfile profile) {
    final now = DateTime.now();
    final resetDate = profile.lastFreezeReset;

    if (resetDate == null) return true;

    // Reset weekly
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final resetDay =
        DateTime(resetDate.year, resetDate.month, resetDate.day);
    final weekStartDay =
        DateTime(weekStart.year, weekStart.month, weekStart.day);

    if (resetDay.isBefore(weekStartDay)) return true;

    return profile.freezesUsedThisWeek <
        GamificationConstants.freezesPerWeek;
  }

  int flameSizeLevel(int streak) {
    if (streak >= 30) return 4;
    if (streak >= 14) return 3;
    if (streak >= 7) return 2;
    if (streak >= 3) return 1;
    return 0;
  }
}
