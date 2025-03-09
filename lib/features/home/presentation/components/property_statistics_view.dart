import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/extensions/number_extensions.dart';
import 'package:moniepoint_assessment/features/home/presentation/components/property_type_button.dart';
import 'package:moniepoint_assessment/features/home/presentation/providers/property_state.dart';

class PropertyStatisticsView extends StatelessWidget {
  const PropertyStatisticsView({
    super.key,
    required this.animation,
    required this.opacity,
    required this.propertyState,
  });

  final Animation<double> animation;
  final double opacity;
  final PropertyState propertyState;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: opacity,
      child: Row(
        children: [
          Expanded(
            child: PropertyTypeButton(
              title: 'BUY',
              count: 1134.formatWithThousandSeparator,
              targetCount: 1134,
              animation: animation,
              isActive: propertyState.listingType == PropertyListingType.buy,
              onTap: () => propertyState.setListingType(PropertyListingType.buy),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: PropertyTypeButton(
              title: 'RENT',
              count: 2212.formatWithThousandSeparator,
              targetCount: 2212,
              animation: animation,
              isActive: propertyState.listingType == PropertyListingType.rent,
              onTap: () => propertyState.setListingType(PropertyListingType.rent),
            ),
          ),
        ],
      ),
    );
  }
}
