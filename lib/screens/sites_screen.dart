
import 'package:flutter/material.dart';

class SitesScreen extends StatefulWidget {
  const SitesScreen({super.key});

  @override
  State<SitesScreen> createState() => _SitesScreenState();
}

class _SitesScreenState extends State<SitesScreen> {
  // ============================================================
  // SMRITI RAKSHAK - HERITAGE COLOURS
  // ============================================================

  static const Color primary = Color(0xFFE0533C);
  static const Color primaryDark = Color(0xFFA6321F);
  static const Color gold = Color(0xFFF2A922);
  static const Color background = Color(0xFFF0F4F8);
  static const Color surface = Colors.white;
  static const Color textColor = Color(0xFF0F172A);
  static const Color secondaryText = Color(0xFF475569);
  static const Color teal = Color(0xFF0EA5E9);
  static const Color green = Color(0xFF10B981);

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedType = 'All';

  final List<String> _siteTypes = [
    'All',
    'Forts',
    'Temples',
    'Palaces',
    'Caves',
    'Museums',
    'Historic Sites',
  ];

  // ============================================================
  // FEATURED HERITAGE SITES
  // ============================================================

  final List<Map<String, dynamic>> _featuredSites = [
    {
      'name': 'Raigad Fort',
      'location': 'Raigad, Maharashtra',
      'type': 'Forts',
      'category': 'Hill Fort',
      'image': 'assets/images/raigadFort.jpeg',
      'period': '17th century',
      'description':
          'Discover the majestic hill fort that served as the capital of Chhatrapati Shivaji Maharaj’s kingdom. Surrounded by the Sahyadri mountains, Raigad is a powerful symbol of courage, leadership and Maratha heritage.',
      'fact': 'Capital of the Maratha kingdom under Shivaji Maharaj.',
      'tag': 'MARATHA HERITAGE',
    },
    {
      'name': 'Bibi Ka Maqbara',
      'location': 'Chhatrapati Sambhajinagar, Maharashtra',
      'type': 'Palaces',
      'category': 'Mughal Architecture',
      'image': 'assets/images/bibi.jpeg',
      'period': '17th century',
      'description':
          'Admire the elegant marble-inspired monument known for its Mughal design, ornamental details and beautiful gardens. Its graceful architecture makes it one of Maharashtra’s best-known historical landmarks.',
      'fact': 'Often called the Deccan’s Taj Mahal.',
      'tag': 'ARCHITECTURAL GEM',
    },
    {
      'name': 'Champaner-Pavagadh',
      'location': 'Panchmahal, Gujarat',
      'type': 'Historic Sites',
      'category': 'Historic City',
      'image': 'assets/images/champaner.jpeg',
      'period': 'Medieval period',
      'description':
          'Explore a historic landscape of forts, mosques, temples, stepwells and archaeological remains. The site reveals layers of history shaped by different rulers and architectural traditions.',
      'fact': 'A UNESCO World Heritage Site.',
      'tag': 'WORLD HERITAGE',
    },
    {
      'name': 'Rani Ki Vav',
      'location': 'Patan, Gujarat',
      'type': 'Historic Sites',
      'category': 'Stepwell',
      'image': 'assets/images/raniKiVav.jpg',
      'period': '11th century',
      'description':
          'Step into an extraordinary subterranean structure decorated with intricate sculptures. Rani Ki Vav demonstrates how historic communities combined water management with remarkable craftsmanship.',
      'fact': 'A UNESCO World Heritage Site famous for its sculptural galleries.',
      'tag': 'ANCIENT ENGINEERING',
    },
    {
      'name': 'Badami Caves',
      'location': 'Badami, Karnataka',
      'type': 'Caves',
      'category': 'Rock-Cut Caves',
      'image': 'assets/images/badami.jpeg',
      'period': '6th century onward',
      'description':
          'Explore sandstone cave temples carved into the cliffs of Badami. Their sculptures and pillars showcase the artistic achievements of early Chalukyan architecture.',
      'fact': 'Known for rock-cut temples and detailed stone sculptures.',
      'tag': 'STONE MASTERPIECE',
    },
  ];

