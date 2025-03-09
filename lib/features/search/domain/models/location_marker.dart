import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMarker {
  final String id;
  final String title;
  final LatLng position;
  final String? description;
  final String? imageUrl;

  const LocationMarker({
    required this.id,
    required this.title,
    required this.position,
    this.description,
    this.imageUrl,
  });

  BitmapDescriptor get icon => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
}
