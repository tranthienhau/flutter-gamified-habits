import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gamified_habits/data/models/habit.dart';
import 'package:flutter_gamified_habits/data/models/completion.dart';

class HabitRepository {
  static const _habitsBox = 'habits';
  static const _completionsBox = 'completions';

  late Box<String> _habits;
  late Box<String> _completions;

  Future<void> init() async {
    _habits = await Hive.openBox<String>(_habitsBox);
    _completions = await Hive.openBox<String>(_completionsBox);
  }

  // Habits
  List<Habit> getAllHabits() {
    return _habits.values
        .map((json) => Habit.fromJson(jsonDecode(json) as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  Future<void> saveHabit(Habit habit) async {
    await _habits.put(habit.id, jsonEncode(habit.toJson()));
  }

  Future<void> deleteHabit(String id) async {
    await _habits.delete(id);
  }

  Future<void> reorderHabits(List<Habit> habits) async {
    for (int i = 0; i < habits.length; i++) {
      final updated = habits[i].copyWith(order: i);
      await saveHabit(updated);
    }
  }

  // Completions
  List<Completion> getAllCompletions() {
    return _completions.values
        .map((json) =>
            Completion.fromJson(jsonDecode(json) as Map<String, dynamic>))
        .toList();
  }

  List<Completion> getCompletionsForHabit(String habitId) {
    return getAllCompletions()
        .where((c) => c.habitId == habitId)
        .toList();
  }

  List<Completion> getCompletionsForDate(DateTime date) {
    return getAllCompletions().where((c) {
      return c.completedAt.year == date.year &&
          c.completedAt.month == date.month &&
          c.completedAt.day == date.day;
    }).toList();
  }

  bool isHabitCompletedToday(String habitId) {
    final now = DateTime.now();
    return getAllCompletions().any((c) =>
        c.habitId == habitId &&
        c.completedAt.year == now.year &&
        c.completedAt.month == now.month &&
        c.completedAt.day == now.day);
  }

  Future<void> addCompletion(Completion completion) async {
    await _completions.put(
        completion.id, jsonEncode(completion.toJson()));
  }

  int getTotalCompletionCount() => _completions.length;
}
