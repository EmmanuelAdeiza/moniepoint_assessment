import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';
import 'package:moniepoint_assessment/core/constants/assets.dart';
import 'package:moniepoint_assessment/core/extensions/widget_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: AppTheme.locationShadow,
          ),
          child: ClipRect(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppTheme.textSecondary,
                  size: 18,
                ).animate(delay: 400.ms).fadeIn(duration: 400.ms).slideX(begin: -0.5, end: 0),
                const SizedBox(width: 8),
                Text(
                  'Saint Petersburg',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                ).animate(delay: 500.ms).fadeIn(duration: 400.ms).slideX(begin: -0.5, end: 0),
              ],
            ),
          ),
        ).expandFromLeft(),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: AppTheme.mediumShadow,
          ),
          child: const CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.white,
            backgroundImage: AssetImage(Assets.avatar),
          ),
        )
            .animate()
            .fadeIn(
              duration: 400.ms,
              curve: Curves.easeOut,
            )
            .scaleXY(
              begin: 0.1,
              end: 1.0,
              duration: 800.ms,
              curve: Curves.easeIn,
            ),
      ],
    );
  }
}
