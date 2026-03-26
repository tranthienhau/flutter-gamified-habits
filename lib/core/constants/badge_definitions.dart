import 'package:flutter/material.dart';

enum BadgeId {
  firstStep,
  hatTrick,
  perfectDay,
  onFire,
  weekWarrior,
  fortnight,
  monthlyMaster,
  centurion,
  earlyBird,
  nightOwl,
  diversified,
  levelFive,
}

class BadgeDefinition {
  final BadgeId id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  const BadgeDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class BadgeDefinitions {
  BadgeDefinitions._();

  static const List<BadgeDefinition> all = [
    BadgeDefinition(
      id: BadgeId.firstStep,
      name: 'First Step',
      description: 'Complete your first habit',
      icon: Icons.star_outline,
      color: Color(0xFFFFD700),
    ),
    BadgeDefinition(
      id: BadgeId.hatTrick,
      name: 'Hat Trick',
      description: 'Complete 3 habits in one day',
      icon: Icons.looks_3,
      color: Color(0xFF4CAF50),
    ),
    BadgeDefinition(
      id: BadgeId.perfectDay,
      name: 'Perfect Day',
      description: 'Complete all habits in one day',
      icon: Icons.wb_sunny,
      color: Color(0xFFFF9800),
    ),
    BadgeDefinition(
      id: BadgeId.onFire,
      name: 'On Fire',
      description: 'Reach a 7-day streak',
      icon: Icons.local_fire_department,
      color: Color(0xFFF44336),
    ),
    BadgeDefinition(
      id: BadgeId.weekWarrior,
      name: 'Week Warrior',
      description: 'Complete all habits every day for a week',
      icon: Icons.shield,
      color: Color(0xFF2196F3),
    ),
    BadgeDefinition(
      id: BadgeId.fortnight,
      name: 'Fortnight',
      description: 'Maintain a 14-day streak',
      icon: Icons.calendar_today,
      color: Color(0xFF9C27B0),
    ),
    BadgeDefinition(
      id: BadgeId.monthlyMaster,
      name: 'Monthly Master',
      description: 'Maintain a 30-day streak',
      icon: Icons.emoji_events,
      color: Color(0xFFE91E63),
    ),
    BadgeDefinition(
      id: BadgeId.centurion,
      name: 'Centurion',
      description: 'Complete 100 total habits',
      icon: Icons.military_tech,
      color: Color(0xFF795548),
    ),
    BadgeDefinition(
      id: BadgeId.earlyBird,
      name: 'Early Bird',
      description: 'Complete a habit before 8 AM',
      icon: Icons.wb_twilight,
      color: Color(0xFFFF5722),
    ),
    BadgeDefinition(
      id: BadgeId.nightOwl,
      name: 'Night Owl',
      description: 'Complete a habit after 10 PM',
      icon: Icons.nightlight,
      color: Color(0xFF3F51B5),
    ),
    BadgeDefinition(
      id: BadgeId.diversified,
      name: 'Diversified',
      description: 'Have 5 or more active habits',
      icon: Icons.grid_view,
      color: Color(0xFF00BCD4),
    ),
    BadgeDefinition(
      id: BadgeId.levelFive,
      name: 'Level Five',
      description: 'Reach level 5',
      icon: Icons.trending_up,
      color: Color(0xFF8BC34A),
    ),
  ];

  static BadgeDefinition getById(BadgeId id) {
    return all.firstWhere((b) => b.id == id);
  }
}
