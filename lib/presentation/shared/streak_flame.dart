import 'package:flutter/material.dart';
import 'package:flutter_gamified_habits/core/theme/app_theme.dart';

class StreakFlame extends StatefulWidget {
  final int streak;
  final int flameLevel;
  final double size;

  const StreakFlame({
    super.key,
    required this.streak,
    required this.flameLevel,
    this.size = 48,
  });

  @override
  State<StreakFlame> createState() => _StreakFlameState();
}

class _StreakFlameState extends State<StreakFlame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.streak > 0;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isActive ? _scaleAnimation.value : 1.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive
                    ? Icons.local_fire_department
                    : Icons.ac_unit,
                size: widget.size * 0.6,
                color: isActive ? AppColors.streakOrange : Colors.grey,
              ),
              const SizedBox(height: 2),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.streakOrange.withValues(alpha: 0.2)
                      : Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${widget.streak}',
                  style: TextStyle(
                    fontSize: widget.size * 0.28,
                    fontWeight: FontWeight.w700,
                    color: isActive
                        ? AppColors.streakOrange
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
