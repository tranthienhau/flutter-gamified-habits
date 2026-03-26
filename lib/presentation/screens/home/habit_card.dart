import 'package:flutter/material.dart';
import 'package:flutter_gamified_habits/data/models/habit.dart';
import 'package:flutter_gamified_habits/presentation/shared/bounce_tap.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final bool isCompleted;
  final VoidCallback onComplete;
  final VoidCallback onTap;

  const HabitCard({
    super.key,
    required this.habit,
    required this.isCompleted,
    required this.onComplete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(habit.colorValue);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      key: ValueKey('dismiss_${habit.id}'),
      direction:
          isCompleted ? DismissDirection.none : DismissDirection.startToEnd,
      confirmDismiss: (_) async {
        onComplete();
        return false; // Don't actually dismiss
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 24),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32),
            SizedBox(width: 8),
            Text(
              'Complete',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      child: BounceTap(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: isCompleted
                ? Border.all(color: Colors.green.withValues(alpha: 0.3), width: 1.5)
                : null,
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            children: [
              // Icon circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  IconData(habit.iconCodePoint, fontFamily: 'MaterialIcons'),
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              // Name
              Expanded(
                child: Text(
                  habit.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isCompleted ? Colors.grey : null,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ),
              // Status
              if (isCompleted)
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.green, size: 20),
                )
              else
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.withValues(alpha: 0.5),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
