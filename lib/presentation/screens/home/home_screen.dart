import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gamified_habits/core/constants/gamification.dart';
import 'package:flutter_gamified_habits/core/services/haptic_service.dart';
import 'package:flutter_gamified_habits/core/theme/app_theme.dart';
import 'package:flutter_gamified_habits/domain/services/level_service.dart';
import 'package:flutter_gamified_habits/presentation/providers/providers.dart';
import 'package:flutter_gamified_habits/presentation/shared/particle_effect.dart';
import 'package:flutter_gamified_habits/presentation/shared/streak_flame.dart';
import 'package:flutter_gamified_habits/presentation/shared/xp_progress_ring.dart';
import 'package:flutter_gamified_habits/presentation/shared/xp_toast.dart';
import 'package:flutter_gamified_habits/presentation/screens/home/habit_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _confettiController = ConfettiController();
  OverlayEntry? _toastOverlay;
  Offset _confettiOrigin = Offset.zero;



  Future<void> _completeHabit(String habitId, Offset cardPosition) async {
    final useCase = ref.read(completeHabitUseCaseProvider);
    final result = await useCase.execute(habitId);

    // Refresh state
    ref.read(habitListProvider.notifier).refresh();
    ref.read(completionsProvider.notifier).refresh();
    ref.read(profileProvider.notifier).refresh();

    HapticService.success();

    // Confetti
    setState(() {
      _confettiOrigin = cardPosition;
    });
    _confettiController.fire();

    // XP toast
    _showXpToast(result.xpEarned);

    // Level up
    if (result.levelResult.didLevelUp && mounted) {
      _showLevelUpDialog(result.levelResult);
    }
  }

  void _showXpToast(int xp) {
    _toastOverlay?.remove();
    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 80,
        left: 0,
        right: 0,
        child: Center(
          child: XpToast(
            xp: xp,
            onComplete: () {
              _toastOverlay?.remove();
              _toastOverlay = null;
            },
          ),
        ),
      ),
    );
    _toastOverlay = overlay;
    Overlay.of(context).insert(overlay);
  }

  void _showLevelUpDialog(LevelResult levelResult) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Stack(
        children: [
          const LevelUpExplosion(),
          Center(
            child: Container(
              margin: const EdgeInsets.all(32),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    levelResult.icon,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Level Up!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    levelResult.levelName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _toastOverlay?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habits = ref.watch(habitListProvider);
    final completedIds = ref.watch(todayCompletedHabitIdsProvider);
    final profile = ref.watch(profileProvider);
    final progress = ref.watch(dailyProgressProvider);
    final streakService = ref.read(streakServiceProvider);
    final levelService = ref.read(levelServiceProvider);
    final levelResult = levelService.calculateLevel(profile.totalXp);
    final flameLevel = streakService.flameSizeLevel(profile.currentStreak);

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Greeting + theme toggle
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _greeting(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'Today\'s Habits',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  ref.read(themeModeProvider.notifier).toggle(),
                              icon: Icon(
                                Theme.of(context).brightness == Brightness.dark
                                    ? Icons.light_mode
                                    : Icons.dark_mode,
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

                        const SizedBox(height: 20),

                        // Stats row: XP Ring + Streak + Progress
                        Row(
                          children: [
                            XpProgressRing(
                              progress: levelResult.progress,
                              level: levelResult.level,
                              icon: levelResult.icon,
                              size: 80,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${profile.totalXp} XP',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    levelResult.xpToNext > 0
                                        ? '${levelResult.xpToNext} XP to ${GamificationConstants.levelNames[levelResult.level]}'
                                        : 'Max Level!',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            StreakFlame(
                              streak: profile.currentStreak,
                              flameLevel: flameLevel,
                              size: 56,
                            ),
                          ],
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

                        const SizedBox(height: 20),

                        // Daily progress bar
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Daily Progress',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${completedIds.length}/${habits.where((h) => h.isActive).length}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: progress),
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeOutCubic,
                                builder: (context, value, _) {
                                  return LinearProgressIndicator(
                                    value: value,
                                    minHeight: 10,
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white12
                                            : Colors.black.withValues(alpha: 0.06),
                                    valueColor:
                                        const AlwaysStoppedAnimation(
                                            AppColors.primary),
                                  );
                                },
                              ),
                            ),
                          ],
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                        const SizedBox(height: 24),

                        // Section header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Habits',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => context.push('/add'),
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Add'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Habit list
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  sliver: SliverReorderableList(
                    itemCount: habits.length,
                    onReorder: (oldIndex, newIndex) {
                      ref
                          .read(habitListProvider.notifier)
                          .reorder(oldIndex, newIndex);
                    },
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      final isCompleted = completedIds.contains(habit.id);
                      return ReorderableDragStartListener(
                        key: ValueKey(habit.id),
                        index: index,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: HabitCard(
                            habit: habit,
                            isCompleted: isCompleted,
                            onComplete: () {
                              if (isCompleted) return;
                              // Get approximate card position for confetti
                              final box =
                                  context.findRenderObject() as RenderBox?;
                              final pos = box?.localToGlobal(Offset.zero) ??
                                  Offset.zero;
                              _completeHabit(
                                habit.id,
                                Offset(pos.dx + 100, pos.dy + 30),
                              );
                            },
                            onTap: () =>
                                context.push('/detail/${habit.id}'),
                          )
                              .animate()
                              .fadeIn(
                                delay: (300 + index * 80).ms,
                                duration: 400.ms,
                              )
                              .slideX(begin: 0.05),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Confetti overlay
          Positioned.fill(
            child: IgnorePointer(
              child: ConfettiEffect(
                controller: _confettiController,
                origin: _confettiOrigin,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }
}
