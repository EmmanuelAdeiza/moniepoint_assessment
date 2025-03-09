import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';

class ListOfVariantsButton extends StatelessWidget {
  const ListOfVariantsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkGrey.withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.menu,
            color: AppTheme.white,
            size: 18,
          ),
          const SizedBox(width: 12),
          Text(
            'List of variants',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
