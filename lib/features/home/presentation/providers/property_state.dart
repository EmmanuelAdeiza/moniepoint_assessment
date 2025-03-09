import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moniepoint_assessment/shared/models/property.dart';
import 'package:moniepoint_assessment/core/constants/assets.dart';

enum PropertyListingType { rent, buy }

final propertyStateProvider = ChangeNotifierProvider<PropertyState>((ref) {
  return PropertyState();
});

class PropertyState extends ChangeNotifier {
  static final PropertyState _instance = PropertyState._internal();
  factory PropertyState() => _instance;
  PropertyState._internal();

  bool _isMapView = false;
  PropertyListingType _listingType = PropertyListingType.buy;
  String _searchQuery = '';
  double? _minPrice;
  double? _maxPrice;

  final List<Property> _properties = [
    const Property(
      id: '1',
      name: 'Victoria Island Apartment',
      address: 'Adeola Odeku St, Victoria Island',
      price: 850000,
      image: Assets.propertyVictoria,
      bedrooms: 3,
      bathrooms: 3,
      area: 2000,
      rating: 4.8,
      latitude: 6.4355,
      longitude: 3.4589,
    ),
    const Property(
      id: '2',
      name: 'Lekki Phase 1 Estate',
      address: 'Admiralty Way, Lekki Phase 1',
      price: 650000,
      image: Assets.propertyLekki,
      bedrooms: 4,
      bathrooms: 3,
      area: 2200,
      rating: 4.9,
      latitude: 6.4698,
      longitude: 3.3882,
    ),
    const Property(
      id: '3',
      name: 'Ikoyi Penthouse',
      address: 'Bourdillon Road, Ikoyi',
      price: 450000,
      image: Assets.propertyIkoyi,
      bedrooms: 4,
      bathrooms: 3,
      area: 2400,
      rating: 5.0,
      latitude: 6.4412,
      longitude: 3.4791,
    ),
    const Property(
      id: '4',
      name: 'Oniru Residence',
      address: 'Victoria Island, Lagos',
      price: 420000,
      image: Assets.propertyOniru,
      bedrooms: 3,
      bathrooms: 3,
      area: 1800,
      rating: 4.7,
      latitude: 6.4698,
      longitude: 3.4721,
    ),
    const Property(
      id: '5',
      name: 'Ogba Apartment',
      address: 'Ogba, Lagos',
      price: 380000,
      image: Assets.propertyOgba,
      bedrooms: 2,
      bathrooms: 2,
      area: 1400,
      rating: 4.5,
      latitude: 6.5906,
      longitude: 3.3396,
    ),
    const Property(
      id: '6',
      name: 'Osapa London Villa',
      address: 'Osapa, Lekki',
      price: 480000,
      image: Assets.propertyOsapa,
      bedrooms: 4,
      bathrooms: 3,
      area: 2200,
      rating: 4.9,
      latitude: 6.4547,
      longitude: 3.3824,
    ),
    const Property(
      id: '7',
      name: 'Agege Residence',
      address: 'Agege, Lagos',
      price: 320000,
      image: Assets.propertyLekki,
      bedrooms: 3,
      bathrooms: 2,
      area: 1600,
      rating: 4.3,
      latitude: 6.6018,
      longitude: 3.3515,
    ),
    const Property(
      id: '8',
      name: 'Marina Heights',
      address: 'Marina, Lagos Island',
      price: 580000,
      image: Assets.propertyOgba,
      bedrooms: 3,
      bathrooms: 3,
      area: 1900,
      rating: 4.8,
      latitude: 6.4275,
      longitude: 3.4133,
    ),
    const Property(
      id: '9',
      name: 'Banana Island Luxury',
      address: 'Banana Island, Ikoyi',
      price: 620000,
      image: Assets.propertyOniru,
      bedrooms: 5,
      bathrooms: 4,
      area: 2500,
      rating: 5.0,
      latitude: 6.4501,
      longitude: 3.4659,
    ),
  ];

  // Getters
  bool get isMapView => _isMapView;
  PropertyListingType get listingType => _listingType;
  String get searchQuery => _searchQuery;
  double? get minPrice => _minPrice;
  double? get maxPrice => _maxPrice;
  List<Property> get properties => List.unmodifiable(_properties);

  // Methods
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

  void toggleFavorite(String propertyId) {
    final index = _properties.indexWhere((property) => property.id == propertyId);
    if (index != -1) {
      _properties[index] = _properties[index].copyWith(
        isFavorite: !_properties[index].isFavorite,
      );
      notifyListeners();
    }
  }

  List<Property> filterProperties({
    required bool isRent,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
  }) {
    return _properties.where((property) {
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        if (!property.name.toLowerCase().contains(query) && !property.address.toLowerCase().contains(query)) {
          return false;
        }
      }

      if (minPrice != null && property.price < minPrice) return false;
      if (maxPrice != null && property.price > maxPrice) return false;

      return true;
    }).toList();
  }
}
