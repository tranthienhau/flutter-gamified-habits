import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gamified_habits/data/models/user_profile.dart';
import 'package:flutter_gamified_habits/domain/services/streak_service.dart';

void main() {
  late StreakService service;

  setUp(() {
    service = StreakService();
  });

  group('StreakService', () {
    test('first completion starts streak at 1', () {
      const profile = UserProfile();
      final result = service.updateStreak(
        profile,
        DateTime(2024, 1, 15, 10, 0),
      );
      expect(result.newStreak, 1);
    });

    test('same day keeps streak unchanged', () {
      final profile = UserProfile(
        currentStreak: 5,
        lastCompletionDate: DateTime(2024, 1, 15, 8, 0),
      );
      final result = service.updateStreak(
        profile,
        DateTime(2024, 1, 15, 12, 0),
      );
      expect(result.newStreak, 5);
    });

    test('consecutive day increments streak', () {
      final profile = UserProfile(
        currentStreak: 3,
        lastCompletionDate: DateTime(2024, 1, 14),
      );
      final result = service.updateStreak(
        profile,
        DateTime(2024, 1, 15),
      );
      expect(result.newStreak, 4);
    });

    test('missed day resets streak to 1', () {
      final profile = UserProfile(
        currentStreak: 10,
        lastCompletionDate: DateTime(2024, 1, 12),
      );
      final result = service.updateStreak(
        profile,
        DateTime(2024, 1, 15),
      );
      expect(result.newStreak, 1);
    });

    test('updates longest streak when current exceeds it', () {
      final profile = UserProfile(
        currentStreak: 5,
        longestStreak: 5,
        lastCompletionDate: DateTime(2024, 1, 14),
      );
      final result = service.updateStreak(
        profile,
        DateTime(2024, 1, 15),
      );
      expect(result.newStreak, 6);
      expect(result.longestStreak, 6);
    });

    test('detects milestone at 7 days', () {
      final profile = UserProfile(
        currentStreak: 6,
        lastCompletionDate: DateTime(2024, 1, 14),
      );
      final result = service.updateStreak(
        profile,
        DateTime(2024, 1, 15),
      );
      expect(result.newStreak, 7);
      expect(result.isMilestone, true);
      expect(result.milestoneReached, 7);
    });

    test('no milestone at non-milestone days', () {
      final profile = UserProfile(
        currentStreak: 4,
        lastCompletionDate: DateTime(2024, 1, 14),
      );
      final result = service.updateStreak(
        profile,
        DateTime(2024, 1, 15),
      );
      expect(result.newStreak, 5);
      expect(result.isMilestone, false);
    });

    test('flame size level returns correct levels', () {
      expect(service.flameSizeLevel(0), 0);
      expect(service.flameSizeLevel(2), 0);
      expect(service.flameSizeLevel(3), 1);
      expect(service.flameSizeLevel(7), 2);
      expect(service.flameSizeLevel(14), 3);
      expect(service.flameSizeLevel(30), 4);
    });
  });
}
