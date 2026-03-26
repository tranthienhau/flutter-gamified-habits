import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gamified_habits/presentation/providers/providers.dart';
import 'package:flutter_gamified_habits/presentation/shared/completion_calendar.dart';
import 'package:intl/intl.dart';

class DetailScreen extends ConsumerWidget {
  final String habitId;

  const DetailScreen({super.key, required this.habitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitListProvider);
    final habit = habits.where((h) => h.id == habitId).firstOrNull;
    if (habit == null) {
      return const Scaffold(body: Center(child: Text('Habit not found')));
    }

    final completions = ref.watch(completionsProvider);
    final habitCompletions =
        completions.where((c) => c.habitId == habitId).toList();
    final totalCompletions = habitCompletions.length;
    final color = Color(habit.colorValue);

    // Calculate current streak for this habit
    int habitStreak = 0;
    if (habitCompletions.isNotEmpty) {
      final sorted = [...habitCompletions]
        ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
      var checkDate = DateTime.now();
      for (final c in sorted) {
        final cDay = DateTime(
            c.completedAt.year, c.completedAt.month, c.completedAt.day);
        final check =
            DateTime(checkDate.year, checkDate.month, checkDate.day);
        if (cDay == check || check.difference(cDay).inDays == 1) {
          habitStreak++;
          checkDate = cDay;
        } else if (cDay != check) {
          break;
        }
      }
    }

    final firstCompletion = habitCompletions.isNotEmpty
        ? habitCompletions
            .reduce((a, b) =>
                a.completedAt.isBefore(b.completedAt) ? a : b)
            .completedAt
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero icon
            Center(
              child: Hero(
                tag: 'habit_${habit.id}',
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    IconData(habit.iconCodePoint,
                        fontFamily: 'MaterialIcons'),
                    color: color,
                    size: 40,
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8)),

            const SizedBox(height: 24),

            // Stats cards
            Row(
              children: [
                _StatCard(
                  label: 'Total',
                  value: '$totalCompletions',
                  icon: Icons.check_circle_outline,
                  color: color,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'Streak',
                  value: '$habitStreak',
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'Since',
                  value: firstCompletion != null
                      ? DateFormat('MMM d').format(firstCompletion)
                      : '-',
                  icon: Icons.calendar_today,
                  color: Colors.blue,
                ),
              ],
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

            const SizedBox(height: 32),

            // Calendar heatmap
            const Text(
              'Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Center(
              child: CompletionCalendar(completions: habitCompletions),
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

            const SizedBox(height: 32),

            // Recent completions
            const Text(
              'Recent Completions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...habitCompletions
                .reversed
                .take(10)
                .map((c) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.check, color: color, size: 18),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat('MMM d, yyyy - h:mm a')
                                .format(c.completedAt),
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Spacer(),
                          if (c.xpEarned > 0)
                            Text(
                              '+${c.xpEarned} XP',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.amber[700],
                              ),
                            ),
                        ],
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: int.tryParse(value) ?? 0),
              duration: const Duration(milliseconds: 800),
              builder: (context, val, _) {
                // If value is not a number (like a date), show as-is
                if (int.tryParse(value) == null) {
                  return Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                }
                return Text(
                  '$val',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
