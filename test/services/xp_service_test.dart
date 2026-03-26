import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gamified_habits/domain/services/xp_service.dart';

void main() {
  late XpService service;

  setUp(() {
    service = XpService();
  });

  group('XpService', () {
    test('base XP is 50 with no streak and first habit', () {
      final xp = service.calculateXp(streakDays: 0, habitsCompletedToday: 1);
      expect(xp, 50); // 50 * 1.0 + 0
    });

    test('streak multiplier increases XP', () {
      final xp = service.calculateXp(streakDays: 5, habitsCompletedToday: 1);
      // 50 * 1.5 = 75
      expect(xp, 75);
    });

    test('streak multiplier caps at 2.0', () {
      final xp = service.calculateXp(streakDays: 20, habitsCompletedToday: 1);
      // 50 * 2.0 = 100
      expect(xp, 100);
    });

    test('combo bonus adds 10 per extra habit', () {
      final xp = service.calculateXp(streakDays: 0, habitsCompletedToday: 3);
      // 50 * 1.0 + 20 = 70
      expect(xp, 70);
    });

    test('streak and combo stack correctly', () {
      final xp = service.calculateXp(streakDays: 10, habitsCompletedToday: 4);
      // 50 * 2.0 + 30 = 130
      expect(xp, 130);
    });

    test('streak multiplier at day 1', () {
      expect(service.streakMultiplier(1), 1.1);
    });

    test('combo bonus with 1 habit is 0', () {
      expect(service.comboBonus(1), 0);
    });
  });
}
