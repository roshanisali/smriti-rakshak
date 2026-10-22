
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  // Smriti Rakshak Home screen palette
  static const Color primary = Color(0xFFE0533C);
  static const Color primaryDark = Color(0xFFA6321F);
  static const Color gold = Color(0xFFF2A922);
  static const Color forest = Color(0xFF173D32);
  static const Color forestLight = Color(0xFF285746);
  static const Color background = Color(0xFFF0F4F8);
  static const Color sandstone = Color(0xFFE4D8C5);
  static const Color cream = Color(0xFFFAF5EB);
  static const Color ink = Color(0xFF0F172A);
  static const Color muted = Color(0xFF64748B);
  static const Color teal = Color(0xFF0EA5E9);
  static const Color green = Color(0xFF10B981);
  static const Color purple = Color(0xFF8063A6);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();

  String _selectedMood = '';
  String? _selectedPlace;

  final List<Map<String, dynamic>> _places = [
    {
      'name': 'Shaniwar Wada',
      'location': 'Pune, Maharashtra',
      'description': 'A legendary Maratha-era fortification in the heart of Pune.',
      'point': const LatLng(18.5196, 73.8553),
      'color': DiscoverScreen.primary,
      'icon': Icons.castle_rounded,
      'category': 'HISTORIC FORT',
    },
    {
      'name': 'Aga Khan Palace',
      'location': 'Pune, Maharashtra',
      'description': 'An architectural landmark connected with India’s freedom movement.',
      'point': const LatLng(18.5525, 73.9015),
      'color': DiscoverScreen.gold,
      'icon': Icons.account_balance_rounded,
      'category': 'HISTORIC LANDMARK',
    },
    {
      'name': 'Sinhagad Fort',
      'location': 'Pune, Maharashtra',
      'description': 'A hilltop fort known for its dramatic landscape and Maratha history.',
      'point': const LatLng(18.3663, 73.7559),
      'color': DiscoverScreen.green,
      'icon': Icons.terrain_rounded,
      'category': 'HILL FORT',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _goBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are already on the first page.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showInfo(
    String title,
    String description, {
    IconData icon = Icons.auto_stories_rounded,
  }) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: DiscoverScreen.cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: DiscoverScreen.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(
                  icon,
                  color: DiscoverScreen.primary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: const TextStyle(
                  color: DiscoverScreen.forest,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(
                  color: DiscoverScreen.muted,
                  fontSize: 14,
                  height: 1.65,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DiscoverScreen.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Continue Exploring',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchPlace(String value) {
    if (value.trim().isEmpty) return;

    final query = value.trim().toLowerCase();

    final matches = _places.where((place) {
      return place['name'].toString().toLowerCase().contains(query) ||
          place['location'].toString().toLowerCase().contains(query) ||
          place['category'].toString().toLowerCase().contains(query);
    });

    if (matches.isNotEmpty) {
      final place = matches.first;
      final point = place['point'] as LatLng;

      setState(() => _selectedPlace = place['name'].toString());

      _mapController.move(point, 14);
      FocusScope.of(context).unfocus();

      _showInfo(
        place['name'].toString(),
        place['description'].toString(),
        icon: place['icon'] as IconData,
      );
      return;
    }

    const suggestions = [
      'Bhaja Caves',
      'Lonar Crater',
      'Panhala Fort',
      'Red Fort',
      'Warli Art',
      'Paithani',
      'Lavani',
    ];

    final suggestion = suggestions.where(
      (item) => item.toLowerCase().contains(query),
    );

    FocusScope.of(context).unfocus();

    if (suggestion.isNotEmpty) {
      _showInfo(
        'Discover ${suggestion.first}',
        'This heritage interest is on our discovery list. Detailed location '
        'results will become available when a heritage database is connected.',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No matching results. Try another heritage name.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _selectMood(String mood) {
    setState(() {
      _selectedMood = _selectedMood == mood ? '' : mood;
    });

    if (_selectedMood.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your discovery theme: $_selectedMood'),
          backgroundColor: DiscoverScreen.forest,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showMap() {
    _mapController.move(const LatLng(18.5204, 73.8567), 11.5);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Explore Pune and tap a heritage marker.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _focusPlace(Map<String, dynamic> place) {
    setState(() => _selectedPlace = place['name'].toString());
    _mapController.move(place['point'] as LatLng, 14);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DiscoverScreen.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // HEADER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                child: Row(
                  children: [
                    _HeaderButton(
                      icon: Icons.arrow_back_rounded,
                      tooltip: 'Back',
                      onPressed: _goBack,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SMRITI RAKSHAK',
                            style: TextStyle(
                              color: DiscoverScreen.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.7,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Discover',
                            style: TextStyle(
                              color: DiscoverScreen.forest,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _HeaderButton(
                      icon: Icons.notifications_none_rounded,
                      tooltip: 'Notifications',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You are all caught up!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // INTRO
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(22, 0, 22, 16),
                child: Text(
                  'Every place has a story. Find the ones worth remembering.',
                  style: TextStyle(
                    color: DiscoverScreen.muted,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            // SEARCH
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: DiscoverScreen.sandstone,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: DiscoverScreen.forest.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.search_rounded,
                        color: DiscoverScreen.primary,
                        size: 23,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onSubmitted: _searchPlace,
                          textInputAction: TextInputAction.search,
                          style: const TextStyle(
                            color: DiscoverScreen.ink,
                            fontSize: 13,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Search forts, art, stories...',
                            hintStyle: TextStyle(
                              color: DiscoverScreen.muted,
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Search',
                        onPressed: () =>
                            _searchPlace(_searchController.text),
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: DiscoverScreen.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // HERO
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _HeroSection(
                  onTap: () => _showInfo(
                    'Beyond the Ordinary',
                    'Discover places, people and stories that shaped our heritage. '
                    'From ancient cave architecture to mighty hill forts, '
                    'every discovery brings the past closer.',
                    icon: Icons.explore_rounded,
                  ),
                ),
              ),
            ),

            // DISCOVERY STATS
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.castle_rounded,
                        number: '03',
                        label: 'Featured places',
                        color: DiscoverScreen.primary,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.palette_rounded,
                        number: '06',
                        label: 'Ways to explore',
                        color: DiscoverScreen.teal,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.auto_stories_rounded,
                        number: '∞',
                        label: 'Stories to discover',
                        color: DiscoverScreen.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // MOODS
            const SliverToBoxAdapter(
              child: SizedBox(height: 28),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _SectionHeader(
                  title: 'What inspires you?',
                  subtitle: 'Choose your discovery trail',
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 14),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 47,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _MoodChip(
                      icon: Icons.castle_rounded,
                      title: 'Forts',
                      color: DiscoverScreen.primary,
                      selected: _selectedMood == 'Forts',
                      onTap: () => _selectMood('Forts'),
                    ),
                    _MoodChip(
                      icon: Icons.account_balance_rounded,
                      title: 'Temples',
                      color: DiscoverScreen.gold,
                      selected: _selectedMood == 'Temples',
                      onTap: () => _selectMood('Temples'),
                    ),
                    _MoodChip(
                      icon: Icons.palette_rounded,
                      title: 'Art',
                      color: DiscoverScreen.purple,
                      selected: _selectedMood == 'Art',
                      onTap: () => _selectMood('Art'),
                    ),
                    _MoodChip(
                      icon: Icons.restaurant_rounded,
                      title: 'Food',
                      color: DiscoverScreen.green,
                      selected: _selectedMood == 'Food',
                      onTap: () => _selectMood('Food'),
                    ),
                    _MoodChip(
                      icon: Icons.handyman_rounded,
                      title: 'Crafts',
                      color: DiscoverScreen.teal,
                      selected: _selectedMood == 'Crafts',
                      onTap: () => _selectMood('Crafts'),
                    ),
                    _MoodChip(
                      icon: Icons.menu_book_rounded,
                      title: 'Stories',
                      color: DiscoverScreen.primaryDark,
                      selected: _selectedMood == 'Stories',
                      onTap: () => _selectMood('Stories'),
                    ),
                  ],
                ),
              ),
            ),

            // MAP SECTION
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _SectionHeader(
                  title: 'Heritage Around You',
                  subtitle: 'Explore historic landmarks in Pune',
                  actionText: 'Reset map',
                  onAction: _showMap,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 14),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _HeritageMap(
                  mapController: _mapController,
                  places: _places,
                  selectedPlace: _selectedPlace,
                  onMarkerTap: (place) {
                    _focusPlace(place);
                    _showInfo(
                      place['name'].toString(),
                      place['description'].toString(),
                      icon: place['icon'] as IconData,
                    );
                  },
                  onPlaceTap: _focusPlace,
                ),
              ),
            ),

            // PLACE QUICK SELECT
            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: _places.map((place) {
                    return _PlaceMiniCard(
                      place: place,
                      selected: _selectedPlace == place['name'],
                      onTap: () => _focusPlace(place),
                    );
                  }).toList(),
                ),
              ),
            ),

            // HIDDEN GEMS
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _SectionHeader(
                  title: 'Hidden Gems',
                  subtitle: 'Lesser-known wonders worth the journey',
                  actionText: 'Discover',
                  onAction: () => _showInfo(
                    'Hidden Gems',
                    'Explore ancient caves, forgotten forts and extraordinary '
                    'landscapes across Maharashtra.',
                    icon: Icons.explore_rounded,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 14),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 255,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _GemCard(
                      imagePath: 'assets/images/BhajaCaves.jpg',
                      title: 'Bhaja Caves',
                      location: 'Lonavala, Maharashtra',
                      category: 'ANCIENT',
                      icon: Icons.terrain_rounded,
                      onTap: () => _showInfo(
                        'Bhaja Caves',
                        'Explore ancient Buddhist rock-cut caves and their '
                        'distinctive architectural features near Lonavala.',
                      ),
                    ),
                    _GemCard(
                      imagePath: 'assets/images/LonarCrater.jpg',
                      title: 'Lonar Crater',
                      location: 'Buldhana, Maharashtra',
                      category: 'NATURAL WONDER',
                      icon: Icons.public_rounded,
                      onTap: () => _showInfo(
                        'Lonar Crater',
                        'Discover an extraordinary meteorite impact crater '
                        'and its distinctive geological landscape.',
                      ),
                    ),
                    _GemCard(
                      imagePath: 'assets/images/PanhalaFort.jpg',
                      title: 'Panhala Fort',
                      location: 'Kolhapur, Maharashtra',
                      category: 'HILL FORT',
                      icon: Icons.castle_rounded,
                      onTap: () => _showInfo(
                        'Panhala Fort',
                        'Explore a historic hill fort with sweeping views '
                        'and an important place in Maratha history.',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // STORY SECTION
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _SectionHeader(
                  title: 'Stories That Survived',
                  subtitle: 'The people, ideas and art behind our past',
                  actionText: 'Explore',
                  onAction: () => _showInfo(
                    'Heritage Stories',
                    'Travel beyond dates and monuments. Discover the traditions, '
                    'craftsmanship and events that shaped our cultural identity.',
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 14),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 225,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _StoryCard(
                      imagePath: 'assets/images/Caves.jpg',
                      title: 'The Stories Behind Ancient Caves',
                      category: 'HISTORY',
                      subtitle: 'Stone, skill and centuries of stories.',
                      onTap: () => _showInfo(
                        'Ancient Caves',
                        'Explore rock-cut architecture, craftsmanship and '
                        'the history preserved in ancient caves.',
                      ),
                    ),
                    _StoryCard(
                      imagePath: 'assets/images/Art.jpg',
                      title: 'Art That Carries a Legacy',
                      category: 'CULTURE',
                      subtitle: 'Traditions passed from one generation to another.',
                      onTap: () => _showInfo(
                        'Art That Carries a Legacy',
                        'Discover traditional art forms and the communities '
                        'working to keep them alive.',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // TIMELINE
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _SectionHeader(
                  title: 'Travel Through Time',
                  subtitle: 'Every era leaves its mark',
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 14),
            ),
            const SliverToBoxAdapter(
              child: _Timeline(),
            ),

            // CULTURE
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _CultureBanner(
                  onTap: () => _showInfo(
                    'Living Culture',
                    'Meet the traditions, artists, crafts and celebrations '
                    'that keep our heritage alive today.',
                    icon: Icons.palette_rounded,
                  ),
                ),
              ),
            ),

            // CAMERA
            const SliverToBoxAdapter(
              child: SizedBox(height: 14),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _CameraBanner(
                  onTap: () => _showInfo(
                    'Heritage Through Your Lens',
                    'Capture and share photographs of heritage places. '
                    'Camera uploads can be connected in a future update.',
                    icon: Icons.camera_alt_rounded,
                  ),
                ),
              ),
            ),

            // FOOTER
            const SliverToBoxAdapter(
              child: SizedBox(height: 28),
            ),
            const SliverToBoxAdapter(
              child: _Footer(),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// HEADER BUTTON
// ============================================================================

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _HeaderButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: DiscoverScreen.sandstone),
          ),
          child: Tooltip(
            message: tooltip,
            child: Icon(icon, color: DiscoverScreen.forest, size: 21),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION HEADER
// ============================================================================

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onAction;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.6,
                  color: DiscoverScreen.forest,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.45,
                  color: DiscoverScreen.muted,
                ),
              ),
            ],
          ),
        ),
        if (actionText != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: DiscoverScreen.primary,
              padding: const EdgeInsets.only(left: 6, bottom: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionText!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(Icons.arrow_forward_rounded, size: 14),
              ],
            ),
          ),
      ],
    );
  }
}

// ============================================================================
// HERO
// ============================================================================

class _HeroSection extends StatelessWidget {
  final VoidCallback onTap;

  const _HeroSection({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: DiscoverScreen.forest,
        borderRadius: BorderRadius.circular(27),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/RedFort.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: DiscoverScreen.forest,
                  child: const Icon(
                    Icons.castle_rounded,
                    size: 90,
                    color: DiscoverScreen.gold,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      DiscoverScreen.forest.withValues(alpha: 0.05),
                      DiscoverScreen.forest.withValues(alpha: 0.36),
                      DiscoverScreen.forest.withValues(alpha: 0.97),
                    ],
                    stops: const [0, 0.38, 1],
                  ),
                ),
              ),
              Positioned(
                top: 17,
                left: 17,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: DiscoverScreen.cream,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: DiscoverScreen.primary,
                        size: 14,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'YOUR NEXT DISCOVERY',
                        style: TextStyle(
                          color: DiscoverScreen.forest,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 21,
                right: 21,
                bottom: 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: DiscoverScreen.gold,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'EXPLORE THE UNFORGOTTEN',
                        style: TextStyle(
                          color: DiscoverScreen.forest,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Beyond the\nOrdinary.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        height: 1.03,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.2,
                      ),
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      'Discover places, people and stories that shaped our heritage.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: DiscoverScreen.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'START EXPLORING',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.6,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// STAT CARDS
// ============================================================================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String number;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.number,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 13, 8, 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: DiscoverScreen.sandstone),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            number,
            style: const TextStyle(
              color: DiscoverScreen.forest,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 2,
            style: const TextStyle(
              color: DiscoverScreen.muted,
              fontSize: 9,
              height: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// MOOD CHIP
// ============================================================================

class _MoodChip extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _MoodChip({
    required this.icon,
    required this.title,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 9),
      decoration: BoxDecoration(
        color: selected ? color : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? color : DiscoverScreen.sandstone,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 17,
                  color: selected ? Colors.white : color,
                ),
                const SizedBox(width: 7),
                Text(
                  title,
                  style: TextStyle(
                    color: selected ? Colors.white : DiscoverScreen.forest,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HERITAGE MAP
// ============================================================================

class _HeritageMap extends StatelessWidget {
  final MapController mapController;
  final List<Map<String, dynamic>> places;
  final String? selectedPlace;
  final ValueChanged<Map<String, dynamic>> onMarkerTap;
  final ValueChanged<Map<String, dynamic>> onPlaceTap;

  const _HeritageMap({
    required this.mapController,
    required this.places,
    required this.selectedPlace,
    required this.onMarkerTap,
    required this.onPlaceTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = places.firstWhere(
      (place) => place['name'] == selectedPlace,
      orElse: () => places.first,
    );

    return Container(
      height: 365,
      decoration: BoxDecoration(
        color: DiscoverScreen.forest,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.13),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              mapController: mapController,
              options: const MapOptions(
                initialCenter: LatLng(18.5204, 73.8567),
                initialZoom: 11.5,
                minZoom: 5,
                maxZoom: 18,
                interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.smritirakshak.app',
                ),
                MarkerLayer(
                  markers: places.map((place) {
                    final isSelected = place['name'] == selectedPlace;

                    return Marker(
                      point: place['point'] as LatLng,
                      width: 60,
                      height: 65,
                      child: GestureDetector(
                        onTap: () => onMarkerTap(place),
                        child: _MapPin(
                          color: place['color'] as Color,
                          icon: place['icon'] as IconData,
                          selected: isSelected,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Map heading
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: DiscoverScreen.forest,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.explore_rounded,
                          color: DiscoverScreen.gold,
                          size: 19,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'THE HERITAGE MAP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.6,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Pune, Maharashtra',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: DiscoverScreen.primary,
                  borderRadius: BorderRadius.circular(13),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(13),
                    onTap: () {
                      mapController.move(
                        const LatLng(18.5204, 73.8567),
                        11.5,
                      );
                    },
                    child: const SizedBox(
                      height: 46,
                      width: 46,
                      child: Icon(
                        Icons.center_focus_strong_rounded,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Zoom controls
          Positioned(
            right: 12,
            top: 75,
            child: Column(
              children: [
                _MapControl(
                  icon: Icons.add_rounded,
                  tooltip: 'Zoom in',
                  onTap: () {
                    final camera = mapController.camera;
                    mapController.move(
                      camera.center,
                      (camera.zoom + 1).clamp(5.0, 18.0),
                    );
                  },
                ),
                const SizedBox(height: 7),
                _MapControl(
                  icon: Icons.remove_rounded,
                  tooltip: 'Zoom out',
                  onTap: () {
                    final camera = mapController.camera;
                    mapController.move(
                      camera.center,
                      (camera.zoom - 1).clamp(5.0, 18.0),
                    );
                  },
                ),
              ],
            ),
          ),

          // Selected place preview
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Material(
              color: DiscoverScreen.cream,
              borderRadius: BorderRadius.circular(19),
              child: InkWell(
                borderRadius: BorderRadius.circular(19),
                onTap: () => onPlaceTap(selected),
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Row(
                    children: [
                      Container(
                        height: 49,
                        width: 49,
                        decoration: BoxDecoration(
                          color: (selected['color'] as Color)
                              .withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          selected['icon'] as IconData,
                          color: selected['color'] as Color,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selected['category'].toString(),
                              style: const TextStyle(
                                color: DiscoverScreen.primary,
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.7,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selected['name'].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: DiscoverScreen.forest,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              selected['location'].toString(),
                              style: const TextStyle(
                                color: DiscoverScreen.muted,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: DiscoverScreen.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapControl extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _MapControl({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(11),
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: onTap,
        child: SizedBox(
          height: 38,
          width: 38,
          child: Tooltip(
            message: tooltip,
            child: Icon(
              icon,
              color: DiscoverScreen.forest,
              size: 21,
            ),
          ),
        ),
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  final Color color;
  final IconData icon;
  final bool selected;

  const _MapPin({
    required this.color,
    required this.icon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: selected ? 43 : 37,
          height: selected ? 43 : 37,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: selected ? 3.5 : 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.35),
                blurRadius: selected ? 12 : 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: selected ? 21 : 18,
          ),
        ),
        Container(
          height: 7,
          width: 7,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.3),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// MAP QUICK SELECT
// ============================================================================

class _PlaceMiniCard extends StatelessWidget {
  final Map<String, dynamic> place;
  final bool selected;
  final VoidCallback onTap;

  const _PlaceMiniCard({
    required this.place,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = place['color'] as Color;

    return Container(
      width: 205,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: selected ? DiscoverScreen.cream : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? color : DiscoverScreen.sandstone,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              children: [
                Container(
                  width: 39,
                  height: 39,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.13),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    place['icon'] as IconData,
                    color: color,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place['name'].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: DiscoverScreen.forest,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        place['category'].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: DiscoverScreen.muted,
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HIDDEN GEM CARDS
// ============================================================================

class _GemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String category;
  final IconData icon;
  final VoidCallback onTap;

  const _GemCard({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.category,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      margin: const EdgeInsets.only(right: 13, bottom: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: DiscoverScreen.sandstone),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: DiscoverScreen.sandstone,
                        child: Center(
                          child: Icon(
                            icon,
                            color: DiscoverScreen.forest,
                            size: 54,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 11,
                      left: 11,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: DiscoverScreen.cream,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: DiscoverScreen.forest,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 11, 13, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: DiscoverScreen.forest,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: DiscoverScreen.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: DiscoverScreen.muted,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: DiscoverScreen.primary,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// STORY CARDS
// ============================================================================

class _StoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String category;
  final String subtitle;
  final VoidCallback onTap;

  const _StoryCard({
    required this.imagePath,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285,
      margin: const EdgeInsets.only(right: 13, bottom: 3),
      decoration: BoxDecoration(
        color: DiscoverScreen.forest,
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: DiscoverScreen.forestLight,
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: DiscoverScreen.gold,
                    size: 55,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      DiscoverScreen.forest.withValues(alpha: 0.02),
                      DiscoverScreen.forest.withValues(alpha: 0.36),
                      DiscoverScreen.forest.withValues(alpha: 0.98),
                    ],
                    stops: const [0, 0.4, 1],
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: DiscoverScreen.gold,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: DiscoverScreen.forest,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        height: 1.2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 9),
                    const Row(
                      children: [
                        Text(
                          'READ THE STORY',
                          style: TextStyle(
                            color: DiscoverScreen.gold,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.7,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: DiscoverScreen.gold,
                          size: 13,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HISTORICAL TIMELINE
// ============================================================================

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        children: const [
          _EraItem(
            year: 'ANCIENT',
            title: 'Caves & Temples',
            description: 'Architecture and early civilizations',
            color: DiscoverScreen.gold,
            icon: Icons.account_balance_rounded,
          ),
          _EraItem(
            year: 'MEDIEVAL',
            title: 'Kingdoms & Forts',
            description: 'Dynasties, battles and legacies',
            color: DiscoverScreen.primary,
            icon: Icons.castle_rounded,
          ),
          _EraItem(
            year: 'COLONIAL',
            title: 'Changing India',
            description: 'Movements and transformation',
            color: DiscoverScreen.teal,
            icon: Icons.history_edu_rounded,
          ),
          _EraItem(
            year: 'MODERN',
            title: 'Living Heritage',
            description: 'Culture carried into today',
            color: DiscoverScreen.green,
            icon: Icons.people_alt_rounded,
          ),
        ],
      ),
    );
  }
}

class _EraItem extends StatelessWidget {
  final String year;
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  const _EraItem({
    required this.year,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12, bottom: 3),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: DiscoverScreen.sandstone),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 21),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  year,
                  style: TextStyle(
                    color: color == DiscoverScreen.gold
                        ? DiscoverScreen.primaryDark
                        : color,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: DiscoverScreen.forest,
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            maxLines: 2,
            style: const TextStyle(
              color: DiscoverScreen.muted,
              fontSize: 10,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CULTURE BANNER
// ============================================================================

class _CultureBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _CultureBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.13),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Material(
        color: DiscoverScreen.forest,
        borderRadius: BorderRadius.circular(25),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/culture.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: DiscoverScreen.forestLight,
                  child: const Icon(
                    Icons.palette_rounded,
                    color: DiscoverScreen.gold,
                    size: 65,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      DiscoverScreen.forest.withValues(alpha: 0.98),
                      DiscoverScreen.forest.withValues(alpha: 0.83),
                      DiscoverScreen.forest.withValues(alpha: 0.12),
                    ],
                    stops: const [0, 0.66, 1],
                  ),
                ),
              ),
              const Positioned(
                left: 21,
                top: 20,
                bottom: 20,
                right: 54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OUR ROOTS, OUR STORIES',
                      style: TextStyle(
                        color: DiscoverScreen.gold,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 11),
                    Text(
                      'Living Culture',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Meet the artists, traditions and crafts that keep our heritage alive.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 13),
                    Row(
                      children: [
                        Text(
                          'EXPLORE CULTURE',
                          style: TextStyle(
                            color: DiscoverScreen.gold,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.6,
                          ),
                        ),
                        SizedBox(width: 7),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: DiscoverScreen.gold,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// CAMERA BANNER
// ============================================================================

class _CameraBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _CameraBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DiscoverScreen.forest,
      borderRadius: BorderRadius.circular(23),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 155,
          child: Stack(
            children: [
              Positioned(
                right: -5,
                top: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/images/camera_banner.jpg',
                  width: 155,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(
                    width: 155,
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 65,
                      color: DiscoverScreen.gold,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        DiscoverScreen.forest,
                        DiscoverScreen.forest.withValues(alpha: 0.97),
                        DiscoverScreen.forest.withValues(alpha: 0),
                      ],
                      stops: const [0, 0.67, 1],
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 19,
                top: 18,
                bottom: 18,
                right: 105,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      color: DiscoverScreen.gold,
                      size: 24,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Heritage Through Your Lens',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Capture. Share. Preserve.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// FOOTER
// ============================================================================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 23, 20, 25),
      decoration: const BoxDecoration(
        color: DiscoverScreen.forest,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.account_balance_rounded,
            color: DiscoverScreen.gold,
            size: 28,
          ),
          SizedBox(height: 8),
          Text(
            'SMRITI RAKSHAK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.8,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Discover • Experience • Preserve',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Keeping our stories alive for generations to come.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: DiscoverScreen.gold,
              fontSize: 10,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
