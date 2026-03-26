import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gamified_habits/core/constants/gamification.dart';
import 'package:flutter_gamified_habits/domain/services/level_service.dart';

void main() {
  late LevelService service;

  setUp(() {
    service = LevelService();
  });

  group('LevelService', () {
    test('0 XP is level 1', () {
      final result = service.calculateLevel(0);
      expect(result.level, 1);
      expect(result.levelName, 'Seedling');
    });

    test('level thresholds follow formula', () {
      // Level 2 threshold: 100 * 2^1.8 = ~348
      expect(GamificationConstants.xpForLevel(2), closeTo(348, 5));
    });

    test('large XP gives high level', () {
      final result = service.calculateLevel(50000);
      expect(result.level, GamificationConstants.maxLevel);
    });

    test('progress is between 0 and 1', () {
      final result = service.calculateLevel(200);
      expect(result.progress, greaterThanOrEqualTo(0));
      expect(result.progress, lessThanOrEqualTo(1));
    });

    test('detects level up', () {
      // Go from level 1 to level 2
      final threshold = GamificationConstants.xpForLevel(2);
      final result = service.calculateLevel(threshold, previousLevel: 1);
      expect(result.didLevelUp, true);
    });

    test('no level up when staying same level', () {
      final result = service.calculateLevel(100, previousLevel: 1);
      expect(result.didLevelUp, false);
    });

    test('xpToNext is correct', () {
      final result = service.calculateLevel(0);
      final threshold2 = GamificationConstants.xpForLevel(2);
      expect(result.xpToNext, threshold2);
    });

    test('max level has 0 xpToNext', () {
      final result = service.calculateLevel(999999);
      expect(result.xpToNext, 0);
    });
  });
}
