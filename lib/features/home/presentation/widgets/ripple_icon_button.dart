import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';

class RippleIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final Color rippleColor;

  const RippleIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 58,
    this.backgroundColor = AppTheme.darkGrey,
    this.iconColor = AppTheme.white,
    this.rippleColor = AppTheme.white,
  });

  @override
  State<RippleIconButton> createState() => _RippleIconButtonState();
}

class _RippleIconButtonState extends State<RippleIconButton> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.4,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() => _isAnimating = true);
      } else if (status == AnimationStatus.completed) {
        setState(() => _isAnimating = false);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animationController.forward(from: 0.0).then((_) {
      widget.onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _handleTap(),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.backgroundColor.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated splash effect
            if (_isAnimating)
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Container(
                      width: widget.size * _scaleAnimation.value,
                      height: widget.size * _scaleAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.rippleColor.withOpacity(_opacityAnimation.value),
                          width: 8,
                        ),
                      ),
                    );
                  },
                ),
              ),
            // Icon
            Icon(
              widget.icon,
              color: widget.iconColor,
              size: widget.size * 0.52, // Proportional icon size
            ),
          ],
        ),
      ),
    );
  }
}
