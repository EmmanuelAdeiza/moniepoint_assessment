import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';
import 'package:moniepoint_assessment/features/home/presentation/components/property_card.dart';
import 'package:moniepoint_assessment/features/home/presentation/providers/property_state.dart';
import 'package:moniepoint_assessment/features/home/presentation/providers/property_card_provider.dart';
import 'package:provider/provider.dart';

class PropertyListSection extends StatelessWidget {
  final PropertyState propertyState;
  final ScrollController scrollController;

  const PropertyListSection({super.key, required this.propertyState, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    if (propertyState.properties.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: ListView.separated(
        controller: scrollController,
        separatorBuilder: (context, index) => const SizedBox.shrink(),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 150,
          left: 8,
          right: 8,
        ),
        itemCount: propertyState.properties.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                SizedBox(
                  height: 300,
                  child: ChangeNotifierProvider(
                    create: (_) => PropertyCardProvider(),
                    child: PropertyCard(
                      property: propertyState.properties[0],
                      height: 300,
                      isMainCard: true,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ).animate().fadeIn(duration: 600.ms).slideY(
                  begin: 0.2,
                  end: 0,
                  curve: Curves.easeOutCubic,
                  duration: 800.ms,
                );
          }

          // Calculate the actual index for remaining properties (skipping the first one)
          final propertyIndex = (index - 1) * 2 + 1;
          if (propertyIndex >= propertyState.properties.length) {
            return null;
          }

          // Check if we have a second property for this row
          final hasSecondProperty = propertyIndex + 1 < propertyState.properties.length;

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ChangeNotifierProvider(
                      create: (_) => PropertyCardProvider(),
                      child: PropertyCard(
                        property: propertyState.properties[propertyIndex],
                        height: 250,
                        isMainCard: false,
                      ),
                    ),
                  ),
                  if (hasSecondProperty) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: ChangeNotifierProvider(
                        create: (_) => PropertyCardProvider(),
                        child: PropertyCard(
                          property: propertyState.properties[propertyIndex + 1],
                          height: 250,
                          isMainCard: false,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
            ],
          ).animate().fadeIn(duration: 600.ms).slideY(
                begin: 0.2,
                end: 0,
                curve: Curves.easeOutCubic,
                duration: 800.ms,
              );
        },
      ),
    );
  }
}
