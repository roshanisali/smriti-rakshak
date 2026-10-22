
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ============================================================
  // THEME
  // ============================================================

  static const Color primary = Color(0xFFC6533B);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE6B85C);
  static const Color background = Color(0xFFF7F2E8);
  static const Color surface = Color(0xFFFFFCF6);
  static const Color textColor = Color(0xFF29352C);
  static const Color secondaryText = Color(0xFF77786C);
  static const Color forest = Color(0xFF294536);
  static const Color forestLight = Color(0xFF42634B);
  static const Color sandstone = Color(0xFFE8DDC9);
  static const Color mapBlue = Color(0xFF3986B7);

  static const LatLng puneCenter = LatLng(18.5204, 73.8567);
  static const LatLng shaniwarWada = LatLng(18.5196, 73.8553);
  static const LatLng agaKhanPalace = LatLng(18.5520, 73.9017);
  static const LatLng sinhagad = LatLng(18.3663, 73.7559);

  // ============================================================
  // CONTROLLERS AND STATE
  // ============================================================

  final MapController _mapController = MapController();
  final TextEditingController _searchController =
      TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  LatLng? userLocation;
  LatLng? searchedLocation;
  String? searchedPlaceName;
  String? searchMessage;
  String? locationError;

  _HeritagePlace? selectedPlace;

  bool locationLoading = false;
  bool searchLoading = false;
  bool mapReady = false;

  String locationMessage = 'Discover the stories around you';

  // ============================================================
  // HERITAGE PLACES
  // ============================================================

  final List<_HeritagePlace> places = const [
    _HeritagePlace(
      name: 'Shaniwar Wada',
      subtitle: 'The legacy of the Peshwas',
      distance: '4.2 km',
      location: shaniwarWada,
      icon: Icons.account_balance_rounded,
      color: primary,
      category: 'HISTORIC FORT',
    ),
    _HeritagePlace(
      name: 'Aga Khan Palace',
      subtitle: 'A landmark of India’s freedom',
      distance: '7.8 km',
      location: agaKhanPalace,
      icon: Icons.museum_rounded,
      color: gold,
      category: 'PALACE & MEMORIAL',
    ),
    _HeritagePlace(
      name: 'Sinhagad Fort',
      subtitle: 'A hill fort above the clouds',
      distance: '18 km',
      location: sinhagad,
      icon: Icons.landscape_rounded,
      color: forestLight,
      category: 'HILL FORT',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _mapController.dispose();
    super.dispose();
  }

  // ============================================================
  // MAP MOVEMENT
  // ============================================================

  void _moveMap(LatLng location, double zoom) {
    if (!mapReady || !mounted) return;

    _mapController.move(location, zoom);
  }

  // ============================================================
  // CURRENT LOCATION
  // ============================================================

  Future<void> _getUserLocation() async {
    if (locationLoading || !mounted) return;

    setState(() {
      locationLoading = true;
      locationError = null;
      locationMessage = 'Finding your location...';
    });

    try {
      final serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        _setLocationError(
          'Turn on location services and try again.',
        );
        return;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        _setLocationError(
          'Location permission was denied.',
        );
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        _setLocationError(
          'Allow location access in your device settings.',
        );
        return;
      }

      final Position position =
          await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (!mounted) return;

      final location = LatLng(
        position.latitude,
        position.longitude,
      );

      setState(() {
        userLocation = location;
        locationLoading = false;
        locationError = null;
        locationMessage = 'Exploring from your current location';
      });

      _moveMap(location, 15);
    } catch (_) {
      _setLocationError(
        'Could not get your location. Please try again.',
      );
    }
  }

  void _setLocationError(String message) {
    if (!mounted) return;

    setState(() {
      locationLoading = false;
      locationError = message;
      locationMessage = message;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: forest,
        ),
      );
  }

  // ============================================================
  // PLACE SEARCH
  // ============================================================

  Future<void> _searchPlace() async {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        searchMessage =
            'Enter a fort, monument, or city to search.';
      });
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      searchLoading = true;
      searchMessage = null;
    });

    try {
      final Uri url = Uri.https(
        'nominatim.openstreetmap.org',
        '/search',
        {
          'q': query,
          'format': 'jsonv2',
          'limit': '1',
          'addressdetails': '1',
        },
      );

      final response = await http
          .get(
            url,
            headers: const {
              'User-Agent': 'SmritiRakshak/1.0',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Place search failed.');
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! List || decoded.isEmpty) {
        if (!mounted) return;

        setState(() {
          searchLoading = false;
          searchMessage =
              'No place found. Try a different search.';
        });
        return;
      }

      final result = decoded.first as Map<String, dynamic>;

      final latitude = double.tryParse(
        result['lat']?.toString() ?? '',
      );

      final longitude = double.tryParse(
        result['lon']?.toString() ?? '',
      );

      if (latitude == null || longitude == null) {
        throw Exception('Invalid coordinates.');
      }

      final location = LatLng(latitude, longitude);
      final displayName =
          result['display_name']?.toString() ?? query;

      if (!mounted) return;

      setState(() {
        searchedLocation = location;
        searchedPlaceName = displayName;
        searchLoading = false;
        searchMessage = null;
        locationError = null;
        selectedPlace = null;
        locationMessage = 'Showing search results';
      });

      _moveMap(location, 15);
    } catch (_) {
      if (!mounted) return;

      setState(() {
        searchLoading = false;
        searchMessage =
            'Search failed. Check your internet connection.';
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();

    setState(() {
      searchedLocation = null;
      searchedPlaceName = null;
      searchMessage = null;
      selectedPlace = null;
      locationMessage = 'Discover the stories around you';
    });

    _searchFocusNode.unfocus();
    _moveMap(puneCenter, 12);
  }

  // ============================================================
  // PLACE DETAILS
  // ============================================================

  void _showPlaceDetails(_HeritagePlace place) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
          decoration: const BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: sandstone,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: gold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      place.category,
                      style: const TextStyle(
                        color: forest,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: place.color.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Icon(
                          place.icon,
                          color: place.color,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              place.subtitle,
                              style: const TextStyle(
                                color: secondaryText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: primary,
                          size: 21,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${place.distance} from the listed reference point',
                            style: const TextStyle(
                              color: textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);

                        setState(() {
                          selectedPlace = place;
                          searchedLocation = null;
                          searchedPlaceName = null;
                          locationMessage =
                              'Exploring ${place.name}';
                        });

                        _moveMap(place.location, 15);
                      },
                      icon: const Icon(Icons.explore_rounded),
                      label: const Text('Explore on map'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: forest,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // MAIN SCREEN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth >= 1000;
    final isTablet = screenWidth >= 650 && screenWidth < 1000;

    return Container(
      color: background,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(isDesktop),
            _buildSearchBar(isDesktop),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  isDesktop ? 30 : 14,
                  4,
                  isDesktop ? 30 : 14,
                  14,
                ),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 7,
                            child: _buildMap(),
                          ),
                          const SizedBox(width: 22),
                          Expanded(
                            flex: 3,
                            child: _buildDesktopNearbyPanel(),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(child: _buildMap()),
                          const SizedBox(height: 14),
                          _buildMobileNearbyPanel(isTablet),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 32 : 20,
        20,
        isDesktop ? 32 : 20,
        18,
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Go back',
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: forest,
              size: 25,
            ),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('You are already on the main screen.'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              }
            },
          ),
          const SizedBox(width: 4),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [primary, primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.explore_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heritage Explorer',
                  style: TextStyle(
                    color: forest,
                    fontSize: isDesktop ? 29 : 23,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  locationMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: secondaryText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: sandstone),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.public_rounded,
                    color: forest,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Pune, Maharashtra',
                    style: TextStyle(
                      color: forest,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 32 : 20,
        0,
        isDesktop ? 32 : 20,
        17,
      ),
      child: Column(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: sandstone),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: primary,
                  size: 23,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    textInputAction: TextInputAction.search,
                    onChanged: (_) => setState(() {}),
                    onSubmitted: (_) => _searchPlace(),
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 13,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search forts, monuments, cities...',
                      hintStyle: TextStyle(
                        color: secondaryText,
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    tooltip: 'Clear search',
                    onPressed: _clearSearch,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: secondaryText,
                      size: 18,
                    ),
                  ),
                const SizedBox(width: 4),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: searchLoading ? null : _searchPlace,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: searchLoading
                        ? const SizedBox(
                            width: 17,
                            height: 17,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          if (searchMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  searchMessage!,
                  style: const TextStyle(
                    color: primaryDark,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // MAP
  // ============================================================

  Widget _buildMap() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          color: sandstone,
          border: Border.all(color: sandstone),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: puneCenter,
                initialZoom: 12,
                minZoom: 3,
                maxZoom: 19,
                onMapReady: () {
                  if (!mounted) return;

                  setState(() {
                    mapReady = true;
                  });
                },
                onTap: (_, __) {
                  _searchFocusNode.unfocus();
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.smritirakshak.app',
                ),
                MarkerLayer(
                  markers: [
                    ...places.map(
                      (place) => Marker(
                        point: place.location,
                        width: 120,
                        height: 85,
                        child: _MapMarker(
                          place: place,
                          selected:
                              selectedPlace?.name == place.name,
                          onTap: () {
                            setState(() {
                              selectedPlace = place;
                              searchedLocation = null;
                              searchedPlaceName = null;
                              locationMessage =
                                  'Exploring ${place.name}';
                            });

                            _moveMap(place.location, 15);
                            _showPlaceDetails(place);
                          },
                        ),
                      ),
                    ),
                    if (searchedLocation != null)
                      Marker(
                        point: searchedLocation!,
                        width: 160,
                        height: 90,
                        child: _SearchMarker(
                          name: searchedPlaceName ?? 'Search result',
                        ),
                      ),
                    if (userLocation != null)
                      Marker(
                        point: userLocation!,
                        width: 44,
                        height: 44,
                        child: const _CurrentLocationMarker(),
                      ),
                  ],
                ),
              ],
            ),

            // MAP LOCATION LABEL
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: surface.withOpacity(0.97),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: sandstone),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: primary,
                      size: 17,
                    ),
                    SizedBox(width: 7),
                    Text(
                      'Pune, Maharashtra',
                      style: TextStyle(
                        fontSize: 11,
                        color: forest,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ZOOM CONTROLS
            Positioned(
              right: 14,
              top: 14,
              child: Column(
                children: [
                  _MapControl(
                    icon: Icons.add_rounded,
                    tooltip: 'Zoom in',
                    onTap: () {
                      if (!mapReady) return;

                      final zoom = (_mapController.camera.zoom + 1)
                          .clamp(3.0, 19.0)
                          .toDouble();

                      _mapController.move(
                        _mapController.camera.center,
                        zoom,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _MapControl(
                    icon: Icons.remove_rounded,
                    tooltip: 'Zoom out',
                    onTap: () {
                      if (!mapReady) return;

                      final zoom = (_mapController.camera.zoom - 1)
                          .clamp(3.0, 19.0)
                          .toDouble();

                      _mapController.move(
                        _mapController.camera.center,
                        zoom,
                      );
                    },
                  ),
                ],
              ),
            ),

            // CURRENT LOCATION CONTROL
            Positioned(
              right: 14,
              bottom: 14,
              child: _MapControl(
                icon: Icons.my_location_rounded,
                tooltip: 'My location',
                onTap: _getUserLocation,
                color: forest,
                iconColor: Colors.white,
                loading: locationLoading,
              ),
            ),

            // LOCATION ERROR
            if (locationError != null)
              Positioned(
                left: 12,
                right: 66,
                bottom: 14,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: surface.withOpacity(0.97),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: sandstone),
                  ),
                  child: Text(
                    locationError!,
                    style: const TextStyle(
                      color: primaryDark,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP NEARBY PANEL
  // ============================================================

  Widget _buildDesktopNearbyPanel() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: sandstone),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Discover heritage',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: forest,
                  ),
                ),
              ),
              Text(
                '${places.length} places',
                style: const TextStyle(
                  color: secondaryText,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const Text(
            'Every landmark holds a story worth discovering.',
            style: TextStyle(
              color: secondaryText,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.separated(
              itemCount: places.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final place = places[index];

                return _NearbyPlaceCard(
                  place: place,
                  selected: selectedPlace?.name == place.name,
                  onTap: () {
                    setState(() {
                      selectedPlace = place;
                      searchedLocation = null;
                      searchedPlaceName = null;
                      locationMessage = 'Exploring ${place.name}';
                    });

                    _moveMap(place.location, 15);
                  },
                  onDetails: () => _showPlaceDetails(place),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.auto_stories_rounded,
                  color: primary,
                  size: 21,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tap a marker or landmark card to explore its location and details.',
                    style: TextStyle(
                      color: forest,
                      fontSize: 11,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE AND TABLET NEARBY PANEL
  // ============================================================

  Widget _buildMobileNearbyPanel(bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: sandstone),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Explore nearby',
                  style: TextStyle(
                    color: forest,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Icon(
                Icons.explore_outlined,
                color: primary,
                size: 17,
              ),
              const SizedBox(width: 6),
              Text(
                '${places.length} places',
                style: const TextStyle(
                  color: secondaryText,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: isTablet ? 153 : 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: places.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final place = places[index];

                return _NearbyHorizontalCard(
                  place: place,
                  selected: selectedPlace?.name == place.name,
                  onTap: () {
                    setState(() {
                      selectedPlace = place;
                      searchedLocation = null;
                      searchedPlaceName = null;
                      locationMessage = 'Exploring ${place.name}';
                    });

                    _moveMap(place.location, 15);
                  },
                  onDetails: () => _showPlaceDetails(place),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HERITAGE PLACE MODEL
// ============================================================

class _HeritagePlace {
  final String name;
  final String subtitle;
  final String distance;
  final LatLng location;
  final IconData icon;
  final Color color;
  final String category;

  const _HeritagePlace({
    required this.name,
    required this.subtitle,
    required this.distance,
    required this.location,
    required this.icon,
    required this.color,
    required this.category,
  });
}

// ============================================================
// MAP MARKER
// ============================================================

class _MapMarker extends StatelessWidget {
  final _HeritagePlace place;
  final bool selected;
  final VoidCallback onTap;

  const _MapMarker({
    required this.place,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: selected ? 49 : 43,
            height: selected ? 49 : 43,
            decoration: BoxDecoration(
              color: place.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFFFCF6),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: place.color.withOpacity(0.3),
                  blurRadius: selected ? 15 : 9,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              place.icon,
              color: Colors.white,
              size: selected ? 24 : 21,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFCF6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _MapScreenColors.sandstone,
              ),
              boxShadow: [
                BoxShadow(
                  color: _MapScreenColors.forest.withOpacity(0.12),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Text(
              place.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _MapScreenColors.forest,
                fontSize: 9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SEARCH RESULT MARKER
// ============================================================

class _SearchMarker extends StatelessWidget {
  final String name;

  const _SearchMarker({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: _MapScreenColors.mapBlue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: _MapScreenColors.forest.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.search_rounded,
            color: Colors.white,
            size: 21,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: _MapScreenColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _MapScreenColors.sandstone,
            ),
          ),
          child: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _MapScreenColors.forest,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// CURRENT LOCATION MARKER
// ============================================================

class _CurrentLocationMarker extends StatelessWidget {
  const _CurrentLocationMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _MapScreenColors.mapBlue.withOpacity(0.18),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(7),
      child: Container(
        decoration: BoxDecoration(
          color: _MapScreenColors.mapBlue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
      ),
    );
  }
}

// ============================================================
// MAP CONTROL
// ============================================================

class _MapControl extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color color;
  final Color iconColor;
  final bool loading;

  const _MapControl({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.color = const Color(0xFFFFFCF6),
    this.iconColor = const Color(0xFF294536),
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 3,
      shadowColor: _MapScreenColors.forest.withOpacity(0.15),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: loading ? null : onTap,
        borderRadius: BorderRadius.circular(14),
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: loading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: iconColor,
                      ),
                    )
                  : Icon(
                      icon,
                      color: iconColor,
                      size: 21,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DESKTOP PLACE CARD
// ============================================================

class _NearbyPlaceCard extends StatelessWidget {
  final _HeritagePlace place;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onDetails;

  const _NearbyPlaceCard({
    required this.place,
    required this.selected,
    required this.onTap,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? const Color(0xFFF3E8D9)
          : _MapScreenColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? _MapScreenColors.primary
                  : _MapScreenColors.sandstone,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 58,
                decoration: BoxDecoration(
                  color: place.color.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  place.icon,
                  color: place.color,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _MapScreenColors.forest,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      place.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _MapScreenColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: _MapScreenColors.primary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          place.distance,
                          style: const TextStyle(
                            color: _MapScreenColors.textColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'View details',
                onPressed: onDetails,
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: _MapScreenColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// MOBILE PLACE CARD
// ============================================================

class _NearbyHorizontalCard extends StatelessWidget {
  final _HeritagePlace place;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onDetails;

  const _NearbyHorizontalCard({
    required this.place,
    required this.selected,
    required this.onTap,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 245,
      child: Material(
        color: selected
            ? const Color(0xFFF3E8D9)
            : _MapScreenColors.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected
                    ? _MapScreenColors.primary
                    : _MapScreenColors.sandstone,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: place.color.withOpacity(0.13),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        place.icon,
                        color: place.color,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      tooltip: 'View details',
                      onPressed: onDetails,
                      icon: const Icon(
                        Icons.arrow_outward_rounded,
                        color: _MapScreenColors.primary,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  place.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _MapScreenColors.forest,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  place.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _MapScreenColors.secondaryText,
                    fontSize: 10,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: _MapScreenColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      place.distance,
                      style: const TextStyle(
                        color: _MapScreenColors.textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    if (selected)
                      const Icon(
                        Icons.check_circle_rounded,
                        color: _MapScreenColors.primary,
                        size: 16,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SHARED COLOURS FOR HELPER WIDGETS
// ============================================================

class _MapScreenColors {
  static const Color primary = Color(0xFFC6533B);
  static const Color background = Color(0xFFF7F2E8);
  static const Color surface = Color(0xFFFFFCF6);
  static const Color textColor = Color(0xFF29352C);
  static const Color secondaryText = Color(0xFF77786C);
  static const Color forest = Color(0xFF294536);
  static const Color sandstone = Color(0xFFE8DDC9);
  static const Color mapBlue = Color(0xFF3986B7);
}
