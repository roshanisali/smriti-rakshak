
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  static const Color primary = Color(0xFFC94F36);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE8B957);
  static const Color forest = Color(0xFF263D32);
  static const Color forestLight = Color(0xFF385745);
  static const Color sandstone = Color(0xFFE9DDC8);
  static const Color cream = Color(0xFFF7F0E3);
  static const Color ink = Color(0xFF292C25);
  static const Color muted = Color(0xFF6F7165);
  static const Color teal = Color(0xFF0E8A83);
  static const Color green = Color(0xFF527A50);
  static const Color purple = Color(0xFF8063A6);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();

  String _selectedMood = '';

  final List<Map<String, dynamic>> _places = [
    {
      'name': 'Shaniwar Wada',
      'location': 'Pune, Maharashtra',
      'point': const LatLng(18.5196, 73.8553),
      'color': DiscoverScreen.primary,
      'icon': Icons.castle_rounded,
    },
    {
      'name': 'Aga Khan Palace',
      'location': 'Pune, Maharashtra',
      'point': const LatLng(18.5525, 73.9015),
      'color': DiscoverScreen.gold,
      'icon': Icons.account_balance_rounded,
    },
    {
      'name': 'Sinhagad Fort',
      'location': 'Pune, Maharashtra',
      'point': const LatLng(18.3663, 73.7559),
      'color': DiscoverScreen.green,
      'icon': Icons.terrain_rounded,
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

  void _searchPlace(String value) {
    if (value.trim().isEmpty) return;

    final query = value.trim().toLowerCase();

    final matches = _places.where(
      (place) =>
          place['name'].toString().toLowerCase().contains(query) ||
          place['location'].toString().toLowerCase().contains(query),
    );

    if (matches.isNotEmpty) {
      final place = matches.first;

      _mapController.move(place['point'] as LatLng, 14);
      FocusScope.of(context).unfocus();

      _showInfo(
        context,
        place['name'].toString(),
        place['location'].toString(),
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

    final matchingSuggestion = suggestions.where(
      (item) => item.toLowerCase().contains(query),
    );

    if (matchingSuggestion.isNotEmpty) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: DiscoverScreen.cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Heritage search',
            style: TextStyle(
              color: DiscoverScreen.forest,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Found "${matchingSuggestion.first}". Detailed location '
            'results will be available when the heritage database is connected.',
            style: const TextStyle(
              color: DiscoverScreen.muted,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'OK',
                style: TextStyle(color: DiscoverScreen.primary),
              ),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No matching heritage places found. Try another name.',
          ),
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
          content: Text('Exploring $_selectedMood heritage'),
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
        content: Text('Explore the map and tap a heritage marker.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DiscoverScreen.cream,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeaderButton(
                      icon: Icons.arrow_back_rounded,
                      tooltip: 'Back to Home',
                      onPressed: _goBack,
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3),
                          Text(
                            'DISCOVER • EXPERIENCE • PRESERVE',
                            style: TextStyle(
                              color: DiscoverScreen.primary,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.3,
                            ),
                          ),
                          SizedBox(height: 9),
                          Text(
                            'Discover',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1.2,
                              color: DiscoverScreen.forest,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Explore the stories around you',
                            style: TextStyle(
                              fontSize: 13,
                              color: DiscoverScreen.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
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

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 4, 22, 24),
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: DiscoverScreen.sandstone),
                    boxShadow: [
                      BoxShadow(
                        color: DiscoverScreen.forest.withValues(alpha: 0.04),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 17),
                      const Icon(
                        Icons.search_rounded,
                        color: DiscoverScreen.primary,
                        size: 23,
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onSubmitted: _searchPlace,
                          textInputAction: TextInputAction.search,
                          style: const TextStyle(
                            color: DiscoverScreen.forest,
                            fontSize: 13,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Search places, stories, traditions...',
                            hintStyle: TextStyle(
                              color: DiscoverScreen.muted,
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: IconButton(
                          tooltip: 'Search',
                          onPressed: () =>
                              _searchPlace(_searchController.text),
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            color: DiscoverScreen.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: _HeroSection(
                  onTap: () => _showInfo(
                    context,
                    'Beyond the Ordinary',
                    'Discover places, people and stories that shaped our heritage.',
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 36),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: _SectionHeader(
                  title: 'What are you in the mood for?',
                  subtitle: 'Choose your way to explore',
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 17),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
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

            const SliverToBoxAdapter(
              child: SizedBox(height: 36),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: _SectionHeader(
                  title: 'Heritage Around You',
                  subtitle: 'Discover places nearby',
                  actionText: 'View Map',
                  onAction: _showMap,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 17),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: _HeritageMap(
                  mapController: _mapController,
                  places: _places,
                  onMarkerTap: (place) {
                    _mapController.move(place['point'] as LatLng, 14);
                    _showInfo(
                      context,
                      place['name'].toString(),
                      place['location'].toString(),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 36),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: _SectionHeader(
                  title: 'Hidden Gems',
                  subtitle: 'Places worth discovering',
                  actionText: 'See all',
                  onAction: () => _showInfo(
                    context,
                    'Hidden Gems',
                    'Discover lesser-known heritage sites across Maharashtra.',
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 17),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 258,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _GemCard(
                      imagePath: 'assets/images/BhajaCaves.jpg',
                      title: 'Bhaja Caves',
                      location: 'Lonavala, Maharashtra',
                      icon: Icons.terrain_rounded,
                      onTap: () => _showInfo(
                        context,
                        'Bhaja Caves',
                        'Ancient Buddhist rock-cut caves near Lonavala.',
                      ),
                    ),
                    _GemCard(
                      imagePath: 'assets/images/LonarCrater.jpg',
                      title: 'Lonar Crater',
                      location: 'Buldhana, Maharashtra',
                      icon: Icons.public_rounded,
                      onTap: () => _showInfo(
                        context,
                        'Lonar Crater',
                        'A remarkable meteorite impact crater in Maharashtra.',
                      ),
                    ),
                    _GemCard(
                      imagePath: 'assets/images/PanhalaFort.jpg',
                      title: 'Panhala Fort',
                      location: 'Kolhapur, Maharashtra',
                      icon: Icons.castle_rounded,
                      onTap: () => _showInfo(
                        context,
                        'Panhala Fort',
                        'A historic hill fort near Kolhapur.',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 36),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: _SectionHeader(
                  title: 'Stories That Survived',
                  subtitle: 'History through unforgettable stories',
                  actionText: 'Explore',
                  onAction: () => _showInfo(
                    context,
                    'Heritage Stories',
                    'Explore stories about historic places, art and people.',
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 17),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 235,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _StoryCard(
                      imagePath: 'assets/images/Caves.jpg',
                      title: 'The Stories Behind Ancient Caves',
                      category: 'HISTORY',
                      onTap: () => _showInfo(
                        context,
                        'Ancient Caves',
                        'Explore the architecture and history of ancient caves.',
                      ),
                    ),
                    _StoryCard(
                      imagePath: 'assets/images/Art.jpg',
                      title: 'Art That Carries a Legacy',
                      category: 'CULTURE',
                      onTap: () => _showInfo(
                        context,
                        'Art That Carries a Legacy',
                        'Discover traditional art forms and the communities preserving them.',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 36),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: _SectionHeader(
                  title: 'Travel Through Time',
                  subtitle: 'Explore different eras of history',
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 18),
            ),

            const SliverToBoxAdapter(
              child: _Timeline(),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 36),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: _CultureBanner(
                  onTap: () => _showInfo(
                    context,
                    'Living Culture',
                    'Meet the traditions, artists and crafts that keep our heritage alive.',
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 18),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: _CameraBanner(
                  onTap: () => _showInfo(
                    context,
                    'Heritage Through Your Lens',
                    'Capture and share heritage photographs. Camera upload integration can be added next.',
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 38),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Text(
                      'SMRITI RAKSHAK',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: DiscoverScreen.forest,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Discover • Experience • Preserve',
                      style: TextStyle(
                        fontSize: 12,
                        color: DiscoverScreen.muted,
                      ),
                    ),
                  ],
                ),
              ),
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
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: DiscoverScreen.sandstone),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: DiscoverScreen.forest,
          size: 21,
        ),
      ),
    );
  }
}

// ============================================================================
// INFO DIALOG
// ============================================================================

void _showInfo(BuildContext context, String title, String description) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: DiscoverScreen.cream,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: DiscoverScreen.primary.withValues(alpha: 0.11),
                borderRadius: BorderRadius.circular(17),
              ),
              child: const Icon(
                Icons.auto_stories_rounded,
                color: DiscoverScreen.primary,
                size: 26,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                color: DiscoverScreen.forest,
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                color: DiscoverScreen.muted,
                height: 1.65,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext),
                style: ElevatedButton.styleFrom(
                  backgroundColor: DiscoverScreen.forest,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Got it',
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

// ============================================================================
// HERO SECTION
// ============================================================================

class _HeroSection extends StatelessWidget {
  final VoidCallback onTap;

  const _HeroSection({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.16),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 330,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/RedFort.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: DiscoverScreen.forest,
                    child: const Icon(
                      Icons.account_balance_rounded,
                      color: DiscoverScreen.gold,
                      size: 85,
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
                        DiscoverScreen.forest.withValues(alpha: 0.35),
                        DiscoverScreen.forest.withValues(alpha: 0.98),
                      ],
                      stops: const [0.0, 0.42, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  top: 19,
                  left: 19,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          size: 13,
                          color: DiscoverScreen.primary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'YOUR NEXT DISCOVERY',
                          style: TextStyle(
                            color: DiscoverScreen.forest,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 23,
                  right: 23,
                  bottom: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: DiscoverScreen.gold,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'EXPLORE THE UNFORGOTTEN',
                          style: TextStyle(
                            color: DiscoverScreen.forest,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Beyond the\nOrdinary.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 39,
                          height: 1.02,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1.2,
                        ),
                      ),
                      const SizedBox(height: 11),
                      const Text(
                        'Discover places, people and stories that shaped our heritage.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 17),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: DiscoverScreen.primary,
                          borderRadius: BorderRadius.circular(13),
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
                                letterSpacing: 0.8,
                              ),
                            ),
                            SizedBox(width: 9),
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
                  letterSpacing: -0.7,
                  color: DiscoverScreen.forest,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.5,
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
              padding: const EdgeInsets.only(left: 8, bottom: 2),
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
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_rounded, size: 14),
              ],
            ),
          ),
      ],
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: selected ? color : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? color : DiscoverScreen.sandstone,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
  final ValueChanged<Map<String, dynamic>> onMarkerTap;

  const _HeritageMap({
    required this.mapController,
    required this.places,
    required this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: DiscoverScreen.sandstone),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              initialCenter: LatLng(18.5204, 73.8567),
              initialZoom: 11.5,
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
                  return Marker(
                    point: place['point'] as LatLng,
                    width: 48,
                    height: 48,
                    child: GestureDetector(
                      onTap: () => onMarkerTap(place),
                      child: _MapPin(
                        color: place['color'] as Color,
                        icon: place['icon'] as IconData,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            left: 14,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: DiscoverScreen.cream,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: DiscoverScreen.sandstone),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.explore_rounded,
                    size: 17,
                    color: DiscoverScreen.primary,
                  ),
                  SizedBox(width: 7),
                  Text(
                    'Heritage near you',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: DiscoverScreen.forest,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Material(
              color: DiscoverScreen.cream,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => onMarkerTap(places.first),
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              DiscoverScreen.primary,
                              DiscoverScreen.primaryDark,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3 heritage places nearby',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: DiscoverScreen.forest,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Tap a marker to explore',
                              style: TextStyle(
                                fontSize: 10,
                                color: DiscoverScreen.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: DiscoverScreen.primary,
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

class _MapPin extends StatelessWidget {
  final Color color;
  final IconData icon;

  const _MapPin({
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.24),
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

// ============================================================================
// HIDDEN GEM CARD
// ============================================================================

class _GemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final IconData icon;
  final VoidCallback onTap;

  const _GemCard({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 15, bottom: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: DiscoverScreen.sandstone),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.06),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: DiscoverScreen.sandstone,
                        child: Center(
                          child: Icon(
                            icon,
                            size: 55,
                            color: DiscoverScreen.forest,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.94),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon,
                          size: 16,
                          color: DiscoverScreen.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 13, 14, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: DiscoverScreen.forest,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: DiscoverScreen.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: DiscoverScreen.muted,
                            ),
                          ),
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
// STORY CARD
// ============================================================================

class _StoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String category;
  final VoidCallback onTap;

  const _StoryCard({
    required this.imagePath,
    required this.title,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15, bottom: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: DiscoverScreen.forest,
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 7),
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
                      DiscoverScreen.forest.withValues(alpha: 0.04),
                      DiscoverScreen.forest.withValues(alpha: 0.30),
                      DiscoverScreen.forest.withValues(alpha: 0.97),
                    ],
                    stops: const [0, 0.45, 1],
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: DiscoverScreen.gold,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: DiscoverScreen.forest,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 17,
                bottom: 18,
                right: 17,
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
                        fontWeight: FontWeight.w900,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          'READ THE STORY',
                          style: TextStyle(
                            color: DiscoverScreen.gold,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.9,
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
// TIMELINE
// ============================================================================

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        scrollDirection: Axis.horizontal,
        children: const [
          _EraItem(
            year: 'ANCIENT',
            title: 'Caves & Temples',
            color: DiscoverScreen.gold,
            icon: Icons.account_balance_rounded,
          ),
          _EraItem(
            year: 'MEDIEVAL',
            title: 'Kingdoms & Forts',
            color: DiscoverScreen.primary,
            icon: Icons.castle_rounded,
          ),
          _EraItem(
            year: 'COLONIAL',
            title: 'Changing India',
            color: DiscoverScreen.teal,
            icon: Icons.history_edu_rounded,
          ),
          _EraItem(
            year: 'MODERN',
            title: 'Living Heritage',
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
  final Color color;
  final IconData icon;

  const _EraItem({
    required this.year,
    required this.title,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 14, bottom: 3),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: DiscoverScreen.sandstone),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.045),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 23),
          ),
          const Spacer(),
          Text(
            year,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: DiscoverScreen.forest,
              fontSize: 12,
              fontWeight: FontWeight.w900,
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: DiscoverScreen.forest.withValues(alpha: 0.13),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(26),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 225,
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
                      size: 60,
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
                        DiscoverScreen.forest.withValues(alpha: 0.78),
                        DiscoverScreen.forest.withValues(alpha: 0.05),
                      ],
                      stops: const [0, 0.62, 1],
                    ),
                  ),
                ),
                const Positioned(
                  left: 22,
                  top: 20,
                  bottom: 20,
                  right: 58,
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
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 11),
                      Text(
                        'Living Culture',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.6,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Meet the traditions, artists and crafts that keep our heritage alive.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.55,
                        ),
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Text(
                            'EXPLORE CULTURE',
                            style: TextStyle(
                              color: DiscoverScreen.gold,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.7,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: DiscoverScreen.gold,
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
      borderRadius: BorderRadius.circular(25),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 165,
          child: Stack(
            children: [
              Positioned(
                right: -8,
                top: -8,
                bottom: -8,
                child: Image.asset(
                  'assets/images/camera_banner.jpg',
                  width: 175,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(
                    width: 175,
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 70,
                      color: DiscoverScreen.gold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      DiscoverScreen.forest,
                      DiscoverScreen.forest.withValues(alpha: 0.96),
                      DiscoverScreen.forest.withValues(alpha: 0),
                    ],
                    stops: const [0, 0.72, 1],
                  ),
                ),
              ),
              const Positioned(
                left: 21,
                top: 19,
                bottom: 19,
                right: 95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      color: DiscoverScreen.gold,
                      size: 26,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Heritage Through Your Lens',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Capture. Share. Preserve.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
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
