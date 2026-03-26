import 'package:flutter/material.dart';

class DefaultHabit {
  final String name;
  final IconData icon;
  final Color color;

  const DefaultHabit({
    required this.name,
    required this.icon,
    required this.color,
  });
}

const defaultHabits = [
  DefaultHabit(
    name: 'Exercise',
    icon: Icons.fitness_center,
    color: Color(0xFFEF5350),
  ),
  DefaultHabit(
    name: 'Read',
    icon: Icons.menu_book,
    color: Color(0xFF42A5F5),
  ),
  DefaultHabit(
    name: 'Meditate',
    icon: Icons.self_improvement,
    color: Color(0xFF66BB6A),
  ),
  DefaultHabit(
    name: 'Code',
    icon: Icons.code,
    color: Color(0xFFAB47BC),
  ),
  DefaultHabit(
    name: 'Journal',
    icon: Icons.edit_note,
    color: Color(0xFFFFCA28),
  ),
];
