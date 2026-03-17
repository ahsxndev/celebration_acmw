import 'package:flutter/material.dart';

class PulsingPoster extends StatefulWidget {
  final String imagePath;

  const PulsingPoster({super.key, required this.imagePath});

  @override
  State<PulsingPoster> createState() => _PulsingPosterState();
}

class _PulsingPosterState extends State<PulsingPoster>
    with TickerProviderStateMixin {

  late AnimationController _glowController;
  late AnimationController _scaleController;

  late Animation<double> glowAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    /// Glow animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    glowAnimation = Tween<double>(
      begin: 8,
      end: 28,
    ).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    /// Floating scale animation
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.03,
    ).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_glowController, _scaleController]),
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.pinkAccent.withOpacity(0.6),
                  blurRadius: glowAnimation.value,
                  spreadRadius: glowAnimation.value / 3,
                ),
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.4),
                  blurRadius: glowAnimation.value,
                  spreadRadius: glowAnimation.value / 4,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}