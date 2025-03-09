import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';

enum MarkerState { price, infrastructure, cosyArea, noLayer }

class PriceMarker extends StatefulWidget {
  final double price;
  final bool isSelected;
  final MarkerState markerState;

  const PriceMarker({
    super.key,
    required this.price,
    this.isSelected = false,
    this.markerState = MarkerState.price,
  });

  @override
  State<PriceMarker> createState() => _PriceMarkerState();
}

class _PriceMarkerState extends State<PriceMarker> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation.drive(
              Tween<double>(begin: 0.8, end: 1.0).chain(
                CurveTween(curve: Curves.easeOutExpo),
              ),
            ),
            child: child,
          ),
        );
      },
      child: _buildMarkerContent(),
    ).animate(onPlay: (controller) => controller.forward(from: 0)).slideX(
          begin: -1,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutExpo,
        );
  }

  Widget _buildMarkerContent() {
    String formatPrice(double price) {
      if (price >= 1000000) {
        return '₦${(price / 1000000).toStringAsFixed(1)}M';
      } else if (price >= 1000) {
        return '₦${(price / 1000).toStringAsFixed(0)}K';
      }
      return '₦${price.toStringAsFixed(0)}';
    }

    switch (widget.markerState) {
      case MarkerState.price:
        return Container(
          key: const ValueKey('price'),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.orange,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.markerBlack.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            formatPrice(widget.price),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF Pro Display',
            ),
          ),
        );

      case MarkerState.infrastructure:
        return Container(
          key: const ValueKey('infrastructure'),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppTheme.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: const Icon(
            Icons.business,
            color: Colors.white,
            size: 24,
          ),
        );

      case MarkerState.cosyArea:
        return Container(
          key: const ValueKey('cosy'),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppTheme.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: const Icon(
            Icons.home_work_rounded,
            color: Colors.white,
            size: 24,
          ),
        );

      case MarkerState.noLayer:
        return Container(
          key: const ValueKey('no_layer'),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppTheme.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: const Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: 24,
          ),
        );
    }
  }
}

class _MarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.orange
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.2, 0)
      ..lineTo(size.width * 0.8, 0)
      ..lineTo(size.width * 0.8, size.height * 0.7)
      ..lineTo(size.width * 0.5, size.height)
      ..lineTo(size.width * 0.2, size.height * 0.7)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
