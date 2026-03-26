import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gamified_habits/core/services/haptic_service.dart';
import 'package:flutter_gamified_habits/core/theme/app_theme.dart';
import 'package:flutter_gamified_habits/data/models/habit.dart';
import 'package:flutter_gamified_habits/presentation/providers/providers.dart';
import 'package:uuid/uuid.dart';

class AddHabitSheet extends ConsumerStatefulWidget {
  const AddHabitSheet({super.key});

  @override
  ConsumerState<AddHabitSheet> createState() => _AddHabitSheetState();
}

class _AddHabitSheetState extends ConsumerState<AddHabitSheet> {
  final _nameController = TextEditingController();
  int _selectedIconIndex = 0;
  int _selectedColorIndex = 0;

  static const _icons = [
    Icons.fitness_center,
    Icons.menu_book,
    Icons.self_improvement,
    Icons.code,
    Icons.edit_note,
    Icons.water_drop,
    Icons.restaurant,
    Icons.bedtime,
    Icons.directions_walk,
    Icons.music_note,
    Icons.brush,
    Icons.language,
    Icons.savings,
    Icons.phone_disabled,
    Icons.local_florist,
    Icons.psychology,
  ];

  static const _colors = [
    Color(0xFFEF5350),
    Color(0xFF42A5F5),
    Color(0xFF66BB6A),
    Color(0xFFAB47BC),
    Color(0xFFFFCA28),
    Color(0xFFFF7043),
    Color(0xFF26C6DA),
    Color(0xFFEC407A),
    Color(0xFF8D6E63),
    Color(0xFF78909C),
    Color(0xFF5C6BC0),
    Color(0xFF26A69A),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final habits = ref.read(habitListProvider);
    final habit = Habit(
      id: const Uuid().v4(),
      name: name,
      iconCodePoint: _icons[_selectedIconIndex].codePoint,
      colorValue: _colors[_selectedColorIndex].toARGB32(),
      order: habits.length,
      createdAt: DateTime.now(),
    );

    ref.read(habitListProvider.notifier).addHabit(habit);
    HapticService.success();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 16, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'New Habit',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20),

            // Name field
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Habit name',
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.04),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),

            // Icon picker
            const Text(
              'Icon',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _icons.asMap().entries.map((entry) {
                final isSelected = entry.key == _selectedIconIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedIconIndex = entry.key);
                    HapticService.selection();
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.15)
                          : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: AppColors.primary, width: 2)
                          : null,
                    ),
                    child: Icon(
                      entry.value,
                      size: 22,
                      color: isSelected ? AppColors.primary : Colors.grey,
                    ),
                  )
                      .animate(
                        delay: (entry.key * 30).ms,
                      )
                      .scale(begin: const Offset(0, 0), curve: Curves.elasticOut, duration: 500.ms),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Color picker
            const Text(
              'Color',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _colors.asMap().entries.map((entry) {
                final isSelected = entry.key == _selectedColorIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedColorIndex = entry.key);
                    HapticService.selection();
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: entry.value,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: entry.value.withValues(alpha: 0.5),
                                blurRadius: 8,
                              )
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check,
                            color: Colors.white, size: 18)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Save button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Create Habit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
