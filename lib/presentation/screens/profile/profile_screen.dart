import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gamified_habits/core/constants/badge_definitions.dart';
import 'package:flutter_gamified_habits/core/constants/gamification.dart';
import 'package:flutter_gamified_habits/core/theme/app_theme.dart';
import 'package:flutter_gamified_habits/presentation/providers/providers.dart';
import 'package:flutter_gamified_habits/presentation/shared/xp_progress_ring.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final levelService = ref.read(levelServiceProvider);
    final levelResult = levelService.calculateLevel(profile.totalXp);
    final unlockedBadgeIds =
        profile.unlockedBadgeIds.map((s) => BadgeId.values.byName(s)).toSet();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Level badge with glow
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    AppColors.primaryLight.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  XpProgressRing(
                    progress: levelResult.progress,
                    level: levelResult.level,
                    icon: levelResult.icon,
                    size: 120,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    levelResult.levelName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${profile.totalXp} XP',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.95, 0.95)),

            const SizedBox(height: 24),

            // Stats counters
            Row(
              children: [
                _AnimatedCounter(
                  label: 'Completions',
                  value: profile.totalCompletions,
                  icon: Icons.check_circle,
                  color: AppColors.success,
                ),
                const SizedBox(width: 12),
                _AnimatedCounter(
                  label: 'Current Streak',
                  value: profile.currentStreak,
                  icon: Icons.local_fire_department,
                  color: AppColors.streakOrange,
                ),
                const SizedBox(width: 12),
                _AnimatedCounter(
                  label: 'Best Streak',
                  value: profile.longestStreak,
                  icon: Icons.emoji_events,
                  color: AppColors.xpGold,
                ),
              ],
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

            const SizedBox(height: 32),

            // Level progress
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Level Progress',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(GamificationConstants.maxLevel, (i) {
                    final lvl = i + 1;
                    final isReached = levelResult.level >= lvl;
                    final isCurrent = levelResult.level == lvl;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            GamificationConstants.levelIcons[i],
                            size: 20,
                            color: isReached ? AppColors.primary : Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Lv $lvl - ${GamificationConstants.levelNames[i]}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isCurrent
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isReached ? null : Colors.grey,
                              ),
                            ),
                          ),
                          Text(
                            '${GamificationConstants.xpForLevel(lvl)} XP',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            isReached
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            size: 18,
                            color: isReached
                                ? AppColors.success
                                : Colors.grey[300],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

            const SizedBox(height: 32),

            // Badge grid
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Badges',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: BadgeDefinitions.all.asMap().entries.map((entry) {
                final badge = entry.value;
                final isUnlocked = unlockedBadgeIds.contains(badge.id);
                return Container(
                  decoration: BoxDecoration(
                    color: isUnlocked
                        ? badge.color.withValues(alpha: 0.15)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: isUnlocked
                        ? Border.all(
                            color: badge.color.withValues(alpha: 0.4))
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        badge.icon,
                        size: 28,
                        color: isUnlocked ? badge.color : Colors.grey,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        badge.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isUnlocked ? null : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: (400 + entry.key * 60).ms,
                      duration: 300.ms,
                    )
                    .scale(begin: const Offset(0.8, 0.8));
              }).toList(),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _AnimatedCounter extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const _AnimatedCounter({
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
              tween: IntTween(begin: 0, end: value),
              duration: const Duration(milliseconds: 1000),
              builder: (_, val, child) {
                return Text(
                  '$val',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
