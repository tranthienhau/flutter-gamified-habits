import 'package:flutter/material.dart';
import 'package:flutter_gamified_habits/core/theme/app_theme.dart';
import 'package:flutter_gamified_habits/data/models/completion.dart';

class CompletionCalendar extends StatelessWidget {
  final List<Completion> completions;
  final int weeksToShow;

  const CompletionCalendar({
    super.key,
    required this.completions,
    this.weeksToShow = 12,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CalendarHeatmapPainter(
        completions: completions,
        weeksToShow: weeksToShow,
        isDark: Theme.of(context).brightness == Brightness.dark,
      ),
      size: Size(weeksToShow * 14.0, 7 * 14.0),
    );
  }
}

class _CalendarHeatmapPainter extends CustomPainter {
  final List<Completion> completions;
  final int weeksToShow;
  final bool isDark;

  _CalendarHeatmapPainter({
    required this.completions,
    required this.weeksToShow,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const cellSize = 10.0;
    const gap = 3.0;
    const total = cellSize + gap;

    // Count completions per day
    final counts = <String, int>{};
    for (final c in completions) {
      final key =
          '${c.completedAt.year}-${c.completedAt.month}-${c.completedAt.day}';
      counts[key] = (counts[key] ?? 0) + 1;
    }

    final today = DateTime.now();
    final startDate =
        today.subtract(Duration(days: weeksToShow * 7 - 1));

    for (int i = 0; i < weeksToShow * 7; i++) {
      final date = startDate.add(Duration(days: i));
      if (date.isAfter(today)) break;

      final week = i ~/ 7;
      final day = i % 7;
      final key = '${date.year}-${date.month}-${date.day}';
      final count = counts[key] ?? 0;

      final color = _colorForCount(count);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(week * total, day * total, cellSize, cellSize),
        const Radius.circular(2),
      );
      canvas.drawRRect(rect, Paint()..color = color);
    }
  }

  Color _colorForCount(int count) {
    if (count == 0) {
      return isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06);
    }
    if (count == 1) return AppColors.primary.withValues(alpha: 0.3);
    if (count == 2) return AppColors.primary.withValues(alpha: 0.5);
    if (count <= 4) return AppColors.primary.withValues(alpha: 0.7);
    return AppColors.primary;
  }

  @override
  bool shouldRepaint(_CalendarHeatmapPainter oldDelegate) => true;
}
