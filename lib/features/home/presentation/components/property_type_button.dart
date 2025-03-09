import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';

class PropertyTypeButton extends StatelessWidget {
  const PropertyTypeButton({
    super.key,
    required this.title,
    required this.count,
    required this.targetCount,
    required this.animation,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final String count;
  final int targetCount;
  final Animation<double> animation;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isRent = title == 'RENT';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.scale(
            scale: 0.7 + (0.3 * animation.value),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: isRent ? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: isRent ? BorderRadius.circular(32) : null,
                  color: isActive ? AppTheme.orange : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05 * animation.value),
                      blurRadius: 10 * animation.value,
                      offset: Offset(0, 2 * animation.value),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isActive ? Colors.white : AppTheme.grey,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            final currentCount = (targetCount * animation.value).toInt();
                            final formattedCount = currentCount >= 1000
                                ? '${(currentCount / 1000).toStringAsFixed(0)} ${currentCount % 1000}'.padLeft(3, '0')
                                : currentCount.toString();
                            return Transform.scale(
                              scale: 0.8 + (0.2 * animation.value),
                              child: Text(
                                formattedCount,
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      color: isActive ? Colors.white : AppTheme.textSecondary,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 40,
                                    ),
                              ),
                            );
                          },
                        ),
                        Text(
                          'offers',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isActive ? Colors.white.withOpacity(0.7) : AppTheme.grey,
                              ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
