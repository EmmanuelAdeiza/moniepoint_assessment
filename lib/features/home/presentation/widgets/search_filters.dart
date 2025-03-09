import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';

class SearchFilters extends StatelessWidget {
  final bool showFilters;

  const SearchFilters({
    super.key,
    this.showFilters = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!showFilters) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FilterOption(
            icon: Icons.check_circle_outline,
            label: 'Cosy areas',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _FilterOption(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Price',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _FilterOption(
            icon: Icons.business,
            label: 'Infrastructure',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _FilterOption(
            icon: Icons.layers_outlined,
            label: 'Without any layer',
            onTap: () {},
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.95, 0.95));
  }
}

class _FilterOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FilterOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: AppTheme.grey),
          const SizedBox(width: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.grey,
                ),
          ),
        ],
      ),
    );
  }
}
