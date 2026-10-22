
import 'package:flutter/material.dart';

import 'community_screen.dart';
import 'marketplace_screen.dart';

class ConnectScreen extends StatefulWidget {
  // Optional callback for returning to the homepage when this
  // screen is displayed inside a homepage/bottom-navigation layout.
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

  static const Color primary = Color(0xFFC94F36);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE8B957);
  static const Color forest = Color(0xFF263D32);
  static const Color forestLight = Color(0xFF385745);
  static const Color sandstone = Color(0xFFE9DDC8);
  static const Color cream = Color(0xFFF7F0E3);
  static const Color ink = Color(0xFF292C25);
  static const Color muted = Color(0xFF6F7165);

  // ============================================================
  // STATE
  // ============================================================

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
          'Discover the forgotten stories, architecture and history of Maharashtra’s magnificent forts.',
      'image': 'assets/images/fort.jpeg',
      'tag': 'History',
      'icon': Icons.account_balance_rounded,
    },
    {
      'title': 'Sunrise at Sinhagad',
      'author': 'Travel Diaries',
      'description':
          'A beautiful morning exploring the hills, trails and historic landscapes of Sinhagad.',
      'image': 'assets/images/sunrise.jpeg',
      'tag': 'Travel',
      'icon': Icons.landscape_rounded,
    },
    {
      'title': 'Keeping Traditions Alive',
      'author': 'Culture Connect',
      'description':
          'Meet the people preserving traditional art, local customs and cultural practices.',
      'image': 'assets/images/tradition.jpeg',
      'tag': 'Culture',
      'icon': Icons.diversity_3_rounded,
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
    },
    {
      'name': 'Paithani Textile',
      'category': 'Textiles',
      'price': '₹2,500',
      'description': 'Handwoven traditional textile',
      'image': 'assets/images/paithani2.jpeg',
      'icon': Icons.checkroom_rounded,
    },
    {
      'name': 'Heritage Painting',
      'category': 'Art',
      'price': '₹1,200',
      'description': 'Handcrafted Indian artwork',
      'image': 'assets/images/painting.jpeg',
      'icon': Icons.palette_rounded,
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
    if (searchQuery.trim().isEmpty) {
      return communityPosts;
    }

    final query = searchQuery.trim().toLowerCase();

    return communityPosts.where((post) {
      final title = post['title'].toString().toLowerCase();
      final author = post['author'].toString().toLowerCase();
      final tag = post['tag'].toString().toLowerCase();

      return title.contains(query) ||
          author.contains(query) ||
          tag.contains(query);
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
  // NAVIGATION - BACK BUTTON FIX
  // ============================================================

  void _goBack() {
    // Case 1: ConnectScreen is inside the homepage or an
    // IndexedStack. Ask the parent to return to Home.
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }

    // Case 2: ConnectScreen was opened using Navigator.push.
    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      navigator.pop();
      return;
    }

    // Case 3: There is no parent callback and no route to pop.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'No previous page is available.',
        ),
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
            color: sandstone,
            alignment: Alignment.center,
            child: const Icon(
              Icons.account_balance_rounded,
              size: 38,
              color: forest,
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
      color: cream,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1000;
          final horizontalPadding = isDesktop ? 44.0 : 20.0;

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1440),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    24,
                    horizontalPadding,
                    40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBar(),
                      const SizedBox(height: 28),
                      _buildHero(isDesktop),
                      const SizedBox(height: 32),
                      _buildSearchBar(),
                      const SizedBox(height: 34),
                      _buildSectionHeading(
                        eyebrow: 'YOUR PEOPLE, YOUR STORIES',
                        title: 'Heritage Community',
                        subtitle:
                            'Share discoveries, exchange stories and learn from fellow explorers.',
                        actionLabel: 'Explore community',
                        onAction: openCommunity,
                      ),
                      const SizedBox(height: 18),
                      _buildCommunityCards(isDesktop),
                      const SizedBox(height: 38),
                      _buildMarketplaceHeading(),
                      const SizedBox(height: 18),
                      _buildCategoryFilters(),
                      const SizedBox(height: 18),
                      _buildProductGrid(isDesktop),
                      const SizedBox(height: 38),
                      _buildNetworkSection(isDesktop),
                      const SizedBox(height: 30),
                      _buildShareBanner(isDesktop),
                      const SizedBox(height: 22),
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
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: _goBack,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: forest,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: gold,
                size: 25,
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
                  fontSize: 15,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 3),
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
          color: Colors.transparent,
          child: InkWell(
            onTap: _showNotifications,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: sandstone),
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
        color: forest,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.13),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              right: -25,
              top: -30,
              child: Icon(
                Icons.account_balance_rounded,
                size: isDesktop ? 280 : 190,
                color: Colors.white.withValues(alpha: 0.045),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isDesktop ? 38 : 25),
              child: isDesktop
                  ? Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildHeroText(),
                        ),
                        const SizedBox(width: 30),
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
                        const SizedBox(height: 24),
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
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: gold.withValues(alpha: 0.15),
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
                  fontWeight: FontWeight.w800,
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
            color: cream,
            fontSize: 34,
            height: 1.13,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Meet passionate explorers, discover local artisans, '
          'and keep our cultural stories alive.',
          style: TextStyle(
            color: Color(0xFFD9DDCF),
            fontSize: 14,
            height: 1.7,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
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
                foregroundColor: cream,
                side: BorderSide(
                  color: cream.withValues(alpha: 0.5),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
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
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 1.45,
            child: heritageImage(
              'assets/images/openbook.jpeg',
              fit: BoxFit.cover,
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
              color: forest.withValues(alpha: 0.91),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: gold.withValues(alpha: 0.4),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.auto_stories_rounded,
                  color: gold,
                  size: 23,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Every story matters',
                        style: TextStyle(
                          color: cream,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Keep traditions alive, together.',
                        style: TextStyle(
                          color: Color(0xFFD9DDCF),
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
  // SEARCH
  // ============================================================

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: sandstone),
        boxShadow: [
          BoxShadow(
            color: ink.withValues(alpha: 0.035),
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
            color: forest,
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
              : const Icon(
                  Icons.tune_rounded,
                  color: primary,
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            color: primary,
            fontSize: 10,
            letterSpacing: 1.7,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
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
            const SizedBox(width: 8),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
              child: Text(
                actionLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
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
        message: 'Try another search term.',
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
          mainAxisExtent: 330,
        ),
        itemBuilder: (context, index) {
          return _buildPostCard(posts[index]);
        },
      );
    }

    return SizedBox(
      height: 330,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: posts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 270,
            child: _buildPostCard(posts[index]),
          );
        },
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: sandstone),
        boxShadow: [
          BoxShadow(
            color: ink.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
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
                  post['image'],
                  width: double.infinity,
                  height: 150,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: cream,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      post['tag'],
                      style: const TextStyle(
                        color: forest,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: forest,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Expanded(
                      child: Text(
                        post['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 11,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_circle_rounded,
                          size: 17,
                          color: primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            post['author'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: muted,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: primary,
                          size: 18,
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
    );
  }

  // ============================================================
  // MARKETPLACE
  // ============================================================

  Widget _buildMarketplaceHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CRAFTED WITH CULTURE',
          style: TextStyle(
            color: primary,
            fontSize: 10,
            letterSpacing: 1.7,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
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
            TextButton(
              onPressed: openMarketplace,
              child: const Text(
                'Visit store →',
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Discover handmade treasures and support local artisans.',
          style: TextStyle(
            color: muted,
            fontSize: 12,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 42,
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
            backgroundColor: Colors.white,
            selectedColor: forest,
            side: BorderSide(
              color: isSelected ? forest : sandstone,
            ),
            labelStyle: TextStyle(
              color: isSelected ? cream : forest,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
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
        mainAxisExtent: 265,
      ),
      itemBuilder: (context, index) {
        return _buildProductCard(items[index]);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: sandstone),
        boxShadow: [
          BoxShadow(
            color: ink.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                heritageImage(
                  product['image'],
                  width: double.infinity,
                  height: 135,
                ),
                Positioned(
                  top: 9,
                  left: 9,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: cream,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product['category'],
                      style: const TextStyle(
                        color: forest,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 11, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: forest,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: Text(
                        product['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 10,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product['price'],
                            style: const TextStyle(
                              color: primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Material(
                          color: forest,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: openMarketplace,
                            borderRadius: BorderRadius.circular(10),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: cream,
                                size: 17,
                              ),
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
        'color': forestLight,
        'onTap': () => _showNetworkInfo(
          'Collaborate',
          'Connect with fellow heritage enthusiasts, '
              'share ideas and explore opportunities to work together.',
          Icons.handshake_rounded,
        ),
      },
      {
        'icon': Icons.volunteer_activism_rounded,
        'title': 'Preserve',
        'subtitle': 'Help keep traditions alive',
        'color': primaryDark,
        'onTap': () => _showNetworkInfo(
          'Preserve heritage',
          'Help document local traditions, promote cultural awareness '
              'and encourage future generations to value their heritage.',
          Icons.volunteer_activism_rounded,
        ),
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: sandstone.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: sandstone),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BE PART OF SOMETHING MEANINGFUL',
            style: TextStyle(
              color: primary,
              fontSize: 10,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your Heritage Network',
            style: TextStyle(
              color: forest,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore different ways to connect with India’s living heritage.',
            style: TextStyle(
              color: muted,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tiles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 4 : 2,
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
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: sandstone),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
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
      padding: EdgeInsets.all(isDesktop ? 28 : 22),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(24),
      ),
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
    );
  }

  Widget _buildShareIcon() {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
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
          'Your photos, experiences and knowledge can inspire others.',
          style: TextStyle(
            color: Color(0xFFFFE8DC),
            fontSize: 12,
            height: 1.5,
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
        foregroundColor: cream,
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
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: sandstone),
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
                size: 19,
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
          SizedBox(height: 8),
          Text(
            'Discover • Experience • Preserve',
            style: TextStyle(
              color: muted,
              fontSize: 11,
            ),
          ),
          SizedBox(height: 5),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: sandstone),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primary,
            size: 35,
          ),
          const SizedBox(height: 10),
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
      backgroundColor: cream,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
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
                      icon: const Icon(
                        Icons.close_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: sandstone),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: primary,
                        size: 24,
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
                            SizedBox(height: 6),
                            Text(
                              'Explore cultural stories, discover artisans '
                              'and connect with fellow heritage lovers.',
                              style: TextStyle(
                                color: muted,
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
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
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
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
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    color: forest.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: forest,
                    size: 28,
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: forest,
                      foregroundColor: cream,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: const Text('Got it'),
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
