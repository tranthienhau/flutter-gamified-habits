import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  double x, y;
  double vx, vy;
  double size;
  Color color;
  double life;
  double maxLife;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.life,
  }) : maxLife = life;
}

class ConfettiController {
  VoidCallback? _trigger;

  void fire() => _trigger?.call();
}

class ConfettiEffect extends StatefulWidget {
  final ConfettiController controller;
  final Offset origin;

  const ConfettiEffect({
    super.key,
    required this.controller,
    this.origin = Offset.zero,
  });

  @override
  State<ConfettiEffect> createState() => _ConfettiEffectState();
}

class _ConfettiEffectState extends State<ConfettiEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final _random = Random();

  static const _colors = [
    Color(0xFFFF6584),
    Color(0xFF6C63FF),
    Color(0xFFFFD700),
    Color(0xFF4CAF50),
    Color(0xFFFF9800),
    Color(0xFF00BCD4),
    Color(0xFFE91E63),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(_updateParticles);

    widget.controller._trigger = _fire;
  }

  void _fire() {
    _particles.clear();
    for (int i = 0; i < 25; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = 100 + _random.nextDouble() * 200;
      _particles.add(Particle(
        x: 0,
        y: 0,
        vx: cos(angle) * speed,
        vy: sin(angle) * speed - 150,
        size: 4 + _random.nextDouble() * 6,
        color: _colors[_random.nextInt(_colors.length)],
        life: 0.8 + _random.nextDouble() * 0.7,
      ));
    }
    _controller
      ..reset()
      ..forward();
  }

  void _updateParticles() {
    const dt = 1 / 60;
    const gravity = 400.0;
    for (final p in _particles) {
      p.x += p.vx * dt;
      p.y += p.vy * dt;
      p.vy += gravity * dt;
      p.life -= dt;
    }
    _particles.removeWhere((p) => p.life <= 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _ConfettiPainter(
            particles: _particles,
            origin: widget.origin,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final List<Particle> particles;
  final Offset origin;

  _ConfettiPainter({required this.particles, required this.origin});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final opacity = (p.life / p.maxLife).clamp(0.0, 1.0);
      final paint = Paint()..color = p.color.withValues(alpha: opacity);
      canvas.drawCircle(
        Offset(origin.dx + p.x, origin.dy + p.y),
        p.size * opacity,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) => true;
}

// Full-screen particle explosion for level-up
class LevelUpExplosion extends StatefulWidget {
  final VoidCallback? onComplete;

  const LevelUpExplosion({super.key, this.onComplete});

  @override
  State<LevelUpExplosion> createState() => _LevelUpExplosionState();
}

class _LevelUpExplosionState extends State<LevelUpExplosion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final _random = Random();

  static const _colors = [
    Color(0xFFFFD700),
    Color(0xFF6C63FF),
    Color(0xFFFF6584),
    Color(0xFF4CAF50),
    Color(0xFFFF9800),
    Color(0xFFE91E63),
    Color(0xFF00BCD4),
    Color(0xFF9C27B0),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..addListener(_updateParticles)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
        }
      });

    _spawnParticles();
    _controller.forward();
  }

  void _spawnParticles() {
    for (int i = 0; i < 50; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = 150 + _random.nextDouble() * 300;
      _particles.add(Particle(
        x: 0,
        y: 0,
        vx: cos(angle) * speed,
        vy: sin(angle) * speed - 200,
        size: 5 + _random.nextDouble() * 8,
        color: _colors[_random.nextInt(_colors.length)],
        life: 1.5 + _random.nextDouble() * 1.0,
      ));
    }
  }

  void _updateParticles() {
    const dt = 1 / 60;
    const gravity = 300.0;
    for (final p in _particles) {
      p.x += p.vx * dt;
      p.y += p.vy * dt;
      p.vy += gravity * dt;
      p.life -= dt;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final size = MediaQuery.of(context).size;
        return CustomPaint(
          painter: _ConfettiPainter(
            particles: _particles,
            origin: Offset(size.width / 2, size.height / 2),
          ),
          size: Size.infinite,
        );
      },
    );
  }
}
