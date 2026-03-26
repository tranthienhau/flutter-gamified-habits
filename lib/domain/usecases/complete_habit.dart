import 'package:flutter_gamified_habits/core/constants/badge_definitions.dart';
import 'package:flutter_gamified_habits/data/models/completion.dart';
import 'package:flutter_gamified_habits/data/repositories/habit_repository.dart';
import 'package:flutter_gamified_habits/data/repositories/profile_repository.dart';
import 'package:flutter_gamified_habits/domain/services/badge_service.dart';
import 'package:flutter_gamified_habits/domain/services/level_service.dart';
import 'package:flutter_gamified_habits/domain/services/streak_service.dart';
import 'package:flutter_gamified_habits/domain/services/xp_service.dart';
import 'package:uuid/uuid.dart';

class CompletionResult {
  final int xpEarned;
  final int totalXp;
  final int streak;
  final bool isStreakMilestone;
  final int? streakMilestone;
  final LevelResult levelResult;
  final List<BadgeId> newBadges;

  const CompletionResult({
    required this.xpEarned,
    required this.totalXp,
    required this.streak,
    this.isStreakMilestone = false,
    this.streakMilestone,
    required this.levelResult,
    required this.newBadges,
  });
}

class CompleteHabitUseCase {
  final HabitRepository habitRepo;
  final ProfileRepository profileRepo;
  final XpService xpService;
  final StreakService streakService;
  final LevelService levelService;
  final BadgeService badgeService;

  CompleteHabitUseCase({
    required this.habitRepo,
    required this.profileRepo,
    required this.xpService,
    required this.streakService,
    required this.levelService,
    required this.badgeService,
  });

  Future<CompletionResult> execute(String habitId) async {
    final now = DateTime.now();
    var profile = profileRepo.getProfile();
    final habits = habitRepo.getAllHabits();
    final allCompletions = habitRepo.getAllCompletions();

    // Calculate today's completions for combo bonus
    final todayCompletions = allCompletions.where((c) =>
        c.completedAt.year == now.year &&
        c.completedAt.month == now.month &&
        c.completedAt.day == now.day);
    final habitsCompletedToday = todayCompletions.map((c) => c.habitId).toSet().length + 1;

    // Update streak
    final streakResult = streakService.updateStreak(profile, now);

    // Calculate XP
    final xpEarned = xpService.calculateXp(
      streakDays: streakResult.newStreak,
      habitsCompletedToday: habitsCompletedToday,
    );

    final previousLevel =
        levelService.calculateLevel(profile.totalXp).level;
    final newTotalXp = profile.totalXp + xpEarned;

    // Save completion
    final completion = Completion(
      id: const Uuid().v4(),
      habitId: habitId,
      completedAt: now,
      xpEarned: xpEarned,
    );
    await habitRepo.addCompletion(completion);

    // Update profile
    profile = profile.copyWith(
      totalXp: newTotalXp,
      currentStreak: streakResult.newStreak,
      longestStreak: streakResult.longestStreak,
      totalCompletions: profile.totalCompletions + 1,
      lastCompletionDate: now,
    );

    // Check badges
    final updatedCompletions = habitRepo.getAllCompletions();
    final newBadges = badgeService.checkNewBadges(
      profile: profile,
      habits: habits,
      allCompletions: updatedCompletions,
      now: now,
    );

    if (newBadges.isNotEmpty) {
      profile = profile.copyWith(
        unlockedBadgeIds: [
          ...profile.unlockedBadgeIds,
          ...newBadges.map((b) => b.name),
        ],
      );
    }

    await profileRepo.saveProfile(profile);

    final levelResult =
        levelService.calculateLevel(newTotalXp, previousLevel: previousLevel);

    return CompletionResult(
      xpEarned: xpEarned,
      totalXp: newTotalXp,
      streak: streakResult.newStreak,
      isStreakMilestone: streakResult.isMilestone,
      streakMilestone: streakResult.milestoneReached,
      levelResult: levelResult,
      newBadges: newBadges,
    );
  }
}
