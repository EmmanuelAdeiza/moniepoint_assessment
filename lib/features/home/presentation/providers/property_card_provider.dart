import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/shared/models/property.dart';

class PropertyCardProvider extends ChangeNotifier {
  // Animation states
  bool _hasShown = false;
  bool get hasShown => _hasShown;

  // Animation constants
  static const animationDuration = Duration(milliseconds: 1000);
  static const expandDelay = Duration(milliseconds: 3500);
  static const shimmerDelay = Duration(milliseconds: 1500);
  static const shimmerDuration = Duration(milliseconds: 1800);

  // UI constants
  static const double mainCardBorderRadius = 32.0;
  static const double regularCardBorderRadius = 24.0;
  static const double addressContainerBorderRadius = 44.0;
  static const double mainCardAddressHeight = 50.0;
  static const double regularCardAddressHeight = 44.0;
  static const double mainCardIconSize = 44.0;
  static const double regularIconSize = 36.0;

  // Property data
  Property? _property;
  Property? get property => _property;

  // Card configuration
  bool _isMainCard = false;
  bool get isMainCard => _isMainCard;

  double _height = 0.0;
  double get height => _height;

  void initializeCard({
    required Property property,
    required double height,
    required bool isMainCard,
  }) {
    _property = property;
    _height = height;
    _isMainCard = isMainCard;
    notifyListeners();
  }

  void setShown() {
    _hasShown = true;
    notifyListeners();
  }

  // Helper methods for UI components
  double get borderRadius => isMainCard ? mainCardBorderRadius : regularCardBorderRadius;
  double get addressHeight => isMainCard ? mainCardAddressHeight : regularCardAddressHeight;
  double get iconSize => isMainCard ? mainCardIconSize : regularIconSize;
  EdgeInsets get padding => isMainCard ? const EdgeInsets.all(12.0) : const EdgeInsets.all(6.0);

  BoxDecoration buildCardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  BoxDecoration buildAddressContainerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(addressContainerBorderRadius),
      color: Colors.white.withOpacity(0.6),
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.6),
          Colors.white.withOpacity(0.4),
        ],
      ),
    );
  }
}