  // ============================================================
  // NEARBY HERITAGE
  // ============================================================

  final List<Map<String, dynamic>> _nearbySites = [
    {
      'name': 'Pataleshwar Cave Temple',
      'location': 'Shivajinagar, Pune',
      'distance': '6.1 km',
      'type': 'Caves',
      'image': 'assets/images/pataleshwar.jpeg',
      'description':
          'A rock-cut cave temple dedicated to Lord Shiva, known for its stone pillars and quiet courtyard in the middle of Pune.',
      'fact': 'An early rock-cut temple carved from a single rock formation.',
    },
    {
      'name': 'Lal Mahal',
      'location': 'Kasba Peth, Pune',
      'distance': '6.8 km',
      'type': 'Palaces',
      'image': 'assets/images/lalMahal.jpeg',
      'description':
          'A historically significant landmark associated with the early life of Chhatrapati Shivaji Maharaj.',
      'fact': 'An important landmark in Maratha history.',
    },
    {
      'name': 'Raja Dinkar Kelkar Museum',
      'location': 'Shukrawar Peth, Pune',
      'distance': '7.2 km',
      'type': 'Museums',
      'image': 'assets/images/rajadinkar.jpeg',
      'description':
          'Discover an extensive collection of Indian art, traditional objects, musical instruments and everyday artefacts.',
      'fact': 'Preserves objects that tell stories of Indian craftsmanship and daily life.',
    },
  ];

  // ============================================================
  // INDIA'S HERITAGE ICONS
  // ============================================================

  final List<Map<String, dynamic>> _iconicSites = [
    {
      'name': 'Dholavira',
      'location': 'Kutch, Gujarat',
      'type': 'Historic Sites',
      'image': 'assets/images/dholavira.png',
      'description':
          'Discover an ancient Harappan city known for its urban planning, water conservation systems and archaeological remains.',
      'fact': 'A UNESCO World Heritage Site associated with the Indus Valley Civilization.',
    },
    {
      'name': 'Chittorgarh Fort',
      'location': 'Chittorgarh, Rajasthan',
      'type': 'Forts',
      'image': 'assets/images/chittorgarh.jpeg',
      'description':
          'Explore a vast hilltop fort celebrated for its monumental gateways, palaces, temples and stories of Rajput history.',
      'fact': 'One of the largest fort complexes in India.',
    },
    {
      'name': 'Sanchi Stupa',
      'location': 'Sanchi, Madhya Pradesh',
      'type': 'Temples',
      'image': 'assets/images/sanchi.jpeg',
      'description':
          'Experience an important Buddhist monument with beautifully carved gateways depicting stories and symbols from Buddhist traditions.',
      'fact':
          'A UNESCO World Heritage Site with origins dating to the 3rd century BCE.',
    },
  ];

  // ============================================================
  // FILTERING
  // ============================================================

  bool _matchesSearch(Map<String, dynamic> site) {
    final query = _searchQuery.trim().toLowerCase();

    final matchesQuery = query.isEmpty ||
        site['name'].toString().toLowerCase().contains(query) ||
        site['location'].toString().toLowerCase().contains(query) ||
        site['type'].toString().toLowerCase().contains(query) ||
        (site['category'] ?? '')
            .toString()
            .toLowerCase()
            .contains(query);

    final matchesType = _selectedType == 'All' ||
        site['type'] == _selectedType ||
        site['category'] == _selectedType;

    return matchesQuery && matchesType;
  }

  List<Map<String, dynamic>> get _filteredFeatured =>
      _featuredSites.where(_matchesSearch).toList();

  List<Map<String, dynamic>> get _filteredNearby =>
      _nearbySites.where(_matchesSearch).toList();

  List<Map<String, dynamic>> get _filteredIcons =>
      _iconicSites.where(_matchesSearch).toList();

