import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gamified_habits/core/constants/badge_definitions.dart';
import 'package:flutter_gamified_habits/core/constants/gamification.dart';
import 'package:flutter_gamified_habits/core/theme/app_theme.dart';
import 'package:flutter_gamified_habits/presentation/providers/providers.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final levelService = ref.read(levelServiceProvider);
    final levelResult = levelService.calculateLevel(profile.totalXp);
    final unlockedBadgeIds =
        profile.unlockedBadgeIds.map((s) => BadgeId.values.byName(s)).toSet();

    return Scaffold(
      appBar: AppBar(title: const Text('Rewards')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current level highlight
            Center(
              child: Column(
                children: [
                  Icon(
                    levelResult.icon,
                    size: 72,
                    color: AppColors.primary,
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.1, 1.1),
                        duration: 1500.ms,
                      ),
                  const SizedBox(height: 8),
                  Text(
                    levelResult.levelName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Level ${levelResult.level}',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms),

            const SizedBox(height: 32),

            // Unlocked badges
            const Text(
              'Unlocked Badges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            if (unlockedBadgeIds.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(Icons.lock_outline,
                          size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      Text(
                        'Complete habits to unlock badges!',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...BadgeDefinitions.all
                  .where((b) => unlockedBadgeIds.contains(b.id))
                  .map((badge) => _BadgeCard(badge: badge)),

            const SizedBox(height: 32),

            // Locked badges
            const Text(
              'Locked Badges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...BadgeDefinitions.all
                .where((b) => !unlockedBadgeIds.contains(b.id))
                .map((badge) => _BadgeCard(badge: badge, locked: true)),

            const SizedBox(height: 32),

            // Level milestones
            const Text(
              'Level Milestones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...List.generate(GamificationConstants.maxLevel, (i) {
              final lvl = i + 1;
              final reached = levelResult.level >= lvl;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: reached
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: reached
                      ? Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3))
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      GamificationConstants.levelIcons[i],
                      size: 24,
                      color: reached ? AppColors.primary : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            GamificationConstants.levelNames[i],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: reached ? null : Colors.grey,
                            ),
                          ),
                          Text(
                            '${GamificationConstants.xpForLevel(lvl)} XP required',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      reached
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: reached ? AppColors.success : Colors.grey[300],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final BadgeDefinition badge;
  final bool locked;

  const _BadgeCard({required this.badge, this.locked = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: locked
            ? Colors.grey.withValues(alpha: 0.05)
            : badge.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: locked
            ? null
            : Border.all(color: badge.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: locked
                  ? Colors.grey.withValues(alpha: 0.15)
                  : badge.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              badge.icon,
              color: locked ? Colors.grey : badge.color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  badge.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: locked ? Colors.grey : null,
                  ),
                ),
                Text(
                  badge.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          if (locked)
            Icon(Icons.lock, size: 18, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
