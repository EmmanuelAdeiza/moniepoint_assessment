import 'package:freezed_annotation/freezed_annotation.dart';

part 'property.freezed.dart';
part 'property.g.dart';

@freezed
class Property with _$Property {
  const factory Property({
    required String id,
    required String name,
    required String address,
    required double price,
    required String image,
    required int bedrooms,
    required int bathrooms,
    required double area,
    required double rating,
    @Default(false) bool isFavorite,
    required double latitude,
    required double longitude,
  }) = _Property;

  factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);
}
