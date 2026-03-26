import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gamified_habits/core/constants/badge_definitions.dart';
import 'package:flutter_gamified_habits/data/models/completion.dart';
import 'package:flutter_gamified_habits/data/models/habit.dart';
import 'package:flutter_gamified_habits/data/models/user_profile.dart';
import 'package:flutter_gamified_habits/domain/services/badge_service.dart';

void main() {
  late BadgeService service;
  final now = DateTime(2024, 1, 15, 12, 0);

  Habit makeHabit(String id) => Habit(
        id: id,
        name: 'Habit $id',
        iconCodePoint: 0xe1234,
        colorValue: 0xFFFF0000,
        createdAt: DateTime(2024, 1, 1),
      );

  Completion makeCompletion(String habitId, DateTime at) => Completion(
        id: '${habitId}_${at.millisecondsSinceEpoch}',
        habitId: habitId,
        completedAt: at,
      );

  setUp(() {
    service = BadgeService();
  });

  group('BadgeService', () {
    test('firstStep unlocks after 1 completion', () {
      final badges = service.checkNewBadges(
        profile: const UserProfile(totalCompletions: 1),
        habits: [makeHabit('1')],
        allCompletions: [makeCompletion('1', now)],
        now: now,
      );
      expect(badges, contains(BadgeId.firstStep));
    });

    test('hatTrick unlocks after 3 different habits in a day', () {
      final badges = service.checkNewBadges(
        profile: const UserProfile(totalCompletions: 3),
        habits: [makeHabit('1'), makeHabit('2'), makeHabit('3')],
        allCompletions: [
          makeCompletion('1', now),
          makeCompletion('2', now),
          makeCompletion('3', now),
        ],
        now: now,
      );
      expect(badges, contains(BadgeId.hatTrick));
    });

    test('perfectDay unlocks when all active habits done', () {
      final badges = service.checkNewBadges(
        profile: const UserProfile(totalCompletions: 2),
        habits: [makeHabit('1'), makeHabit('2')],
        allCompletions: [
          makeCompletion('1', now),
          makeCompletion('2', now),
        ],
        now: now,
      );
      expect(badges, contains(BadgeId.perfectDay));
    });

    test('onFire unlocks at 7-day streak', () {
      final badges = service.checkNewBadges(
        profile: const UserProfile(currentStreak: 7, totalCompletions: 7),
        habits: [makeHabit('1')],
        allCompletions: [makeCompletion('1', now)],
        now: now,
      );
      expect(badges, contains(BadgeId.onFire));
    });

    test('centurion unlocks at 100 completions', () {
      final badges = service.checkNewBadges(
        profile: const UserProfile(totalCompletions: 100),
        habits: [makeHabit('1')],
        allCompletions: [makeCompletion('1', now)],
        now: now,
      );
      expect(badges, contains(BadgeId.centurion));
    });

    test('earlyBird unlocks before 8 AM', () {
      final earlyNow = DateTime(2024, 1, 15, 6, 30);
      final badges = service.checkNewBadges(
        profile: const UserProfile(totalCompletions: 1),
        habits: [makeHabit('1')],
        allCompletions: [makeCompletion('1', earlyNow)],
        now: earlyNow,
      );
      expect(badges, contains(BadgeId.earlyBird));
    });

    test('nightOwl unlocks after 10 PM', () {
      final lateNow = DateTime(2024, 1, 15, 22, 30);
      final badges = service.checkNewBadges(
        profile: const UserProfile(totalCompletions: 1),
        habits: [makeHabit('1')],
        allCompletions: [makeCompletion('1', lateNow)],
        now: lateNow,
      );
      expect(badges, contains(BadgeId.nightOwl));
    });

    test('diversified unlocks with 5+ active habits', () {
      final badges = service.checkNewBadges(
        profile: const UserProfile(totalCompletions: 5),
        habits: List.generate(5, (i) => makeHabit('$i')),
        allCompletions: List.generate(
            5, (i) => makeCompletion('$i', now)),
        now: now,
      );
      expect(badges, contains(BadgeId.diversified));
    });

    test('already unlocked badges are not re-awarded', () {
      final badges = service.checkNewBadges(
        profile: const UserProfile(
          totalCompletions: 1,
          unlockedBadgeIds: ['firstStep'],
        ),
        habits: [makeHabit('1')],
        allCompletions: [makeCompletion('1', now)],
        now: now,
      );
      expect(badges, isNot(contains(BadgeId.firstStep)));
    });
  });
}