  bool get _hasResults =>
      _filteredFeatured.isNotEmpty ||
      _filteredNearby.isNotEmpty ||
      _filteredIcons.isNotEmpty;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // MAIN PAGE
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: surface,
        foregroundColor: textColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Go back',
          onPressed: () {
            final navigator = Navigator.of(context);
            if (navigator.canPop()) {
              navigator.pop();
            } else {
              navigator.maybePop();
            }
          },
        ),
        title: const Row(
          children: [
            Icon(Icons.account_balance_rounded, color: primary),
            SizedBox(width: 10),
            Text(
              'Heritage Sites',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 19,
                color: textColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Clear search and filters',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _selectedType = 'All';
                _searchController.clear();
              });
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHero()),
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: _buildTypeFilters()),
            if (!_hasResults)
              SliverToBoxAdapter(child: _buildEmptyState()),
            if (_filteredFeatured.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _buildSectionHeading(
                  eyebrow: 'START YOUR JOURNEY',
                  title: 'Featured Heritage',
                  subtitle:
                      'Remarkable places. Extraordinary stories. A heritage waiting to be explored.',
                  icon: Icons.auto_awesome_rounded,
                ),
              ),
              SliverToBoxAdapter(child: _buildFeaturedCards()),
            ],
            if (_filteredNearby.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _buildSectionHeading(
                  eyebrow: 'EXPLORE AROUND YOU',
                  title: 'Nearby Discoveries',
                  subtitle:
                      'Explore cultural landmarks around Pune and uncover stories close to home.',
                  icon: Icons.near_me_rounded,
                ),
              ),
              SliverToBoxAdapter(child: _buildNearbySites()),
            ],
            if (_filteredIcons.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _buildSectionHeading(
                  eyebrow: 'BEYOND THE ORDINARY',
                  title: 'India’s Heritage Icons',
                  subtitle:
                      'From ancient cities to monumental forts, discover the legacy of a civilization.',
                  icon: Icons.landscape_rounded,
                ),
              ),
              SliverToBoxAdapter(child: _buildIconicSites()),
            ],
            SliverToBoxAdapter(child: _buildPreservationBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF963B29), Color(0xFFE0533C), Color(0xFFF2A922)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              right: -25,
              top: -25,
              child: Icon(
                Icons.account_balance_rounded,
                size: 190,
                color: Colors.white.withValues(alpha: 0.09),
              ),
            ),
            Positioned(
              right: 55,
              bottom: -42,
              child: Icon(
                Icons.temple_buddhist_rounded,
                size: 135,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.explore_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'DISCOVER • EXPERIENCE • PRESERVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Every monument\nhas a story.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 33,
                      height: 1.12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.7,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Walk through centuries of courage, creativity and culture. Your next discovery begins here.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Wrap(
                    spacing: 9,
                    runSpacing: 9,
                    children: [
                      _heroPill(Icons.castle_rounded, 'Historic forts'),
                      _heroPill(Icons.museum_rounded, 'Ancient art'),
                      _heroPill(Icons.public_rounded, 'Living heritage'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 15),
          const SizedBox(width: 6),
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

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
      child: Container(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: textColor.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _searchQuery = value),
          style: const TextStyle(
            color: textColor,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: 'Search forts, temples, cities...',
            hintStyle: const TextStyle(color: secondaryText, fontSize: 13),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: primary,
              size: 24,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY FILTERS
  // ============================================================

  Widget _buildTypeFilters() {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: _siteTypes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final type = _siteTypes[index];
          final selected = type == _selectedType;

          return ChoiceChip(
            label: Text(type),
            selected: selected,
            showCheckmark: false,
            onSelected: (_) => setState(() => _selectedType = type),
            backgroundColor: surface,
            selectedColor: primary,
            side: BorderSide(
              color: selected ? primary : const Color(0xFFE2E8F0),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            labelStyle: TextStyle(
              color: selected ? Colors.white : secondaryText,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          );
        },
      ),
    );
  }

  // ============================================================
  // SECTION HEADINGS
  // ============================================================

  Widget _buildSectionHeading({
    required String eyebrow,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 27, 20, 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: primary, size: 23),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow,
                  style: const TextStyle(
                    color: primary,
                    fontSize: 9,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: secondaryText,
                    fontSize: 12,
                    height: 1.55,
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
  // FEATURED FULL-IMAGE CARDS
  // ============================================================

  Widget _buildFeaturedCards() {
    return SizedBox(
      height: 325,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: _filteredFeatured.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final site = _filteredFeatured[index];

          return _SiteCard(
            site: site,
            onTap: () => _showSiteDetails(site),
          );
        },
      ),
    );
  }

  // ============================================================
  // NEARBY SITES
  // ============================================================

  Widget _buildNearbySites() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: _filteredNearby.map((site) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _NearbySiteCard(
              site: site,
              onTap: () => _showSiteDetails(site),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================
  // ICONIC FULL-IMAGE CARDS
  // ============================================================

  Widget _buildIconicSites() {
    return SizedBox(
      height: 255,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: _filteredIcons.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final site = _filteredIcons[index];

          return _IconicCard(
            site: site,
            onTap: () => _showSiteDetails(site),
          );
        },
      ),
    );
  }

  // ============================================================
  // DETAILS DIALOG
  // ============================================================

  void _showSiteDetails(Map<String, dynamic> site) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: surface,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520, maxHeight: 690),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 235,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _siteImage(
                          site['image'] as String,
                          iconSize: 65,
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0x33000000),
                                Colors.transparent,
                                Color(0xCC000000),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: IconButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            style: IconButton.styleFrom(
                              backgroundColor:
                                  Colors.black.withValues(alpha: 0.35),
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          child: Text(
                            site['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: primary,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                site['location'] as String,
                                style: const TextStyle(
                                  color: secondaryText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _detailTag(
                              Icons.category_rounded,
                              (site['category'] ?? site['type']).toString(),
                            ),
                            if (site['period'] != null)
                              _detailTag(
                                Icons.history_edu_rounded,
                                site['period'].toString(),
                              ),
                            if (site['distance'] != null)
                              _detailTag(
                                Icons.near_me_rounded,
                                site['distance'].toString(),
                              ),
                          ],
                        ),
                        const SizedBox(height: 19),
                        const Text(
                          'The Story Behind the Site',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          site['description'] as String,
                          style: const TextStyle(
                            color: secondaryText,
                            fontSize: 13,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: gold.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: gold.withValues(alpha: 0.35),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.lightbulb_rounded,
                                color: Color(0xFFB77905),
                                size: 22,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'HERITAGE FACT',
                                      style: TextStyle(
                                        color: Color(0xFF8A5B00),
                                        fontSize: 10,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      site['fact'] as String,
                                      style: const TextStyle(
                                        color: textColor,
                                        fontSize: 12,
                                        height: 1.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.explore_rounded),
                            label: const Text('Continue Exploring'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w800,
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
        );
      },
    );
  }

  Widget _detailTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: primary, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRESERVATION BANNER
  // ============================================================

  Widget _buildPreservationBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 30, 18, 0),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF163D36),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF163D36).withValues(alpha: 0.14),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -15,
            child: Icon(
              Icons.park_rounded,
              size: 110,
              color: Colors.white.withValues(alpha: 0.07),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.volunteer_activism_rounded,
                  color: gold,
                  size: 27,
                ),
              ),
              const SizedBox(height: 17),
              const Text(
                'Our Heritage.\nOur Responsibility.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Every visit is an opportunity to learn, respect local traditions and help preserve the stories that connect generations.',
                style: TextStyle(
                  color: Color(0xFFD7E8E2),
                  fontSize: 13,
                  height: 1.65,
                ),
              ),
              const SizedBox(height: 19),
              Row(
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFFFFC6B9),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Discover the past. Protect the future.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: gold,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Color(0xFF163D36),
                      size: 19,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 35, 24, 45),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(23),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.09),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.travel_explore_rounded,
                size: 43,
                color: primary,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No discoveries found',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try another keyword or explore a different category.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondaryText,
                fontSize: 13,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _selectedType = 'All';
                  _searchController.clear();
                });
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Show all sites'),
              style: OutlinedButton.styleFrom(
                foregroundColor: primary,
                side: const BorderSide(color: primary),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SHARED IMAGE HELPER
  // ============================================================

  Widget _siteImage(String path, {double iconSize = 45}) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFFE8DDC9),
          child: Center(
            child: Icon(
              Icons.account_balance_rounded,
              size: iconSize,
              color: primaryDark,
            ),
          ),
        );
      },
    );
  }
}

