// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:moniepoint_assessment/core/theme/app_theme.dart';
// import 'package:moniepoint_assessment/core/constants/map_styles.dart';
// import 'package:moniepoint_assessment/features/search/domain/models/location_marker.dart';
// import 'package:moniepoint_assessment/features/search/presentation/widgets/search_bar.dart';
// import 'package:moniepoint_assessment/features/search/presentation/widgets/map_control_buttons.dart';
// import 'package:moniepoint_assessment/features/search/presentation/widgets/list_variants_button.dart';


// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   late GoogleMapController _mapController;
//   final TextEditingController _searchController = TextEditingController();
//   final Set<Marker> _markers = {};
//   bool _showFilters = false;

//   static const CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(59.9311, 30.3609), // Saint Petersburg coordinates
//     zoom: 12,
//   );

//   final List<LocationMarker> _locations = [
//     const LocationMarker(
//       id: '1',
//       title: 'Location 1',
//       position: LatLng(59.9311, 30.3609),
//     ),
//     const LocationMarker(
//       id: '2',
//       title: 'Location 2',
//       position: LatLng(59.9400, 30.3150),
//     ),
//     const LocationMarker(
//       id: '3',
//       title: 'Location 3',
//       position: LatLng(59.9200, 30.3300),
//     ),
//     const LocationMarker(
//       id: '4',
//       title: 'Location 4',
//       position: LatLng(59.9350, 30.3850),
//     ),
//     const LocationMarker(
//       id: '5',
//       title: 'Location 5',
//       position: LatLng(59.9250, 30.3450),
//     ),
//     const LocationMarker(
//       id: '6',
//       title: 'Location 6',
//       position: LatLng(59.9150, 30.3200),
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _initializeMarkers();
//   }

//   void _initializeMarkers() {
//     _markers.addAll(
//       _locations.map(
//         (location) => Marker(
//           markerId: MarkerId(location.id),
//           position: location.position,
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
//           onTap: () {
//             // Handle marker tap
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//     _setMapStyle();
//   }

//   Future<void> _setMapStyle() async {
//     await _mapController.setMapStyle(MapStyles.darkMode);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.mapBackground,
//       body: Stack(
//         children: [
//           // Map Layer
//           GoogleMap(
//             initialCameraPosition: _initialPosition,
//             onMapCreated: _onMapCreated,
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             mapType: MapType.normal,
//             markers: _markers,
//           ),

//           // Search Bar Layer
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: CustomSearchBar(
//                 searchController: _searchController,
//                 showFilters: _showFilters,
//                 onFilterTap: () => setState(() => _showFilters = !_showFilters),
//               ),
//             ),
//           ),

//           // Bottom Controls Layer
//           Positioned(
//             left: 16,
//             right: 16,
//             bottom: 24,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     MapControlButtons(
//                       onLayersTap: () {},
//                       onNavigationTap: () {},
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 ListVariantsButton(onTap: () {}),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
