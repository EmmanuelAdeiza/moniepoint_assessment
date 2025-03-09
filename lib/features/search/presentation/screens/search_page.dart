import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';
import 'package:moniepoint_assessment/features/home/presentation/pages/search_page.dart';
import 'package:moniepoint_assessment/features/home/presentation/providers/property_state.dart';
import 'package:moniepoint_assessment/features/home/presentation/widgets/direction_filters.dart';
import 'package:moniepoint_assessment/features/home/presentation/widgets/price_marker.dart';
import 'package:moniepoint_assessment/features/home/presentation/widgets/ripple_icon_button.dart';
import 'package:moniepoint_assessment/features/home/presentation/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _propertyState = PropertyState();
  final _mapController = MapController();
  bool _showFilters = false;
  bool _showDirectionFilters = false;
  final _layersButtonKey = GlobalKey();

  // Sample property data for Saint Petersburg
  final List<Map<String, dynamic>> _properties = [
    {'price': 450000.0, 'position': const LatLng(59.9397, 30.3244)}, // Near Chernyshevskaya
    {'price': 650000.0, 'position': const LatLng(59.9367, 30.3207)}, // Near Smolny Cathedral
    {'price': 550000.0, 'position': const LatLng(59.9405, 30.3547)}, // Near Novocherkasskaya
    {'price': 850000.0, 'position': const LatLng(59.9289, 30.3609)}, // Near Ploshchad Alexandra Nevskogo
    {'price': 380000.0, 'position': const LatLng(59.9198, 30.3350)}, // Near Ligovsky Prospekt
    {'price': 420000.0, 'position': const LatLng(59.9156, 30.3481)}, // Near Volkovskaya
  ];

  static const _initialPosition = LatLng(59.9289, 30.3481); // Centered between all markers

  late final AnimationController _markerAnimationController;

  // Add this property to the _SearchPageState class
  MarkerState _currentMarkerState = MarkerState.price;

  @override
  void initState() {
    super.initState();
    _propertyState.addListener(_onStateChanged);
    _markerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _markerAnimationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _propertyState.removeListener(_onStateChanged);
    _markerAnimationController.dispose();
    super.dispose();
  }

  void _onStateChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mapBackground,
      body: Stack(
        children: [
          // Map takes up the full space
          GestureDetector(
            onTapDown: (_) {
              if (_showDirectionFilters || _showFilters) {
                setState(() {
                  _showDirectionFilters = false;
                  _showFilters = false;
                });
              }
            },
            child: FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: _initialPosition,
                initialZoom: 13,
                backgroundColor: AppTheme.mapBackground,
                maxZoom: 18,
                minZoom: 3,
                interactionOptions: InteractionOptions(
                  enableScrollWheel: false,
                  enableMultiFingerGestureRace: true,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/mapbox/dark-v11/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
                  additionalOptions: const {
                    'accessToken':
                        'pk.eyJ1IjoiYWRlaXphZGV2IiwiYSI6ImNtODA5MjRwdzBxcG4ycnM1MG1wZGVmenYifQ.7XH8LSwrleJr4VSvvpCF8w',
                  },
                  backgroundColor: AppTheme.mapBackground,
                ),
                MarkerLayer(
                  markers: _properties.map((property) {
                    return Marker(
                      width: 100,
                      height: 40,
                      point: property['position'] as LatLng,
                      alignment: Alignment.center,
                      child: PriceMarker(
                        price: property['price'] as double,
                        markerState: _currentMarkerState,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Search bar at top
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchBar(
                      onChanged: _propertyState.setSearchQuery,
                      onFilterTap: () {
                        setState(() {
                          _showFilters = !_showFilters;
                          if (_showFilters) {
                            _showDirectionFilters = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom buttons
          Positioned(
            left: 24,
            right: 24,
            bottom: 130,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        RippleIconButton(
                          icon: Icons.layers_outlined,
                          onPressed: () {
                            setState(() {
                              _showDirectionFilters = !_showDirectionFilters;
                              if (_showDirectionFilters) {
                                _showFilters = false;
                              }
                            });
                          },
                        ).animate().scaleXY(duration: 600.ms, begin: 0.1, end: 1.0),
                        const SizedBox(height: 16),
                        RippleIconButton(
                          icon: Icons.navigation_rounded,
                          onPressed: () {},
                        ).animate().scaleXY(duration: 600.ms, begin: 0.1, end: 1.0),
                      ],
                    ),
                    const Spacer(),
                    const ListOfVariantsButton().animate().scaleXY(duration: 600.ms, begin: 0.1, end: 1.0),
                  ],
                ),
              ],
            ),
          ),

          // Direction filters
          DirectionFiltersWidget(
            showDirectionFilters: _showDirectionFilters,
            selectedFilter: _currentMarkerState,
            onFilterSelected: (MarkerState state) {
              setState(() {
                _currentMarkerState = state;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FilterOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: AppTheme.grey),
          const SizedBox(width: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.grey,
                ),
          ),
        ],
      ),
    );
  }
}