// ================================================================
// FEATURED HERITAGE CARD - FULL IMAGE WITH TEXT OVERLAY
// ================================================================

class _SiteCard extends StatelessWidget {
  const _SiteCard({
    required this.site,
    required this.onTap,
  });

  final Map<String, dynamic> site;
  final VoidCallback onTap;

  static const Color primary = Color(0xFFE0533C);
  static const Color gold = Color(0xFFF2A922);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 265,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                site['image'] as String,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE8DDC9),
                    child: const Center(
                      child: Icon(
                        Icons.account_balance_rounded,
                        color: Color(0xFFA6321F),
                        size: 60,
                      ),
                    ),
                  );
                },
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.24, 0.48, 1.0],
                    colors: [
                      Color(0x55000000),
                      Colors.transparent,
                      Color(0x44000000),
                      Color(0xED000000),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 14,
                left: 14,
                right: 14,
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          (site['tag'] ?? 'HERITAGE').toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF422A08),
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.32),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_outward_rounded,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 17,
                right: 17,
                bottom: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: primary.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        (site['category'] ?? site['type']).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      site['name'] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        height: 1.12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.4,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: gold,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            site['location'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        const Icon(
                          Icons.auto_stories_rounded,
                          color: gold,
                          size: 16,
                        ),
                        const SizedBox(width: 7),
                        const Expanded(
                          child: Text(
                            'Discover its story',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: primary,
                            size: 16,
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

// ================================================================
// NEARBY SITE CARD
// ================================================================

class _NearbySiteCard extends StatelessWidget {
  const _NearbySiteCard({
    required this.site,
    required this.onTap,
  });

  final Map<String, dynamic> site;
  final VoidCallback onTap;

  static const Color primary = Color(0xFFE0533C);
  static const Color textColor = Color(0xFF0F172A);
  static const Color secondaryText = Color(0xFF475569);
  static const Color teal = Color(0xFF0EA5E9);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 106,
                  height: 112,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        site['image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFE8DDC9),
                            child: const Icon(
                              Icons.account_balance_rounded,
                              color: Color(0xFFA6321F),
                              size: 35,
                            ),
                          );
                        },
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0x99000000),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 7,
                        right: 7,
                        child: Text(
                          site['type'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      site['name'] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 15,
                        height: 1.25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: primary,
                          size: 15,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            site['location'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: teal.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.near_me_rounded,
                            color: teal,
                            size: 13,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            site['distance'] as String,
                            style: const TextStyle(
                              color: teal,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: primary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// INDIA'S HERITAGE ICON - FULL IMAGE WITH TEXT OVERLAY
// ================================================================

class _IconicCard extends StatelessWidget {
  const _IconicCard({
    required this.site,
    required this.onTap,
  });

  final Map<String, dynamic> site;
  final VoidCallback onTap;

  static const Color primary = Color(0xFFE0533C);
  static const Color gold = Color(0xFFF2A922);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 225,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                site['image'] as String,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE8DDC9),
                    child: const Center(
                      child: Icon(
                        Icons.landscape_rounded,
                        size: 55,
                        color: Color(0xFFA6321F),
                      ),
                    ),
                  );
                },
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.35, 1],
                    colors: [
                      Color(0x33000000),
                      Color(0x11000000),
                      Color(0xE9000000),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: gold,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Color(0xFF422A08),
                    size: 17,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.30),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.north_east_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              Positioned(
                left: 15,
                right: 15,
                bottom: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        site['type'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      site['name'] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: gold,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            site['location'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
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
