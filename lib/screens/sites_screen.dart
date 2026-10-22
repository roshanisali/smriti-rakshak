
import 'package:flutter/material.dart';

class SitesScreen extends StatefulWidget {
  const SitesScreen({super.key});

  // ============================================================
  // HERITAGE THEME
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

  @override
  State<SitesScreen> createState() => _SitesScreenState();
}

class _SitesScreenState extends State<SitesScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedType = 'All';
  String _searchQuery = '';

  // ============================================================
  // HERITAGE DATA
  // ============================================================

  final List<Map<String, dynamic>> _featuredSites = [
    {
      'title': 'Raigad Fort',
      'location': 'Raigad, Maharashtra',
      'type': 'Hill Fort',
      'image': 'assets/images/raigadFort.jpeg',
      'color': SitesScreen.primary,
      'category': 'Forts',
    },
    {
      'title': 'Bibi Ka Maqbara',
      'location': 'Chhatrapati Sambhajinagar',
      'type': 'Mughal Architecture',
      'image': 'assets/images/bibi.jpeg',
      'color': SitesScreen.gold,
      'category': 'Palaces',
    },
    {
      'title': 'Champaner-Pavagadh',
      'location': 'Gujarat',
      'type': 'Historic City',
      'image': 'assets/images/champaner.jpeg',
      'color': SitesScreen.forestLight,
      'category': 'Historic Sites',
    },
    {
      'title': 'Rani ki Vav',
      'location': 'Patan, Gujarat',
      'type': 'Stepwell',
      'image': 'assets/images/raniKiVav.jpg',
      'color': SitesScreen.primaryDark,
      'category': 'Historic Sites',
    },
    {
      'title': 'Badami Caves',
      'location': 'Karnataka',
      'type': 'Rock-Cut Caves',
      'image': 'assets/images/badami.jpeg',
      'color': SitesScreen.forest,
      'category': 'Caves',
    },
  ];

  final List<Map<String, dynamic>> _nearbySites = [
    {
      'title': 'Pataleshwar Cave Temple',
      'location': 'Pune',
      'distance': '6.1 km',
      'image': 'assets/images/pataleshwar.jpeg',
      'type': 'Caves',
    },
    {
      'title': 'Lal Mahal',
      'location': 'Pune',
      'distance': '6.8 km',
      'image': 'assets/images/lalMahal.jpeg',
      'type': 'Palaces',
    },
    {
      'title': 'Raja Dinkar Kelkar Museum',
      'location': 'Pune',
      'distance': '7.2 km',
      'image': 'assets/images/rajadinkar.jpeg',
      'type': 'Museums',
    },
  ];

  final List<Map<String, dynamic>> _iconicSites = [
    {
      'title': 'Dholavira',
      'location': 'Gujarat',
      'image': 'assets/images/dholavira.png',
      'color': SitesScreen.forestLight,
    },
    {
      'title': 'Chittorgarh Fort',
      'location': 'Rajasthan',
      'image': 'assets/images/chittorgarh.jpeg',
      'color': SitesScreen.primary,
    },
    {
      'title': 'Sanchi Stupa',
      'location': 'Madhya Pradesh',
      'image': 'assets/images/sanchi.jpeg',
      'color': SitesScreen.gold,
    },
  ];

  final List<Map<String, dynamic>> _types = [
    {
      'title': 'Forts',
      'icon': Icons.castle_rounded,
      'color': SitesScreen.primary,
    },
    {
      'title': 'Temples',
      'icon': Icons.temple_hindu_rounded,
      'color': SitesScreen.gold,
    },
    {
      'title': 'Palaces',
      'icon': Icons.account_balance_rounded,
      'color': SitesScreen.forestLight,
    },
    {
      'title': 'Caves',
      'icon': Icons.landscape_rounded,
      'color': SitesScreen.forest,
    },
    {
      'title': 'Museums',
      'icon': Icons.museum_rounded,
      'color': SitesScreen.primaryDark,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // DIALOGS
  // ============================================================

  void _showMessage(String title, String message) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: SitesScreen.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: SitesScreen.textColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: SitesScreen.secondaryText,
            height: 1.6,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: SitesScreen.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSiteDetails(Map<String, dynamic> site) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: SitesScreen.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 210,
                  width: double.infinity,
                  child: Image.asset(
                    site['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: SitesScreen.background,
                        child: const Icon(
                          Icons.account_balance_rounded,
                          size: 60,
                          color: SitesScreen.primary,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: (site['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          site['type'] as String,
                          style: TextStyle(
                            color: site['color'] as Color,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        site['title'] as String,
                        style: const TextStyle(
                          color: SitesScreen.textColor,
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: SitesScreen.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              site['location'] as String,
                              style: const TextStyle(
                                color: SitesScreen.secondaryText,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 17),
                      const Text(
                        'Explore the architecture, stories and cultural heritage of this remarkable place.',
                        style: TextStyle(
                          color: SitesScreen.secondaryText,
                          fontSize: 13,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              color: SitesScreen.primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
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

  // ============================================================
  // FILTERING
  // ============================================================

  List<Map<String, dynamic>> get _filteredFeaturedSites {
    return _featuredSites.where((site) {
      final matchesSearch =
          site['title'].toString().toLowerCase().contains(_searchQuery) ||
          site['location'].toString().toLowerCase().contains(_searchQuery) ||
          site['type'].toString().toLowerCase().contains(_searchQuery);

      final matchesType =
          _selectedType == 'All' || site['category'] == _selectedType;

      return matchesSearch && matchesType;
    }).toList();
  }

  List<Map<String, dynamic>> get _filteredNearbySites {
    return _nearbySites.where((site) {
      final matchesSearch =
          site['title'].toString().toLowerCase().contains(_searchQuery) ||
          site['location'].toString().toLowerCase().contains(_searchQuery) ||
          site['type'].toString().toLowerCase().contains(_searchQuery);

      final matchesType =
          _selectedType == 'All' || site['type'] == _selectedType;

      return matchesSearch && matchesType;
    }).toList();
  }

  // ============================================================
  // MAIN SCREEN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SitesScreen.background,
      appBar: AppBar(
        backgroundColor: SitesScreen.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          tooltip: 'Go back',
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: SitesScreen.textColor,
          ),
          onPressed: () async {
            final navigator = Navigator.of(context);
            if (navigator.canPop()) {
              navigator.pop();
            } else {
              await navigator.maybePop();
            }
          },
        ),
        titleSpacing: 4,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Heritage Sites',
              style: TextStyle(
                color: SitesScreen.textColor,
                fontSize: 21,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Discover India's heritage",
              style: TextStyle(
                color: SitesScreen.secondaryText,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: SitesScreen.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: SitesScreen.sandstone),
              ),
              child: const Icon(
                Icons.explore_rounded,
                color: SitesScreen.primary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final horizontalPadding = constraints.maxWidth >= 1200
              ? 40.0
              : constraints.maxWidth >= 700
                  ? 28.0
                  : 16.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              12,
              horizontalPadding,
              40,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1240),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHero(isWide),
                    const SizedBox(height: 24),
                    _buildSearchBar(),
                    const SizedBox(height: 30),
                    _buildSectionTitle(
                      'Explore by Type',
                      Icons.category_rounded,
                    ),
                    const SizedBox(height: 15),
                    _buildTypes(isWide),
                    const SizedBox(height: 34),
                    _buildSectionTitle(
                      'Featured Heritage',
                      Icons.auto_awesome_rounded,
                      actionText: 'View All',
                      onAction: _clearFilters,
                    ),
                    const SizedBox(height: 15),
                    _buildFeaturedSites(isWide),
                    const SizedBox(height: 34),
                    _buildSectionTitle(
                      'Near You',
                      Icons.near_me_rounded,
                      actionText: 'Open Map',
                      onAction: () => _showMessage(
                        'Explore the Map',
                        'Map exploration will be available here soon.',
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildNearbySites(isWide),
                    const SizedBox(height: 34),
                    _buildSectionTitle(
                      'Hidden Gems',
                      Icons.travel_explore_rounded,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Discover lesser-known places beyond the usual tourist spots.',
                      style: TextStyle(
                        color: SitesScreen.secondaryText,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildHiddenGems(isWide),
                    const SizedBox(height: 34),
                    _buildSectionTitle(
                      "India's Heritage Icons",
                      Icons.star_rounded,
                    ),
                    const SizedBox(height: 15),
                    _buildIconicSites(isWide),
                    const SizedBox(height: 34),
                    _buildBottomCta(isWide),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        'SMRITI RAKSHAK',
                        style: TextStyle(
                          color: SitesScreen.forest,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Center(
                      child: Text(
                        'Discover • Experience • Preserve',
                        style: TextStyle(
                          color: SitesScreen.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // HERO SECTION
  // ============================================================

  Widget _buildHero(bool isWide) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 34 : 23),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SitesScreen.forest,
            SitesScreen.forestLight,
            Color(0xFF637650),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: SitesScreen.forest.withOpacity(0.16),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              right: -15,
              top: -25,
              child: Icon(
                Icons.account_balance_rounded,
                size: isWide ? 190 : 125,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
            Positioned(
              right: isWide ? 180 : 70,
              bottom: -35,
              child: Icon(
                Icons.temple_hindu_rounded,
                size: isWide ? 120 : 80,
                color: SitesScreen.gold.withOpacity(0.10),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: SitesScreen.gold.withOpacity(0.45),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.explore_rounded,
                        color: SitesScreen.gold,
                        size: 16,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'YOUR HERITAGE JOURNEY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isWide ? 620 : 300,
                  child: Text(
                    'Explore Heritage Sites',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isWide ? 37 : 29,
                      height: 1.15,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: isWide ? 560 : 310,
                  child: Text(
                    'Step into the past. Discover magnificent forts, ancient temples, forgotten stories and the treasures of India.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: isWide ? 14 : 13,
                      height: 1.7,
                    ),
                  ),
                ),
                const SizedBox(height: 23),
                Wrap(
                  spacing: 9,
                  runSpacing: 9,
                  children: const [
                    _HeroPill(
                      icon: Icons.castle_rounded,
                      label: 'Historic Forts',
                    ),
                    _HeroPill(
                      icon: Icons.museum_rounded,
                      label: 'Cultural Treasures',
                    ),
                    _HeroPill(
                      icon: Icons.travel_explore_rounded,
                      label: 'Hidden Gems',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: SitesScreen.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SitesScreen.sandstone),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: SitesScreen.primary,
            size: 23,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim().toLowerCase();
                });
              },
              style: const TextStyle(
                color: SitesScreen.textColor,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                hintText: 'Search forts, temples, monuments...',
                hintStyle: TextStyle(
                  color: SitesScreen.secondaryText,
                  fontSize: 13,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            IconButton(
              tooltip: 'Clear search',
              onPressed: () {
                _searchController.clear();
                setState(() => _searchQuery = '');
              },
              icon: const Icon(
                Icons.close_rounded,
                color: SitesScreen.secondaryText,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION HEADING
  // ============================================================

  Widget _buildSectionTitle(
    String title,
    IconData icon, {
    String? actionText,
    VoidCallback? onAction,
  }) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: SitesScreen.primary.withOpacity(0.09),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: SitesScreen.primary,
            size: 21,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: SitesScreen.textColor,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        if (actionText != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: SitesScreen.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 7,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 15,
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ============================================================
  // CATEGORY FILTERS
  // ============================================================

  Widget _buildTypes(bool isWide) {
    if (isWide) {
      return Wrap(
        spacing: 14,
        runSpacing: 14,
        children: _types.map((type) {
          return SizedBox(
            width: 145,
            child: _TypeCard(
              icon: type['icon'] as IconData,
              title: type['title'] as String,
              color: type['color'] as Color,
              selected: _selectedType == type['title'],
              onTap: () => _toggleType(type['title'] as String),
            ),
          );
        }).toList(),
      );
    }

    return SizedBox(
      height: 112,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: _types.map((type) {
          return _TypeCard(
            icon: type['icon'] as IconData,
            title: type['title'] as String,
            color: type['color'] as Color,
            selected: _selectedType == type['title'],
            onTap: () => _toggleType(type['title'] as String),
          );
        }).toList(),
      ),
    );
  }

  void _toggleType(String type) {
    setState(() {
      _selectedType = _selectedType == type ? 'All' : type;
    });
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _selectedType = 'All';
      _searchQuery = '';
    });
  }

  // ============================================================
  // FEATURED HERITAGE
  // ============================================================

  Widget _buildFeaturedSites(bool isWide) {
    final sites = _filteredFeaturedSites;

    if (sites.isEmpty) {
      return _emptyState('No matching featured sites found.');
    }

    if (isWide) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final count = constraints.maxWidth >= 1050 ? 4 : 3;
          final cardWidth =
              (constraints.maxWidth - ((count - 1) * 16)) / count;

          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: sites.map((site) {
              return SizedBox(
                width: cardWidth,
                height: 260,
                child: _SiteCard(
                  title: site['title'] as String,
                  location: site['location'] as String,
                  type: site['type'] as String,
                  image: site['image'] as String,
                  color: site['color'] as Color,
                  onTap: () => _showSiteDetails(site),
                ),
              );
            }).toList(),
          );
        },
      );
    }

    return SizedBox(
      height: 260,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: sites.map((site) {
          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: _SiteCard(
              title: site['title'] as String,
              location: site['location'] as String,
              type: site['type'] as String,
              image: site['image'] as String,
              color: site['color'] as Color,
              onTap: () => _showSiteDetails(site),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================
  // NEARBY SITES
  // ============================================================

  Widget _buildNearbySites(bool isWide) {
    final sites = _filteredNearbySites;

    if (sites.isEmpty) {
      return _emptyState('No nearby sites match your search.');
    }

    if (isWide) {
      return LayoutBuilder(
        builder: (context, constraints) {
          const gap = 16.0;
          final cardWidth = (constraints.maxWidth - gap * 2) / 3;

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: sites.map((site) {
              return SizedBox(
                width: cardWidth,
                child: _NearbySite(
                  title: site['title'] as String,
                  location: site['location'] as String,
                  distance: site['distance'] as String,
                  image: site['image'] as String,
                  onTap: () => _showMessage(
                    site['title'] as String,
                    '${site['location']} · ${site['distance']}\n\n'
                        'More site details will be available soon.',
                  ),
                ),
              );
            }).toList(),
          );
        },
      );
    }

    return Column(
      children: sites.map((site) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _NearbySite(
            title: site['title'] as String,
            location: site['location'] as String,
            distance: site['distance'] as String,
            image: site['image'] as String,
            onTap: () => _showMessage(
              site['title'] as String,
              '${site['location']} · ${site['distance']}\n\n'
                  'More site details will be available soon.',
            ),
          ),
        );
      }).toList(),
    );
  }

  // ============================================================
  // HIDDEN GEMS
  // ============================================================

  Widget _buildHiddenGems(bool isWide) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: () => _showMessage(
          'Hidden Heritage',
          'Discover lesser-known forts, ancient temples and local heritage stories. This collection is coming soon.',
        ),
        borderRadius: BorderRadius.circular(25),
        child: Ink(
          width: double.infinity,
          padding: EdgeInsets.all(isWide ? 26 : 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                SitesScreen.primaryDark,
                SitesScreen.primary,
              ],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
                child: const Icon(
                  Icons.travel_explore_rounded,
                  color: SitesScreen.gold,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hidden Heritage',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Find forgotten forts, ancient temples and secret stories waiting to be uncovered.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // INDIA'S HERITAGE ICONS
  // ============================================================

  Widget _buildIconicSites(bool isWide) {
    if (isWide) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final count = constraints.maxWidth > 800 ? 3 : 2;
          final cardWidth =
              (constraints.maxWidth - ((count - 1) * 16)) / count;

          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: _iconicSites.map((site) {
              return SizedBox(
                width: cardWidth,
                height: 215,
                child: _IconicCard(
                  title: site['title'] as String,
                  location: site['location'] as String,
                  image: site['image'] as String,
                  color: site['color'] as Color,
                  onTap: () => _showMessage(
                    site['title'] as String,
                    '${site['location']}\n\n'
                        'Discover the history and cultural significance of this heritage icon.',
                  ),
                ),
              );
            }).toList(),
          );
        },
      );
    }

    return SizedBox(
      height: 215,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: _iconicSites.map((site) {
          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: _IconicCard(
              title: site['title'] as String,
              location: site['location'] as String,
              image: site['image'] as String,
              color: site['color'] as Color,
              onTap: () => _showMessage(
                site['title'] as String,
                '${site['location']}\n\n'
                    'Discover the history and cultural significance of this heritage icon.',
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================
  // BOTTOM CALL TO ACTION
  // ============================================================

  Widget _buildBottomCta(bool isWide) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 30 : 23),
      decoration: BoxDecoration(
        color: SitesScreen.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: SitesScreen.gold.withOpacity(0.5),
        ),
      ),
      child: isWide
          ? Row(
              children: [
                _ctaIcon(),
                const SizedBox(width: 22),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ready to explore?',
                        style: TextStyle(
                          color: SitesScreen.textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Find heritage sites around you and start your journey through history.',
                        style: TextStyle(
                          color: SitesScreen.secondaryText,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                _ExploreButton(
                  onPressed: () => _showMessage(
                    'Explore Sites',
                    'Site discovery is ready to grow. Map navigation will be connected here soon.',
                  ),
                ),
              ],
            )
          : Column(
              children: [
                _ctaIcon(),
                const SizedBox(height: 14),
                const Text(
                  'Ready to explore?',
                  style: TextStyle(
                    color: SitesScreen.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Find heritage sites around you and start your journey.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: SitesScreen.secondaryText,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 18),
                _ExploreButton(
                  onPressed: () => _showMessage(
                    'Explore Sites',
                    'Site discovery is ready to grow. Map navigation will be connected here soon.',
                  ),
                ),
              ],
            ),
    );
  }

  Widget _ctaIcon() {
    return Container(
      height: 68,
      width: 68,
      decoration: BoxDecoration(
        color: SitesScreen.primary.withOpacity(0.09),
        borderRadius: BorderRadius.circular(21),
      ),
      child: const Icon(
        Icons.map_rounded,
        color: SitesScreen.primary,
        size: 36,
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _emptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: SitesScreen.surface,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: SitesScreen.sandstone),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 38,
            color: SitesScreen.secondaryText.withOpacity(0.7),
          ),
          const SizedBox(height: 11),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: SitesScreen.secondaryText,
              fontSize: 13,
            ),
          ),
          if (_searchQuery.isNotEmpty || _selectedType != 'All') ...[
            const SizedBox(height: 10),
            TextButton(
              onPressed: _clearFilters,
              child: const Text(
                'Clear filters',
                style: TextStyle(
                  color: SitesScreen.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// HERO PILL
// ============================================================

class _HeroPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroPill({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: SitesScreen.gold,
            size: 16,
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CATEGORY CARD
// ============================================================

class _TypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _TypeCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Material(
        color: selected ? color.withOpacity(0.09) : SitesScreen.surface,
        borderRadius: BorderRadius.circular(19),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(19),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: selected ? color : SitesScreen.sandstone,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 43,
                  width: 43,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.13),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 23,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: SitesScreen.textColor,
                    fontSize: 12,
                    fontWeight:
                        selected ? FontWeight.w900 : FontWeight.w700,
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

// ============================================================
// FEATURED SITE CARD
// ============================================================

class _SiteCard extends StatelessWidget {
  final String title;
  final String location;
  final String type;
  final String image;
  final Color color;
  final VoidCallback onTap;

  const _SiteCard({
    required this.title,
    required this.location,
    required this.type,
    required this.image,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SitesScreen.surface,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: SitesScreen.sandstone),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 125,
                width: double.infinity,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: color.withOpacity(0.12),
                      child: Icon(
                        Icons.account_balance_rounded,
                        color: color,
                        size: 42,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: SitesScreen.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: SitesScreen.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            height: 7,
                            width: 7,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              type,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: color,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_outward_rounded,
                            color: color,
                            size: 17,
                          ),
                        ],
                      ),
                    ],
                  ),
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
// NEARBY SITE CARD
// ============================================================

class _NearbySite extends StatelessWidget {
  final String title;
  final String location;
  final String distance;
  final String image;
  final VoidCallback onTap;

  const _NearbySite({
    required this.title,
    required this.location,
    required this.distance,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SitesScreen.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: SitesScreen.sandstone),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  image,
                  width: 74,
                  height: 74,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 74,
                      height: 74,
                      color: SitesScreen.background,
                      child: const Icon(
                        Icons.account_balance_rounded,
                        color: SitesScreen.primary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: SitesScreen.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: SitesScreen.secondaryText,
                          size: 14,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            location,
                            style: const TextStyle(
                              color: SitesScreen.secondaryText,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: SitesScreen.forest.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  distance,
                  style: const TextStyle(
                    color: SitesScreen.forest,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
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
// ICONIC SITE CARD
// ============================================================

class _IconicCard extends StatelessWidget {
  final String title;
  final String location;
  final String image;
  final Color color;
  final VoidCallback onTap;

  const _IconicCard({
    required this.title,
    required this.location,
    required this.image,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SitesScreen.surface,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: SitesScreen.sandstone),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 112,
                width: double.infinity,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: color.withOpacity(0.12),
                      child: Icon(
                        Icons.account_balance_rounded,
                        size: 40,
                        color: color,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: SitesScreen.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: color,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: SitesScreen.secondaryText,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
// EXPLORE BUTTON
// ============================================================

class _ExploreButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ExploreButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.explore_rounded,
        size: 19,
      ),
      label: const Text('Explore Sites'),
      style: ElevatedButton.styleFrom(
        backgroundColor: SitesScreen.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
