import 'package:flutter/material.dart';

import 'community_screen.dart';
import 'marketplace_screen.dart';

class ConnectScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const ConnectScreen({
    super.key,
    this.onBack,
  });

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  // ============================================================
  // HERITAGE THEME
  // ============================================================

  static const Color primary = Color(0xFFE0533C);
  static const Color primaryDark = Color(0xFFA6321F);
  static const Color gold = Color(0xFFF2A922);
  static const Color forest = Color(0xFF183D32);
  static const Color forestLight = Color(0xFF28634D);
  static const Color teal = Color(0xFF0EA5A8);
  static const Color blue = Color(0xFF3182CE);
  static const Color purple = Color(0xFF8264C8);
  static const Color green = Color(0xFF10B981);
  static const Color background = Color(0xFFF0F4F8);
  static const Color cream = Color(0xFFFFFAF1);
  static const Color surface = Colors.white;
  static const Color ink = Color(0xFF0F172A);
  static const Color muted = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFE2E8F0);

  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Handicrafts',
    'Textiles',
    'Art',
    'Jewellery',
  ];

  // ============================================================
  // COMMUNITY POSTS
  // ============================================================

  final List<Map<String, dynamic>> communityPosts = [
    {
      'title': 'The Stories Behind Our Forts',
      'author': 'Heritage Explorer',
      'description':
          'Discover forgotten stories, remarkable architecture and the history of Maharashtra’s magnificent forts.',
      'image': 'assets/images/fort.jpeg',
      'tag': 'History',
      'icon': Icons.account_balance_rounded,
      'color': primary,
    },
    {
      'title': 'Sunrise at Sinhagad',
      'author': 'Travel Diaries',
      'description':
          'Explore the hills, scenic trails and timeless landscapes surrounding historic Sinhagad.',
      'image': 'assets/images/sunrise.jpeg',
      'tag': 'Travel',
      'icon': Icons.landscape_rounded,
      'color': teal,
    },
    {
      'title': 'Keeping Traditions Alive',
      'author': 'Culture Connect',
      'description':
          'Meet the people preserving traditional art, local customs and cultural practices.',
      'image': 'assets/images/tradition.jpeg',
      'tag': 'Culture',
      'icon': Icons.diversity_3_rounded,
      'color': purple,
    },
  ];

  // ============================================================
  // MARKETPLACE PRODUCTS
  // ============================================================

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Warli Art',
      'category': 'Art',
      'price': '₹850',
      'description': 'Traditional tribal artwork',
      'image': 'assets/images/warli2.jpeg',
      'icon': Icons.brush_rounded,
      'color': primary,
    },
    {
      'name': 'Paithani Textile',
      'category': 'Textiles',
      'price': '₹2,500',
      'description': 'Handwoven traditional textile',
      'image': 'assets/images/paithani2.jpeg',
      'icon': Icons.checkroom_rounded,
      'color': purple,
    },
    {
      'name': 'Heritage Painting',
      'category': 'Art',
      'price': '₹1,200',
      'description': 'Handcrafted Indian artwork',
      'image': 'assets/images/painting.jpeg',
      'icon': Icons.palette_rounded,
      'color': teal,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // FILTERED DATA
  // ============================================================

  List<Map<String, dynamic>> get filteredPosts {
    final query = searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return communityPosts;
    }

    return communityPosts.where((post) {
      return post['title'].toString().toLowerCase().contains(query) ||
          post['author'].toString().toLowerCase().contains(query) ||
          post['tag'].toString().toLowerCase().contains(query) ||
          post['description'].toString().toLowerCase().contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get filteredProducts {
    final query = searchQuery.trim().toLowerCase();

    return products.where((product) {
      final matchesCategory = selectedCategory == 'All' ||
          product['category'] == selectedCategory;

      final matchesSearch = query.isEmpty ||
          product['name'].toString().toLowerCase().contains(query) ||
          product['category'].toString().toLowerCase().contains(query) ||
          product['description'].toString().toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _goBack() {
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }

    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      navigator.pop();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No previous page is available.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void openCommunity() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CommunityScreen(),
      ),
    );
  }

  void openMarketplace() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MarketplaceScreen(),
      ),
    );
  }

  // ============================================================
  // IMAGE HELPER
  // ============================================================

  Widget heritageImage(
    String path, {
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Color fallbackColor = forest,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        path,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: height,
            width: width,
            color: fallbackColor.withValues(alpha: 0.09),
            alignment: Alignment.center,
            child: Icon(
              Icons.account_balance_rounded,
              size: 42,
              color: fallbackColor,
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // MAIN SCREEN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1000;
          final horizontalPadding = isDesktop
              ? 44.0
              : constraints.maxWidth >= 600
                  ? 30.0
                  : 18.0;

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1440),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    22,
                    horizontalPadding,
                    38,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBar(),
                      const SizedBox(height: 25),
                      _buildHero(isDesktop),
                      const SizedBox(height: 28),
                      _buildQuickStats(),
                      const SizedBox(height: 25),
                      _buildSearchBar(),
                      const SizedBox(height: 34),
                      _buildSectionHeading(
                        eyebrow: 'YOUR PEOPLE, YOUR STORIES',
                        title: 'Heritage Community',
                        subtitle:
                            'Real stories. Shared discoveries. A community that keeps culture alive.',
                        actionLabel: 'Explore all',
                        onAction: openCommunity,
                        accent: primary,
                      ),
                      const SizedBox(height: 18),
                      _buildCommunityCards(isDesktop),
                      const SizedBox(height: 38),
                      _buildMarketplaceHeading(),
                      const SizedBox(height: 17),
                      _buildCategoryFilters(),
                      const SizedBox(height: 17),
                      _buildProductGrid(isDesktop),
                      const SizedBox(height: 36),
                      _buildNetworkSection(isDesktop),
                      const SizedBox(height: 28),
                      _buildShareBanner(isDesktop),
                      const SizedBox(height: 24),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    return Row(
      children: [
        Material(
          color: forest,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: _goBack,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 47,
              width: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [forestLight, forest],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: forest.withValues(alpha: 0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: gold,
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HERITAGE NETWORK',
                style: TextStyle(
                  color: forest,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Discover • Experience • Preserve',
                style: TextStyle(
                  color: muted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        Material(
          color: surface,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: _showNotifications,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: borderColor),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: forest,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero(bool isDesktop) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF153B31),
            Color(0xFF245744),
            Color(0xFF34735A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.18),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              right: -35,
              top: -55,
              child: Icon(
                Icons.account_balance_rounded,
                size: isDesktop ? 300 : 220,
                color: Colors.white.withValues(alpha: 0.045),
              ),
            ),
            Positioned(
              left: -35,
              bottom: -60,
              child: Icon(
                Icons.auto_stories_rounded,
                size: 170,
                color: gold.withValues(alpha: 0.06),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isDesktop ? 38 : 24),
              child: isDesktop
                  ? Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildHeroText(),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          flex: 4,
                          child: _buildHeroImage(),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroText(),
                        const SizedBox(height: 25),
                        _buildHeroImage(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: gold.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: gold.withValues(alpha: 0.4),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: gold,
                size: 15,
              ),
              SizedBox(width: 7),
              Text(
                'CONNECT THROUGH CULTURE',
                style: TextStyle(
                  color: gold,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Where heritage\nbrings us together.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            height: 1.13,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Meet passionate explorers, discover local artisans, '
          'and keep our cultural stories alive. Every connection '
          'helps our traditions travel into the future.',
          style: TextStyle(
            color: Color(0xFFDCEBE2),
            fontSize: 13,
            height: 1.75,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedButton.icon(
              onPressed: openCommunity,
              icon: const Icon(
                Icons.people_alt_rounded,
                size: 18,
              ),
              label: const Text('Join community'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 3,
                shadowColor: primary.withValues(alpha: 0.3),
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: openMarketplace,
              icon: const Icon(
                Icons.storefront_rounded,
                size: 18,
              ),
              label: const Text('Explore crafts'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.45),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: AspectRatio(
            aspectRatio: 1.45,
            child: heritageImage(
              'assets/images/openbook.jpeg',
              fit: BoxFit.cover,
              fallbackColor: gold,
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  forest.withValues(alpha: 0.45),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: forest.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: gold.withValues(alpha: 0.4),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.auto_stories_rounded,
                  color: gold,
                  size: 25,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Every story matters',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Keep traditions alive, together.',
                        style: TextStyle(
                          color: Color(0xFFDCEBE2),
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
      ],
    );
  }

  // ============================================================
  // QUICK STATS
  // ============================================================

  Widget _buildQuickStats() {
    final stats = [
      {
        'icon': Icons.menu_book_rounded,
        'title': 'Stories',
        'subtitle': 'Share knowledge',
        'color': primary,
      },
      {
        'icon': Icons.palette_rounded,
        'title': 'Artisans',
        'subtitle': 'Celebrate craft',
        'color': purple,
      },
      {
        'icon': Icons.public_rounded,
        'title': 'Culture',
        'subtitle': 'Connect deeply',
        'color': teal,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 440;

        return Row(
          children: stats.map((stat) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  right: stat == stats.last ? 0 : 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 8 : 13,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: ink.withValues(alpha: 0.025),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: (stat['color'] as Color)
                            .withValues(alpha: 0.11),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Icon(
                        stat['icon'] as IconData,
                        color: stat['color'] as Color,
                        size: 19,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      stat['title'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      stat['subtitle'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: muted,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: ink.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search stories, artisans, crafts...',
          hintStyle: const TextStyle(
            color: muted,
            fontSize: 13,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: forestLight,
            size: 23,
          ),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      searchQuery = '';
                    });
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: muted,
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.travel_explore_rounded,
                    color: primary,
                  ),
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION HEADING
  // ============================================================

  Widget _buildSectionHeading({
    required String eyebrow,
    required String title,
    required String subtitle,
    required String actionLabel,
    required VoidCallback onAction,
    Color accent = primary,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 4,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              eyebrow,
              style: TextStyle(
                color: accent,
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: forest,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: muted,
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: accent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 8,
                ),
              ),
              child: Text(
                actionLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // COMMUNITY CARDS
  // ============================================================

  Widget _buildCommunityCards(bool isDesktop) {
    final posts = filteredPosts;

    if (posts.isEmpty) {
      return _buildEmptyState(
        icon: Icons.search_off_rounded,
        title: 'No stories found',
        message: 'Try another search term to discover more stories.',
      );
    }

    if (isDesktop) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: posts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          mainAxisExtent: 345,
        ),
        itemBuilder: (context, index) {
          return _buildPostCard(posts[index]);
        },
      );
    }

    return SizedBox(
      height: 345,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: posts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 275,
            child: _buildPostCard(posts[index]),
          );
        },
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    final accent = post['color'] as Color;

    return Material(
      color: surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: openCommunity,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: ink.withValues(alpha: 0.045),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    heritageImage(
                      post['image'] as String,
                      width: double.infinity,
                      height: 158,
                      fallbackColor: accent,
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.24),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: surface,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: ink.withValues(alpha: 0.08),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              post['icon'] as IconData,
                              size: 13,
                              color: accent,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              post['tag'] as String,
                              style: TextStyle(
                                color: accent,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_outward_rounded,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 14, 15, 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['title'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: ink,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Expanded(
                          child: Text(
                            post['description'] as String,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: muted,
                              fontSize: 11,
                              height: 1.55,
                            ),
                          ),
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor:
                                  accent.withValues(alpha: 0.12),
                              child: Icon(
                                Icons.person_rounded,
                                color: accent,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                post['author'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: muted,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.favorite_border_rounded,
                              color: accent,
                              size: 19,
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
      ),
    );
  }

  // ============================================================
  // MARKETPLACE HEADING
  // ============================================================

  Widget _buildMarketplaceHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 4,
              decoration: BoxDecoration(
                color: gold,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'CRAFTED WITH CULTURE',
              style: TextStyle(
                color: primaryDark,
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Artisan Marketplace',
                style: TextStyle(
                  color: forest,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: openMarketplace,
              icon: const Icon(
                Icons.storefront_rounded,
                size: 16,
              ),
              label: const Text(
                'Visit store',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Every handmade piece carries a story. Discover crafts and support the artists behind them.',
          style: TextStyle(
            color: muted,
            fontSize: 12,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CATEGORY FILTERS
  // ============================================================

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 43,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                selectedCategory = category;
              });
            },
            backgroundColor: surface,
            selectedColor: forest,
            side: BorderSide(
              color: isSelected ? forest : borderColor,
            ),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : forest,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            showCheckmark: false,
          );
        },
      ),
    );
  }

  // ============================================================
  // PRODUCT GRID
  // ============================================================

  Widget _buildProductGrid(bool isDesktop) {
    final items = filteredProducts;

    if (items.isEmpty) {
      return _buildEmptyState(
        icon: Icons.storefront_rounded,
        title: 'No products found',
        message: 'Try another category or search term.',
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;

    final crossAxisCount = isDesktop
        ? 4
        : screenWidth >= 600
            ? 3
            : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        mainAxisExtent: 280,
      ),
      itemBuilder: (context, index) {
        return _buildProductCard(items[index]);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final accent = product['color'] as Color;

    return Material(
      color: surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: openMarketplace,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: ink.withValues(alpha: 0.035),
                blurRadius: 13,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    heritageImage(
                      product['image'] as String,
                      width: double.infinity,
                      height: 145,
                      fallbackColor: accent,
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.13),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product['category'] as String,
                          style: TextStyle(
                            color: accent,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        height: 31,
                        width: 31,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          product['icon'] as IconData,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: ink,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: Text(
                            product['description'] as String,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: muted,
                              fontSize: 10,
                              height: 1.45,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product['price'] as String,
                                style: TextStyle(
                                  color: accent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              height: 32,
                              width: 34,
                              decoration: BoxDecoration(
                                color: accent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 18,
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
      ),
    );
  }

  // ============================================================
  // HERITAGE NETWORK
  // ============================================================

  Widget _buildNetworkSection(bool isDesktop) {
    final tiles = [
      {
        'icon': Icons.groups_rounded,
        'title': 'Community',
        'subtitle': 'Share stories and discoveries',
        'color': forest,
        'onTap': openCommunity,
      },
      {
        'icon': Icons.storefront_rounded,
        'title': 'Marketplace',
        'subtitle': 'Support local artisans',
        'color': primary,
        'onTap': openMarketplace,
      },
      {
        'icon': Icons.handshake_rounded,
        'title': 'Collaborate',
        'subtitle': 'Connect over shared interests',
        'color': purple,
        'onTap': () => _showNetworkInfo(
          'Collaborate',
          'Connect with fellow heritage enthusiasts, share ideas and explore opportunities to work together.',
          Icons.handshake_rounded,
          purple,
        ),
      },
      {
        'icon': Icons.volunteer_activism_rounded,
        'title': 'Preserve',
        'subtitle': 'Help keep traditions alive',
        'color': teal,
        'onTap': () => _showNetworkInfo(
          'Preserve heritage',
          'Help document local traditions, promote cultural awareness and encourage future generations to value their heritage.',
          Icons.volunteer_activism_rounded,
          teal,
        ),
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE7F2EB),
            Color(0xFFF4F8F3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFFD3E6D9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 20,
                width: 4,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'BE PART OF SOMETHING MEANINGFUL',
                style: TextStyle(
                  color: primaryDark,
                  fontSize: 10,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          const Text(
            'Your Heritage Network',
            style: TextStyle(
              color: forest,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'More than a platform — a place to celebrate, support and preserve India’s living heritage.',
            style: TextStyle(
              color: muted,
              fontSize: 12,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 850
                  ? 4
                  : constraints.maxWidth >= 480
                      ? 2
                      : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tiles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 145,
                ),
                itemBuilder: (context, index) {
                  final tile = tiles[index];

                  return _buildNetworkTile(
                    icon: tile['icon'] as IconData,
                    title: tile['title'] as String,
                    subtitle: tile['subtitle'] as String,
                    color: tile['color'] as Color,
                    onTap: tile['onTap'] as VoidCallback,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: color.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: ink.withValues(alpha: 0.025),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.11),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 23,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: color.withValues(alpha: 0.65),
                    size: 17,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: forest,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: muted,
                      fontSize: 10,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SHARE BANNER
  // ============================================================

  Widget _buildShareBanner(bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 29 : 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE0533C),
            Color(0xFFC53C2B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: ClipRect(
        child: isDesktop
            ? Row(
                children: [
                  _buildShareIcon(),
                  const SizedBox(width: 18),
                  Expanded(child: _buildShareText()),
                  const SizedBox(width: 18),
                  _buildShareButton(),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShareIcon(),
                  const SizedBox(height: 17),
                  _buildShareText(),
                  const SizedBox(height: 18),
                  _buildShareButton(),
                ],
              ),
      ),
    );
  }

  Widget _buildShareIcon() {
    return Container(
      height: 57,
      width: 57,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.23),
        ),
      ),
      child: const Icon(
        Icons.add_a_photo_rounded,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget _buildShareText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Have a heritage story to share?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 7),
        Text(
          'Your photos, experiences and knowledge can inspire others and help keep our culture alive.',
          style: TextStyle(
            color: Color(0xFFFFE8DC),
            fontSize: 12,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildShareButton() {
    return ElevatedButton.icon(
      onPressed: openCommunity,
      icon: const Icon(
        Icons.edit_rounded,
        size: 17,
      ),
      label: const Text('Share your story'),
      style: ElevatedButton.styleFrom(
        backgroundColor: forest,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor),
        ),
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_rounded,
                color: primary,
                size: 21,
              ),
              SizedBox(width: 8),
              Text(
                'SMRITI RAKSHAK',
                style: TextStyle(
                  color: forest,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 9),
          Text(
            'Discover • Experience • Preserve',
            style: TextStyle(
              color: muted,
              fontSize: 11,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Keeping our stories alive for generations to come.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: muted,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(19),
            ),
            child: Icon(
              icon,
              color: primary,
              size: 30,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            title,
            style: const TextStyle(
              color: forest,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: muted,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NOTIFICATIONS
  // ============================================================

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: background,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 43,
                      width: 43,
                      decoration: BoxDecoration(
                        color: gold.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.notifications_active_rounded,
                        color: primary,
                        size: 23,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          color: forest,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: borderColor),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: primary,
                        size: 25,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to Heritage Network!',
                              style: TextStyle(
                                color: forest,
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              'Explore cultural stories, discover artisans and connect with fellow heritage lovers.',
                              style: TextStyle(
                                color: muted,
                                fontSize: 12,
                                height: 1.6,
                              ),
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
        );
      },
    );
  }

  // ============================================================
  // NETWORK INFORMATION
  // ============================================================

  void _showNetworkInfo(
    String title,
    String description,
    IconData icon,
    Color accent,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 25, 24, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Icon(
                    icon,
                    color: accent,
                    size: 29,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  title,
                  style: const TextStyle(
                    color: forest,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    color: muted,
                    fontSize: 14,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: forest,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: const Text(
                      'Got it',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
