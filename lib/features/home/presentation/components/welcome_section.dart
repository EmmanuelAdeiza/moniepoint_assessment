import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, Marina',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w400,
                fontSize: 28,
              ),
        ).animate().fadeIn(duration: 600.ms).slideX(
              begin: -1.5,
              end: 0,
              delay: 200.ms,
            ),
        const SizedBox(height: 8),
        Text(
          'let\'s select your\nperfect place',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                height: 1.1,
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: AppTheme.textPrimary,
              ),
        ).animate(delay: 300.ms).fadeIn(duration: 600.ms).slideX(
              begin: -1.5,
              end: 0,
              delay: 600.ms,
            ),
      ],
    );
  }
}
