import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';
import 'package:moniepoint_assessment/features/home/presentation/widgets/price_marker.dart';

class DirectionFiltersWidget extends StatelessWidget {
  final bool showDirectionFilters;
  final Function(MarkerState) onFilterSelected;
  final MarkerState selectedFilter;

  const DirectionFiltersWidget({
    super.key,
    required this.showDirectionFilters,
    required this.onFilterSelected,
    this.selectedFilter = MarkerState.price,
  });

  @override
  Widget build(BuildContext context) {
    if (!showDirectionFilters) return const SizedBox.shrink();

    return Positioned(
      left: 24,
      bottom: 200,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.shadowColor,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _DirectionFilterOption(
              icon: Icons.check_circle_outline,
              label: 'Cosy areas',
              isSelected: selectedFilter == MarkerState.cosyArea,
              onTap: () => onFilterSelected(MarkerState.cosyArea),
            ),
            const SizedBox(height: 12),
            _DirectionFilterOption(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Price',
              isSelected: selectedFilter == MarkerState.price,
              onTap: () => onFilterSelected(MarkerState.price),
            ),
            const SizedBox(height: 12),
            _DirectionFilterOption(
              icon: Icons.delete_outline,
              label: 'Infrastructure',
              isSelected: selectedFilter == MarkerState.infrastructure,
              onTap: () => onFilterSelected(MarkerState.infrastructure),
            ),
            const SizedBox(height: 12),
            _DirectionFilterOption(
              icon: Icons.layers_outlined,
              label: 'Without any layer',
              isSelected: selectedFilter == MarkerState.noLayer,
              onTap: () => onFilterSelected(MarkerState.noLayer),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).scale(
            begin: const Offset(0.95, 0.95),
            alignment: Alignment.bottomLeft,
          ),
    );
  }
}

class _DirectionFilterOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DirectionFilterOption({
    required this.icon,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? AppTheme.orange : AppTheme.grey,
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? AppTheme.orange : AppTheme.grey,
                    fontWeight: FontWeight.w500,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class DirectionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DirectionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.darkGrey,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.navigation_rounded,
          color: AppTheme.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
