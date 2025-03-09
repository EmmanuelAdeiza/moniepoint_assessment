import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';
import 'package:moniepoint_assessment/shared/models/property.dart';
import 'package:moniepoint_assessment/core/extensions/widget_extensions.dart';
import 'package:moniepoint_assessment/features/home/presentation/providers/property_card_provider.dart';

class PropertyCard extends StatefulWidget {
  const PropertyCard({
    super.key,
    required this.property,
    required this.height,
    required this.isMainCard,
  });

  final Property property;
  final double height;
  final bool isMainCard;

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyCardProvider>().initializeCard(
            property: widget.property,
            height: widget.height,
            isMainCard: widget.isMainCard,
          );
    });
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: PropertyCardProvider.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.read<PropertyCardProvider>().hasShown) {
        _animationController.forward();
        context.read<PropertyCardProvider>().setShown();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildAddressText(BuildContext context, PropertyCardProvider provider) {
    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: Text(
          provider.property?.address ?? '',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: provider.isMainCard ? 14 : 12,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildChevronButton(PropertyCardProvider provider) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: provider.iconSize,
        height: provider.iconSize,
        margin: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 5),
          ],
        ),
        alignment: Alignment.center,
        child: const Icon(
          CupertinoIcons.chevron_right,
          color: Colors.grey,
          size: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyCardProvider>(
      builder: (context, provider, child) {
        return Container(
          height: provider.height,
          decoration: provider.buildCardDecoration(),
          child: Stack(
            children: [
              SizedBox(
                height: provider.height,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(provider.borderRadius),
                  child: Image.asset(
                    provider.property?.image ?? '',
                    height: provider.height,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error_outline),
                      );
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: provider.padding,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(PropertyCardProvider.addressContainerBorderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: Container(
                          height: provider.addressHeight,
                          decoration: provider.buildAddressContainerDecoration(),
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              _buildAddressText(context, provider),
                              _buildChevronButton(provider),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ).expandFromLeft(
                duration: PropertyCardProvider.animationDuration.inMilliseconds.ms,
                delay: PropertyCardProvider.expandDelay.inMilliseconds.ms,
              ),
            ],
          ),
        )
            // .animate(
            //   onPlay: (controller) => controller.repeat(reverse: true),
            // )
            // .shimmer(
            //   delay: PropertyCardProvider.shimmerDelay.inMilliseconds.ms,
            //   duration: PropertyCardProvider.shimmerDuration.inMilliseconds.ms,
            // )

            ;
      },
    );
  }
}
