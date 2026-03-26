import 'package:flutter_gamified_habits/core/constants/gamification.dart';

class XpService {
  int calculateXp({required int streakDays, required int habitsCompletedToday}) {
    return GamificationConstants.calculateXp(streakDays, habitsCompletedToday);
  }

  double streakMultiplier(int streakDays) {
    return GamificationConstants.streakMultiplier(streakDays);
  }

  int comboBonus(int habitsCompletedToday) {
    return GamificationConstants.comboBonusXp(habitsCompletedToday);
  }
}
