
import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // ============================================================
  // HERITAGE THEME
  // ============================================================

  static const Color primary = Color(0xFFE0533C);
  static const Color primaryDark = Color(0xFFA6321F);
  static const Color gold = Color(0xFFF2A922);
  static const Color forest = Color(0xFF263D32);
  static const Color forestLight = Color(0xFF385745);
  static const Color sandstone = Color(0xFFE9DDC8);
  static const Color cream = Color(0xFFF7F0E3);
  static const Color background = Color(0xFFF0F4F8);
  static const Color surface = Color(0xFFFFFDF8);
  static const Color textColor = Color(0xFF0F172A);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color teal = Color(0xFF0EA5E9);
  static const Color green = Color(0xFF10B981);

  final TextEditingController searchController = TextEditingController();
  final TextEditingController postTitleController = TextEditingController();
  final TextEditingController postDescriptionController =
      TextEditingController();

  String selectedCategory = 'All';
  String selectedPostType = 'Stories';

  final List<String> categories = [
    'All',
    'Stories',
    'Questions',
    'Travel',
    'Heritage',
    'Photography',
  ];

  final Map<String, List<String>> postComments = {};
  final Set<String> savedPosts = {};

  final List<Map<String, dynamic>> posts = [
    {
      'id': 'post_1',
      'category': 'Travel',
      'label': 'TRAVEL JOURNAL',
      'title': "A sunrise I'll never forget at Sinhagad",
      'description':
          'Reached the fort before sunrise and discovered a completely different side of the place. Golden skies, quiet trails and a view worth every step.',
      'author': 'Kabir Sharma',
      'time': '2h ago',
      'color': gold,
      'icon': Icons.landscape_rounded,
      'likes': 203,
      'comments': 31,
      'liked': false,
    },
    {
      'id': 'post_2',
      'category': 'Questions',
      'label': 'ASK THE COMMUNITY',
      'title': 'Best heritage places for a weekend trip?',
      'description':
          'Looking for lesser-known historical places around Maharashtra that are worth exploring. Share your hidden gems!',
      'author': 'Meera Joshi',
      'time': '4h ago',
      'color': teal,
      'icon': Icons.help_outline_rounded,
      'likes': 86,
      'comments': 27,
      'liked': false,
    },
    {
      'id': 'post_3',
      'category': 'Heritage',
      'label': 'LIVING HERITAGE',
      'title': 'The story behind our village festival',
      'description':
          'Sharing a beautiful tradition that has been passed down through generations in my hometown. Some stories deserve to live forever.',
      'author': 'Riya Patil',
      'time': '6h ago',
      'color': green,
      'icon': Icons.auto_stories_rounded,
      'likes': 157,
      'comments': 22,
      'liked': false,
    },
    {
      'id': 'post_4',
      'category': 'Photography',
      'label': 'VISUAL STORIES',
      'title': 'Old architecture hiding in plain sight',
      'description':
          'A few photographs from my walk through an old heritage neighbourhood. Every doorway seems to hold a little piece of history.',
      'author': 'Arjun Kulkarni',
      'time': 'Yesterday',
      'color': primary,
      'icon': Icons.camera_alt_rounded,
      'likes': 312,
      'comments': 46,
      'liked': false,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    final query = searchController.text.trim().toLowerCase();

    return posts.where((post) {
      final matchesCategory =
          selectedCategory == 'All' ||
          post['category'] == selectedCategory;

      final matchesSearch = query.isEmpty ||
          post['title'].toString().toLowerCase().contains(query) ||
          post['description'].toString().toLowerCase().contains(query) ||
          post['author'].toString().toLowerCase().contains(query) ||
          post['category'].toString().toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    postTitleController.dispose();
    postDescriptionController.dispose();
    super.dispose();
  }

  // ============================================================
  // BACK NAVIGATION
  // ============================================================

  void _goBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      _showMessage('You are already on the first page.');
    }
  }

  // ============================================================
  // MAIN SCREEN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 1000;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              constraints.maxWidth >= 900 ? 36 : 18,
              26,
              constraints.maxWidth >= 900 ? 36 : 18,
              110,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1240),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHero(wide),
                    const SizedBox(height: 22),
                    _buildStats(),
                    const SizedBox(height: 32),
                    _buildSearch(),
                    const SizedBox(height: 15),
                    _buildCategories(),
                    const SizedBox(height: 30),
                    if (wide)
                      _buildDesktopContent()
                    else
                      _buildMobileContent(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreatePost,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 5,
        icon: const Icon(Icons.edit_rounded),
        label: const Text(
          'Create a post',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: forest,
      foregroundColor: cream,
      elevation: 0,
      toolbarHeight: 76,
      titleSpacing: 8,
      leading: IconButton(
        tooltip: 'Go back',
        onPressed: _goBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      title: Row(
        children: [
          Container(
            width: 41,
            height: 41,
            decoration: BoxDecoration(
              color: gold.withOpacity(0.14),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: gold.withOpacity(0.45)),
            ),
            child: const Icon(
              Icons.account_balance_rounded,
              color: gold,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Smriti Rakshak',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: cream,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'COMMUNITY & CULTURE',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 1.3,
                    color: Color(0xFFD8CDB8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color(0xFF9BC28A),
                    size: 8,
                  ),
                  SizedBox(width: 7),
                  Text(
                    'Explore together',
                    style: TextStyle(
                      fontSize: 10,
                      color: cream,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
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

  Widget _buildHero(bool wide) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(wide ? 38 : 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF20372C), Color(0xFF3D6047)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: gold.withOpacity(0.32)),
        boxShadow: [
          BoxShadow(
            color: forest.withOpacity(0.12),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -30,
            child: Icon(
              Icons.account_balance_rounded,
              size: wide ? 215 : 145,
              color: Colors.white.withOpacity(0.045),
            ),
          ),
          Positioned(
            right: wide ? 175 : 95,
            top: 0,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 22,
              color: gold.withOpacity(0.45),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: gold.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: gold.withOpacity(0.4)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, color: gold, size: 13),
                    SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        'A COMMUNITY ROOTED IN HERITAGE',
                        style: TextStyle(
                          color: gold,
                          fontSize: 9,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Every place has\na story.\nWhat’s yours?',
                style: TextStyle(
                  color: cream,
                  fontSize: wide ? 39 : 29,
                  height: 1.17,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 13),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: const Text(
                  'Discover forgotten places, share meaningful memories, '
                  'and connect with people who believe our heritage '
                  'deserves to live on.',
                  style: TextStyle(
                    color: Color(0xFFD8E0D5),
                    fontSize: 12,
                    height: 1.8,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 9,
                runSpacing: 9,
                children: [
                  _heroTag(Icons.auto_stories_rounded, 'Share stories'),
                  _heroTag(Icons.travel_explore_rounded, 'Find hidden gems'),
                  _heroTag(Icons.diversity_3_rounded, 'Meet explorers'),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: _showCreatePost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: forest,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  icon: const Icon(Icons.edit_rounded, size: 17),
                  label: const Text(
                    'Share your story',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.13)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: gold, size: 14),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: cream,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMMUNITY STATS
  // ============================================================

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: sandstone),
        boxShadow: [
          BoxShadow(
            color: forest.withOpacity(0.035),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          _statItem(Icons.auto_stories_rounded, '${posts.length}', 'Stories'),
          _statDivider(),
          _statItem(
            Icons.favorite_rounded,
            '${posts.fold<int>(0, (sum, post) => sum + (post['likes'] as int))}',
            'Appreciations',
          ),
          _statDivider(),
          _statItem(Icons.people_alt_rounded, '4', 'Explorers'),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: primary, size: 19),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: forest,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: secondaryText,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statDivider() {
    return Container(
      height: 45,
      width: 1,
      color: sandstone,
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Container(
      height: 57,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: sandstone),
        boxShadow: [
          BoxShadow(
            color: forest.withOpacity(0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(
          color: textColor,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          hintText: 'Search stories, places, people...',
          hintStyle: const TextStyle(
            color: secondaryText,
            fontSize: 12,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: forestLight,
            size: 22,
          ),
          suffixIcon: searchController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 19,
                    color: secondaryText,
                  ),
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY FILTERS
  // ============================================================

  Widget _buildCategories() {
    return SizedBox(
      height: 43,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: categories.map((category) {
          final active = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 9),
            child: ChoiceChip(
              label: Text(category),
              selected: active,
              onSelected: (_) {
                setState(() => selectedCategory = category);
              },
              selectedColor: forest,
              backgroundColor: surface,
              showCheckmark: false,
              side: BorderSide(
                color: active ? forest : sandstone,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              labelStyle: TextStyle(
                color: active ? cream : textColor,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================
  // RESPONSIVE LAYOUTS
  // ============================================================

  Widget _buildMobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTrendingCard(),
        const SizedBox(height: 30),
        _buildFeed(),
        const SizedBox(height: 32),
        _buildPeopleSection(),
        const SizedBox(height: 25),
        _buildCommunityNote(),
      ],
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFeed(),
              const SizedBox(height: 30),
              _buildPeopleSection(),
            ],
          ),
        ),
        const SizedBox(width: 27),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildTrendingCard(),
              const SizedBox(height: 22),
              _buildCommunityNote(),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TRENDING TOPIC
  // ============================================================

  Widget _buildTrendingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: gold.withOpacity(0.65)),
        boxShadow: [
          BoxShadow(
            color: forest.withOpacity(0.045),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: gold.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      size: 15,
                      color: primaryDark,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'COMMUNITY PICK',
                      style: TextStyle(
                        color: primaryDark,
                        fontSize: 9,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.auto_awesome_rounded,
                color: gold,
                size: 21,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'One place.\nA thousand stories.',
            style: TextStyle(
              color: forest,
              fontSize: 24,
              height: 1.2,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'What is one heritage place everyone should experience at least once?',
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              height: 1.6,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 9),
          const Text(
            'Tell us about a forgotten fort, an ancient temple, or a living tradition that stayed with you.',
            style: TextStyle(
              color: secondaryText,
              fontSize: 12,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: sandstone),
          const SizedBox(height: 9),
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: forest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.people_alt_rounded,
                  color: gold,
                  size: 19,
                ),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Smriti Community',
                      style: TextStyle(
                        color: forest,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'A question for every explorer',
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.favorite_rounded, color: primary, size: 16),
              const SizedBox(width: 5),
              const Text(
                '486',
                style: TextStyle(
                  color: textColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMMUNITY FEED
  // ============================================================

  Widget _buildFeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          icon: Icons.explore_rounded,
          title: 'Community stories',
          action: '${filteredPosts.length} posts',
        ),
        const SizedBox(height: 7),
        const Text(
          'Little discoveries. Big stories. Shared history.',
          style: TextStyle(
            color: secondaryText,
            fontSize: 11,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 19),
        if (filteredPosts.isEmpty)
          _buildEmptyState()
        else
          ...filteredPosts.map(
            (post) => Padding(
              key: ValueKey(post['id']),
              padding: const EdgeInsets.only(bottom: 16),
              child: _CommunityFeedCard(
                post: post,
                isSaved: savedPosts.contains(post['id'].toString()),
                onLike: () => _toggleLike(post),
                onComment: () => _showComments(post),
                onSave: () => _toggleSave(post),
                onReport: () => _showMessage(
                  'Report feature is not connected yet.',
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _sectionHeader({
    required IconData icon,
    required String title,
    required String action,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: forest,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: gold, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: forest,
              letterSpacing: -0.3,
            ),
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: primary,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: sandstone),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.travel_explore_rounded,
            size: 46,
            color: forestLight,
          ),
          SizedBox(height: 14),
          Text(
            'No stories found',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: forest,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try another search or explore a different category.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: secondaryText,
              fontSize: 12,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PEOPLE TO DISCOVER
  // ============================================================

  Widget _buildPeopleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          icon: Icons.diversity_3_rounded,
          title: 'Meet the explorers',
          action: 'Discover people',
        ),
        const SizedBox(height: 8),
        const Text(
          'Connect with people who love discovering our past.',
          style: TextStyle(
            color: secondaryText,
            fontSize: 11,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 17),
        SizedBox(
          height: 178,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              _PersonCard(
                name: 'Aarav',
                role: 'Heritage Explorer',
                icon: Icons.explore_rounded,
                color: primary,
              ),
              _PersonCard(
                name: 'Meera',
                role: 'Travel Creator',
                icon: Icons.camera_alt_rounded,
                color: teal,
              ),
              _PersonCard(
                name: 'Riya',
                role: 'Culture Enthusiast',
                icon: Icons.auto_stories_rounded,
                color: gold,
              ),
              _PersonCard(
                name: 'Kabir',
                role: 'History Lover',
                icon: Icons.history_edu_rounded,
                color: green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // COMMUNITY NOTE
  // ============================================================

  Widget _buildCommunityNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [forest, forestLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: gold.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: forest.withOpacity(0.09),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.volunteer_activism_rounded,
            color: gold,
            size: 30,
          ),
          SizedBox(height: 17),
          Text(
            'Our past deserves a future.',
            style: TextStyle(
              color: cream,
              fontSize: 21,
              fontWeight: FontWeight.w900,
              height: 1.25,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Every memory, photograph and local story helps future generations connect with our shared past.',
            style: TextStyle(
              color: Color(0xFFD8DCCF),
              fontSize: 12,
              height: 1.8,
            ),
          ),
          SizedBox(height: 20),
          Divider(color: Colors.white24),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.circle, size: 7, color: gold),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'DISCOVER  •  EXPERIENCE  •  PRESERVE',
                  style: TextStyle(
                    color: gold,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LIKES AND SAVED POSTS
  // ============================================================

  void _toggleLike(Map<String, dynamic> post) {
    setState(() {
      final currentlyLiked = post['liked'] as bool;

      post['liked'] = !currentlyLiked;
      post['likes'] =
          (post['likes'] as int) + (currentlyLiked ? -1 : 1);
    });
  }

  void _toggleSave(Map<String, dynamic> post) {
    final id = post['id'].toString();

    setState(() {
      if (savedPosts.contains(id)) {
        savedPosts.remove(id);
      } else {
        savedPosts.add(id);
      }
    });

    _showMessage(
      savedPosts.contains(id)
          ? 'Post saved!'
          : 'Post removed from saved.',
    );
  }

  // ============================================================
  // COMMENTS
  // ============================================================

  void _showComments(Map<String, dynamic> post) {
    final controller = TextEditingController();
    final postId = post['id'].toString();

    postComments.putIfAbsent(postId, () => <String>[]);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, updateSheet) {
            final comments = postComments[postId]!;

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.82,
                ),
                padding: const EdgeInsets.fromLTRB(22, 15, 22, 24),
                decoration: const BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(27),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 5,
                        decoration: BoxDecoration(
                          color: sandstone,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Join the conversation',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        color: forest,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post['title'].toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: secondaryText,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(color: sandstone),
                    Flexible(
                      child: comments.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(25),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      size: 35,
                                      color: forestLight,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Start the conversation.',
                                      style: TextStyle(
                                        color: secondaryText,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const CircleAvatar(
                                    backgroundColor: forest,
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: cream,
                                    ),
                                  ),
                                  title: Text(
                                    comments[index],
                                    style: const TextStyle(
                                      color: textColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            textCapitalization:
                                TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              filled: true,
                              fillColor: surface,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 13,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: sandstone),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: sandstone),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: forest),
                              ),
                            ),
                            onSubmitted: (_) => _addComment(
                              post,
                              postId,
                              controller,
                              updateSheet,
                            ),
                          ),
                        ),
                        const SizedBox(width: 9),
                        Container(
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: IconButton(
                            onPressed: () => _addComment(
                              post,
                              postId,
                              controller,
                              updateSheet,
                            ),
                            icon: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(controller.dispose);
  }

  void _addComment(
    Map<String, dynamic> post,
    String postId,
    TextEditingController controller,
    StateSetter updateSheet,
  ) {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      postComments.putIfAbsent(postId, () => <String>[]);
      postComments[postId]!.add(text);
      post['comments'] = (post['comments'] as int) + 1;
    });

    updateSheet(() {});
    controller.clear();
  }

  // ============================================================
  // CREATE POST
  // ============================================================

  void _showCreatePost() {
    postTitleController.clear();
    postDescriptionController.clear();
    selectedPostType = 'Stories';

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, updateSheet) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.88,
                ),
                decoration: const BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(27),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(23, 15, 23, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 42,
                          height: 5,
                          decoration: BoxDecoration(
                            color: sandstone,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Share with the community',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: forest,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your memories help keep our heritage alive.',
                        style: TextStyle(
                          fontSize: 12,
                          color: secondaryText,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'CHOOSE A CATEGORY',
                        style: TextStyle(
                          fontSize: 10,
                          color: forestLight,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 11),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          'Stories',
                          'Questions',
                          'Travel',
                          'Heritage',
                          'Photography',
                        ].map((type) {
                          final selected = selectedPostType == type;

                          return ChoiceChip(
                            label: Text(type),
                            selected: selected,
                            selectedColor: forest,
                            backgroundColor: surface,
                            showCheckmark: false,
                            side: BorderSide(
                              color: selected ? forest : sandstone,
                            ),
                            labelStyle: TextStyle(
                              color: selected ? cream : textColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                            onSelected: (_) {
                              updateSheet(() => selectedPostType = type);
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 22),
                      TextField(
                        controller: postTitleController,
                        maxLength: 90,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: _postInputDecoration(
                          label: 'Post title',
                          hint: 'Give your post a title',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: postDescriptionController,
                        maxLines: 4,
                        maxLength: 500,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: _postInputDecoration(
                          label: 'Your story or question',
                          hint: 'Write something for the community...',
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            final title = postTitleController.text.trim();
                            final description =
                                postDescriptionController.text.trim();

                            if (title.isEmpty || description.isEmpty) {
                              ScaffoldMessenger.of(this.context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please enter a title and description.',
                                  ),
                                ),
                              );
                              return;
                            }

                            final category = selectedPostType;
                            final config = _categoryConfig(category);

                            setState(() {
                              posts.insert(0, {
                                'id':
                                    'post_${DateTime.now().microsecondsSinceEpoch}',
                                'category': category,
                                'label': _categoryLabel(category),
                                'title': title,
                                'description': description,
                                'author': 'You',
                                'time': 'Just now',
                                'color': config.$1,
                                'icon': config.$2,
                                'likes': 0,
                                'comments': 0,
                                'liked': false,
                              });

                              selectedCategory = 'All';
                              searchController.clear();
                            });

                            Navigator.of(sheetContext).pop();

                            ScaffoldMessenger.of(this.context).showSnackBar(
                              const SnackBar(
                                content: Text('Your story has been shared!'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.send_rounded, size: 18),
                          label: const Text(
                            'Publish your post',
                            style: TextStyle(fontWeight: FontWeight.w900),
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
      },
    );
  }

  InputDecoration _postInputDecoration({
    required String label,
    required String hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(
        color: secondaryText,
        fontSize: 12,
      ),
      labelStyle: const TextStyle(
        color: forestLight,
        fontSize: 12,
      ),
      filled: true,
      fillColor: surface,
      alignLabelWithHint: true,
      counterStyle: const TextStyle(
        color: secondaryText,
        fontSize: 10,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: sandstone),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: sandstone),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: forest, width: 1.5),
      ),
    );
  }

  // ============================================================
  // CATEGORY HELPERS
  // ============================================================

  String _categoryLabel(String category) {
    switch (category) {
      case 'Stories':
        return 'COMMUNITY STORY';
      case 'Questions':
        return 'ASK THE COMMUNITY';
      case 'Travel':
        return 'TRAVEL JOURNAL';
      case 'Heritage':
        return 'LIVING HERITAGE';
      case 'Photography':
        return 'VISUAL STORIES';
      default:
        return category.toUpperCase();
    }
  }

  (Color, IconData) _categoryConfig(String category) {
    switch (category) {
      case 'Questions':
        return (teal, Icons.help_outline_rounded);
      case 'Travel':
        return (gold, Icons.landscape_rounded);
      case 'Heritage':
        return (green, Icons.auto_stories_rounded);
      case 'Photography':
        return (primary, Icons.camera_alt_rounded);
      default:
        return (forestLight, Icons.edit_rounded);
    }
  }

  // ============================================================
  // MESSAGES
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

// ================================================================
// COMMUNITY POST CARD
// ================================================================

class _CommunityFeedCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onSave;
  final VoidCallback onReport;
  final bool isSaved;

  const _CommunityFeedCard({
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onSave,
    required this.onReport,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    final color = post['color'] as Color;
    final icon = post['icon'] as IconData;
    final liked = post['liked'] as bool;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _CommunityScreenState.surface,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: _CommunityScreenState.sandstone),
        boxShadow: [
          BoxShadow(
            color: _CommunityScreenState.forest.withOpacity(0.045),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.20),
                      color.withOpacity(0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: color.withOpacity(0.18)),
                ),
                child: Icon(icon, color: color, size: 23),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      post['label'].toString(),
                      style: TextStyle(
                        color: color == _CommunityScreenState.gold
                            ? _CommunityScreenState.primaryDark
                            : color,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.9,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '${post['author']}  ·  ${post['time']}',
                      style: const TextStyle(
                        color: _CommunityScreenState.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                tooltip: 'Post options',
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  color: _CommunityScreenState.secondaryText,
                ),
                onSelected: (value) {
                  if (value == 'save') {
                    onSave();
                  } else if (value == 'report') {
                    onReport();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'save',
                    child: Row(
                      children: [
                        Icon(
                          isSaved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          size: 19,
                        ),
                        const SizedBox(width: 9),
                        Text(isSaved ? 'Unsave post' : 'Save post'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'report',
                    child: Row(
                      children: [
                        Icon(Icons.flag_outlined, size: 19),
                        SizedBox(width: 9),
                        Text('Report post'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            post['title'].toString(),
            style: const TextStyle(
              color: _CommunityScreenState.forest,
              fontSize: 17,
              fontWeight: FontWeight.w900,
              height: 1.4,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            post['description'].toString(),
            style: const TextStyle(
              color: _CommunityScreenState.secondaryText,
              fontSize: 12,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 18),
          const Divider(color: _CommunityScreenState.sandstone),
          const SizedBox(height: 7),
          Row(
            children: [
              _PostAction(
                icon: liked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                label: post['likes'].toString(),
                color: liked
                    ? _CommunityScreenState.primary
                    : _CommunityScreenState.secondaryText,
                onTap: onLike,
              ),
              const SizedBox(width: 21),
              _PostAction(
                icon: Icons.chat_bubble_outline_rounded,
                label: post['comments'].toString(),
                color: _CommunityScreenState.forestLight,
                onTap: onComment,
              ),
              const Spacer(),
              IconButton(
                tooltip: isSaved ? 'Unsave post' : 'Save post',
                onPressed: onSave,
                icon: Icon(
                  isSaved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  size: 20,
                  color: isSaved
                      ? _CommunityScreenState.primary
                      : _CommunityScreenState.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================================================================
// POST ACTION
// ================================================================

class _PostAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _PostAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 9,
          horizontal: 4,
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: color),
            const SizedBox(width: 7),
            Text(
              label,
              style: const TextStyle(
                color: _CommunityScreenState.textColor,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// PERSON CARD
// ================================================================

class _PersonCard extends StatelessWidget {
  final String name;
  final String role;
  final IconData icon;
  final Color color;

  const _PersonCard({
    required this.name,
    required this.role,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      margin: const EdgeInsets.only(right: 13),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _CommunityScreenState.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _CommunityScreenState.sandstone),
        boxShadow: [
          BoxShadow(
            color: _CommunityScreenState.forest.withOpacity(0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              color: _CommunityScreenState.forest,
              shape: BoxShape.circle,
              border: Border.all(
                color: _CommunityScreenState.gold.withOpacity(0.65),
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: _CommunityScreenState.gold,
              size: 22,
            ),
          ),
          const Spacer(),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: _CommunityScreenState.forest,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            role,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              color: _CommunityScreenState.secondaryText,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, size: 6, color: color),
                const SizedBox(width: 6),
                Text(
                  'Explorer',
                  style: TextStyle(
                    color: color == _CommunityScreenState.gold
                        ? _CommunityScreenState.primaryDark
                        : color,
                    fontSize: 9,
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
}
