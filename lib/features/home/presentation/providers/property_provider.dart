import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moniepoint_assessment/shared/models/property.dart';

final propertyProvider = ChangeNotifierProvider<PropertyProvider>((ref) {
  return PropertyProvider();
});

class PropertyProvider extends ChangeNotifier {
  final List<Property> _properties = [
    const Property(
      id: '1',
      name: 'Modern Apartment',
      address: '123 Main St, New York',
      price: 2500,
      image: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
      bedrooms: 2,
      bathrooms: 2,
      area: 1200,
      rating: 4.8,
      latitude: 40.7128,
      longitude: -74.0060,
    ),
    const Property(
      id: '2',
      name: 'Luxury Condo',
      address: '456 Park Ave, Manhattan',
      price: 3500,
      image: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
      bedrooms: 3,
      bathrooms: 2,
      area: 1500,
      rating: 4.9,
      latitude: 40.7589,
      longitude: -73.9851,
    ),
    const Property(
      id: '3',
      name: 'Penthouse Suite',
      address: '789 5th Ave, Manhattan',
      price: 5000,
      image: 'https://images.unsplash.com/photo-1512915922686-57c11dde9b6b?w=800',
      bedrooms: 4,
      bathrooms: 3,
      area: 2000,
      rating: 5.0,
      latitude: 40.7829,
      longitude: -73.9654,
    ),
  ];

  List<Property> get properties => List.unmodifiable(_properties);

  void toggleFavorite(String propertyId) {
    final index = _properties.indexWhere((property) => property.id == propertyId);
    if (index != -1) {
      _properties[index] = _properties[index].copyWith(
        isFavorite: !_properties[index].isFavorite,
      );
      notifyListeners();
    }
  }

  // Filter properties
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
