import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PropertyListingType { rent, buy }

final uiStateProvider = ChangeNotifierProvider<UIStateProvider>((ref) {
  return UIStateProvider();
});

class UIStateProvider extends ChangeNotifier {
  bool _isMapView = false;
  PropertyListingType _listingType = PropertyListingType.rent;
  String _searchQuery = '';
  double? _minPrice;
  double? _maxPrice;

  bool get isMapView => _isMapView;
  PropertyListingType get listingType => _listingType;
  String get searchQuery => _searchQuery;
  double? get minPrice => _minPrice;
  double? get maxPrice => _maxPrice;

  void toggleMapView() {
    _isMapView = !_isMapView;
    notifyListeners();
  }

  void setListingType(PropertyListingType type) {
    _listingType = type;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setPriceRange(double? min, double? max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
  }

  void resetFilters() {
    _searchQuery = '';
    _minPrice = null;
    _maxPrice = null;
    notifyListeners();
  }
}
