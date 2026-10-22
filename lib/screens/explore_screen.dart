import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  // ============================================================
  // SMRITI RAKSHAK — HERITAGE DESIGN SYSTEM
  // ============================================================

  static const Color primary = Color(0xFFE0533C);
  static const Color primaryDark = Color(0xFFA6321F);
  static const Color gold = Color(0xFFF2A922);
  static const Color background = Color(0xFFF0F4F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color forest = Color(0xFF183D32);
  static const Color forestLight = Color(0xFF285747);
  static const Color teal = Color(0xFF0EA5E9);
  static const Color green = Color(0xFF10B981);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color sandstone = Color(0xFFE2E8F0);

  // ============================================================
  // NAVIGATION AND FEEDBACK
  // ============================================================

  void _goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      _showMessage(context, 'You are already on the main screen.');
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: forest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }

  void _showTrailDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        icon: const Icon(
          Icons.explore_rounded,
          size: 42,
          color: primary,
        ),
        title: const Text(
          'Your journey begins here',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textDark,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: const Text(
          'Imagine a journey through mighty forts, ancient temples, '
          'local art and untold stories. Choose your interests and '
          'start creating a heritage trail of your own.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textSecondary,
            height: 1.7,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Let’s explore'),
          ),
        ],
      ),
    );
  }

  void _showCategory(BuildContext context, String category) {
    _showMessage(context, 'Discover the world of $category.');
  }

  // ============================================================
  // MAIN SCREEN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final desktop = width >= 1050;
            final tablet = width >= 650 && width < 1050;

            final horizontalPadding = desktop
                ? 48.0
                : tablet
                    ? 30.0
                    : 18.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1360),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      20,
                      horizontalPadding,
                      44,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // HEADER
                        _buildHeader(context),

                        const SizedBox(height: 26),

                        // HERO
                        _buildHero(desktop),

                        const SizedBox(height: 34),

                        // CATEGORY SECTION
                        const _SectionHeading(
                          eyebrow: 'CHOOSE YOUR ADVENTURE',
                          title: 'What speaks to your soul?',
                          subtitle:
                              'Every path leads to a different piece of history.',
                        ),

                        const SizedBox(height: 19),

                        _buildCategories(context, width),

                        const SizedBox(height: 40),

                        // FEATURED DISCOVERIES
                        _SectionHeading(
                          eyebrow: 'THE HERITAGE EDIT',
                          title: 'Stories worth discovering',
                          subtitle:
                              'Extraordinary places. Remarkable histories.',
                          action: 'Explore all',
                          onAction: () => _showMessage(
                            context,
                            'You are exploring our featured discoveries.',
                          ),
                        ),

                        const SizedBox(height: 19),

                        _buildFeatured(desktop, tablet),

                        const SizedBox(height: 42),

                        // TRAILS
                        _SectionHeading(
                          eyebrow: 'JOURNEYS WITH A STORY',
                          title: 'Take the scenic route',
                          subtitle:
                              'Curated trails for curious minds and wandering hearts.',
                          action: 'See all trails',
                          onAction: () => _showTrailDialog(context),
                        ),

                        const SizedBox(height: 19),

                        _buildTrails(context, desktop),

                        const SizedBox(height: 34),

                        // CREATE YOUR OWN TRAIL
                        _buildCreateTrail(context, desktop),

                        const SizedBox(height: 36),

                        // FOOTER
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          icon: Icons.arrow_back_rounded,
          tooltip: 'Go back',
          onTap: () => _goBack(context),
        ),
        const SizedBox(width: 13),
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primary, primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.account_balance_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 11),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SMRITI RAKSHAK',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  color: primary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Explore heritage',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: textDark,
                  letterSpacing: -0.7,
                ),
              ),
            ],
          ),
        ),
        _CircleButton(
          icon: Icons.bookmark_border_rounded,
          tooltip: 'Saved discoveries',
          onTap: () => _showMessage(
            context,
            'Your saved discoveries will appear here.',
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HERO BANNER
  // ============================================================

  Widget _buildHero(bool desktop) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: desktop ? 390 : 370,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: forest,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: forest.withOpacity(0.15),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?auto=format&fit=crop&w=1800&q=85',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: forest);
              },
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    forest.withOpacity(0.98),
                    forest.withOpacity(0.86),
                    forest.withOpacity(0.35),
                  ],
                  stops: const [0, 0.53, 1],
                ),
              ),
            ),
          ),
          Positioned(
            right: -28,
            bottom: -35,
            child: Icon(
              Icons.account_balance_rounded,
              size: desktop ? 300 : 210,
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(desktop ? 38 : 25),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: gold.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: gold.withOpacity(0.65),
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
                        SizedBox(width: 8),
                        Text(
                          'YOUR GATEWAY TO THE PAST',
                          style: TextStyle(
                            color: gold,
                            fontSize: 10,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'History isn’t\njust remembered.\nIt’s experienced.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: desktop ? 47 : 36,
                      height: 1.12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.6,
                    ),
                  ),
                  const SizedBox(height: 17),
                  const Text(
                    'Step into Maharashtra’s magnificent forts, '
                    'meet the hands behind its crafts, and uncover '
                    'stories that deserve to live forever.',
                    style: TextStyle(
                      color: Color(0xFFE2E8F0),
                      fontSize: 13,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Wrap(
                    spacing: 9,
                    runSpacing: 9,
                    children: const [
                      _HeroPill(
                        icon: Icons.castle_rounded,
                        label: 'Epic forts',
                      ),
                      _HeroPill(
                        icon: Icons.palette_rounded,
                        label: 'Living crafts',
                      ),
                      _HeroPill(
                        icon: Icons.auto_stories_rounded,
                        label: 'Untold stories',
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: gold,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: gold.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.explore_rounded,
                          color: textDark,
                          size: 19,
                        ),
                        SizedBox(width: 9),
                        Text(
                          'Find your next adventure',
                          style: TextStyle(
                            color: textDark,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
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
      ),
    );
  }

  // ============================================================
  // CATEGORY CARDS
  // ============================================================

  Widget _buildCategories(BuildContext context, double width) {
    final columns = width >= 1150
        ? 5
        : width >= 750
            ? 3
            : 2;

    const gap = 13.0;
    final itemWidth =
        (width - (columns - 1) * gap) / columns;

    return Wrap(
      spacing: gap,
      runSpacing: gap,
      children: [
        _CategoryCard(
          width: itemWidth,
          image:
              'https://images.unsplash.com/photo-1600100397608-f010eaa1f2e6?auto=format&fit=crop&w=700&q=80',
          icon: Icons.castle_rounded,
          title: 'Epic Fortresses',
          subtitle: 'Where legends were born',
          accent: primary,
          number: '01',
          onTap: () => _showCategory(context, 'Epic Fortresses'),
        ),
        _CategoryCard(
          width: itemWidth,
          image:
              'https://images.unsplash.com/photo-1452860606245-08befc0ff44b?auto=format&fit=crop&w=700&q=80',
          icon: Icons.palette_rounded,
          title: 'Art & Craft',
          subtitle: 'Made by remarkable hands',
          accent: gold,
          number: '02',
          onTap: () => _showCategory(context, 'Art & Craft'),
        ),
        _CategoryCard(
          width: itemWidth,
          image:
              'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=700&q=80',
          icon: Icons.auto_stories_rounded,
          title: 'Hidden Stories',
          subtitle: 'Secrets from another time',
          accent: teal,
          number: '03',
          onTap: () => _showCategory(context, 'Hidden Stories'),
        ),
        _CategoryCard(
          width: itemWidth,
          image:
              'https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=700&q=80',
          icon: Icons.temple_hindu_rounded,
          title: 'Sacred Places',
          subtitle: 'Spaces filled with meaning',
          accent: green,
          number: '04',
          onTap: () => _showCategory(context, 'Sacred Places'),
        ),
        _CategoryCard(
          width: itemWidth,
          image:
              'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=700&q=80',
          icon: Icons.music_note_rounded,
          title: 'Living Culture',
          subtitle: 'Traditions still alive',
          accent: purple,
          number: '05',
          onTap: () => _showCategory(context, 'Living Culture'),
        ),
      ],
    );
  }

  // ============================================================
  // FEATURED DISCOVERIES
  // ============================================================

  Widget _buildFeatured(bool desktop, bool tablet) {
    if (desktop) {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: _FeaturedCard(
              imageUrl:
                  'https://images.unsplash.com/photo-1600100397608-f010eaa1f2e6?auto=format&fit=crop&w=1100&q=85',
              title: 'The Stone Stories',
              subtitle: 'Ancient architecture',
              description:
                  'Discover the vision and craftsmanship carved into history.',
              tag: 'ARCHITECTURE',
              accent: primary,
              height: 390,
            ),
          ),
          SizedBox(width: 18),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                _CompactFeaturedCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=900&q=85',
                  title: 'Sacred India',
                  subtitle: 'Temples & traditions',
                  tag: 'CULTURE',
                  height: 185,
                ),
                SizedBox(height: 18),
                _CompactFeaturedCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=900&q=85',
                  title: 'Beyond the Ordinary',
                  subtitle: 'Journeys through time',
                  tag: 'DISCOVER',
                  height: 185,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: tablet ? 355 : 345,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          _FeaturedCard(
            imageUrl:
                'https://images.unsplash.com/photo-1600100397608-f010eaa1f2e6?auto=format&fit=crop&w=900&q=85',
            title: 'The Stone Stories',
            subtitle: 'Ancient architecture',
            description:
                'Discover the craftsmanship carved into history.',
            tag: 'ARCHITECTURE',
            accent: primary,
            height: 345,
          ),
          _FeaturedCard(
            imageUrl:
                'https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=900&q=85',
            title: 'Sacred India',
            subtitle: 'Temples & traditions',
            description:
                'Explore the places that hold generations of belief.',
            tag: 'CULTURE',
            accent: gold,
            height: 345,
          ),
          _FeaturedCard(
            imageUrl:
                'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=900&q=85',
            title: 'Beyond the Ordinary',
            subtitle: 'Journeys through time',
            description:
                'Find the beauty hidden in forgotten corners.',
            tag: 'DISCOVER',
            accent: teal,
            height: 345,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERITAGE TRAILS
  // ============================================================

  Widget _buildTrails(BuildContext context, bool desktop) {
    final trails = [
      const _TrailData(
        number: '01',
        title: 'The Maratha Legacy',
        places: '6 PLACES',
        duration: '1 DAY',
        description:
            'Follow the footsteps of warriors, visionaries and kings.',
        icon: Icons.shield_rounded,
        color: primary,
        background: Color(0xFFFFE9E2),
      ),
      const _TrailData(
        number: '02',
        title: 'Art Beyond Time',
        places: '5 PLACES',
        duration: '2 DAYS',
        description:
            'Meet the makers keeping generations of craftsmanship alive.',
        icon: Icons.brush_rounded,
        color: Color(0xFF9A6700),
        background: Color(0xFFFFF2CE),
      ),
      const _TrailData(
        number: '03',
        title: 'Sacred Maharashtra',
        places: '7 PLACES',
        duration: 'WEEKEND',
        description:
            'Discover sacred architecture, rituals and living traditions.',
        icon: Icons.temple_hindu_rounded,
        color: Color(0xFF087F5B),
        background: Color(0xFFDDF8EC),
      ),
    ];

    if (desktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < trails.length; i++) ...[
            if (i > 0) const SizedBox(width: 16),
            Expanded(
              child: _TrailCard(
                data: trails[i],
                onTap: () => _showTrailDialog(context),
              ),
            ),
          ],
        ],
      );
    }

    return Column(
      children: [
        for (int i = 0; i < trails.length; i++) ...[
          if (i > 0) const SizedBox(height: 13),
          _TrailCard(
            data: trails[i],
            onTap: () => _showTrailDialog(context),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // CREATE A TRAIL
  // ============================================================

  Widget _buildCreateTrail(BuildContext context, bool desktop) {
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.22),
            ),
          ),
          child: const Icon(
            Icons.route_rounded,
            color: gold,
            size: 31,
          ),
        ),
        const SizedBox(width: 19),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MAKE IT YOURS',
                style: TextStyle(
                  color: gold,
                  fontSize: 10,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your story. Your route.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.7,
                ),
              ),
              SizedBox(height: 9),
              Text(
                'Build a journey around the places, people and '
                'traditions you love. Your next unforgettable '
                'discovery starts with you.',
                style: TextStyle(
                  color: Color(0xFFDCE8E2),
                  fontSize: 12,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(desktop ? 31 : 23),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [forest, forestLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: gold.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: forest.withOpacity(0.15),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: desktop
          ? Row(
              children: [
                Expanded(child: content),
                const SizedBox(width: 24),
                _CreateTrailButton(
                  onTap: () => _showTrailDialog(context),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                content,
                const SizedBox(height: 23),
                _CreateTrailButton(
                  onTap: () => _showTrailDialog(context),
                ),
              ],
            ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [primary, primaryDark],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.account_balance_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Discover. Experience. Preserve.',
            style: TextStyle(
              color: textDark,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Every discovery keeps a story alive.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 48,
            height: 3,
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CIRCLE BUTTON
// ============================================================

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: ExploreScreen.surface,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ExploreScreen.sandstone,
              ),
            ),
            child: Icon(
              icon,
              color: ExploreScreen.textDark,
              size: 21,
            ),
          ),
        ),
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
        color: Colors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.19),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: ExploreScreen.gold, size: 15),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION HEADING
// ============================================================

class _SectionHeading extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final String? action;
  final VoidCallback? onAction;

  const _SectionHeading({
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 23,
                    height: 3,
                    decoration: BoxDecoration(
                      color: ExploreScreen.gold,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      eyebrow,
                      style: const TextStyle(
                        color: ExploreScreen.primary,
                        fontSize: 9,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  height: 1.22,
                  fontWeight: FontWeight.w900,
                  color: ExploreScreen.textDark,
                  letterSpacing: -0.7,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 7),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.6,
                    color: ExploreScreen.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: ExploreScreen.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 9,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  action!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 3),
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
}

// ============================================================
// IMAGE-LED CATEGORY CARD
// ============================================================

class _CategoryCard extends StatelessWidget {
  final double width;
  final String image;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final String number;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.width,
    required this.image,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.number,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: ExploreScreen.surface,
        borderRadius: BorderRadius.circular(22),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: ExploreScreen.sandstone.withOpacity(0.7),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 115,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: accent.withOpacity(0.13),
                            child: Icon(
                              icon,
                              color: accent,
                              size: 45,
                            ),
                          );
                        },
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.05),
                              Colors.black.withOpacity(0.48),
                            ],
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
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            number,
                            style: TextStyle(
                              color: accent,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 11,
                        bottom: 11,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 14, 11, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: ExploreScreen.textDark,
                          fontSize: 13,
                          height: 1.3,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: ExploreScreen.textSecondary,
                          fontSize: 10,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Explore',
                            style: TextStyle(
                              color: accent,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: accent,
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

// ============================================================
// LARGE FEATURED CARD
// ============================================================

class _FeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String description;
  final String tag;
  final Color accent;
  final double height;

  const _FeaturedCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.tag,
    required this.accent,
    required this.height,
  });

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: ExploreScreen.forest,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ExploreScreen.forest,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: ExploreScreen.forest.withOpacity(0.12),
            blurRadius: 17,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: ExploreScreen.sandstone,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ExploreScreen.primary,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: ExploreScreen.forest,
                child: const Center(
                  child: Icon(
                    Icons.account_balance_rounded,
                    color: Colors.white54,
                    size: 65,
                  ),
                ),
              );
            },
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.22),
                  Colors.transparent,
                  ExploreScreen.forest.withOpacity(0.97),
                ],
                stops: const [0, 0.3, 1],
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: ExploreScreen.surface,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: accent,
                  fontSize: 9,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: Colors.black.withOpacity(0.3),
              shape: const CircleBorder(),
              child: IconButton(
                tooltip: 'Save discovery',
                onPressed: () => _showMessage(
                  context,
                  '$title selected to save.',
                ),
                icon: const Icon(
                  Icons.bookmark_border_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
            ),
          ),
          Positioned(
            left: 19,
            right: 19,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle.toUpperCase(),
                  style: const TextStyle(
                    color: ExploreScreen.gold,
                    fontSize: 9,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 11,
                    height: 1.65,
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Text(
                      'Discover the story',
                      style: TextStyle(
                        color: ExploreScreen.gold,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 7),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: ExploreScreen.gold,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// COMPACT FEATURED CARD
// ============================================================

class _CompactFeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String tag;
  final double height;

  const _CompactFeaturedCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ExploreScreen.forest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: ExploreScreen.forest);
            },
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                  ExploreScreen.forest.withOpacity(0.95),
                ],
                stops: const [0, 0.3, 1],
              ),
            ),
          ),
          Positioned(
            top: 13,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: ExploreScreen.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  color: ExploreScreen.primaryDark,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ),
          Positioned(
            left: 17,
            right: 17,
            bottom: 17,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xFFE2E8F0),
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: ExploreScreen.gold,
                      size: 19,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TRAIL DATA
// ============================================================

class _TrailData {
  final String number;
  final String title;
  final String places;
  final String duration;
  final String description;
  final IconData icon;
  final Color color;
  final Color background;

  const _TrailData({
    required this.number,
    required this.title,
    required this.places,
    required this.duration,
    required this.description,
    required this.icon,
    required this.color,
    required this.background,
  });
}

// ============================================================
// HERITAGE TRAIL CARD
// ============================================================

class _TrailCard extends StatelessWidget {
  final _TrailData data;
  final VoidCallback onTap;

  const _TrailCard({
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ExploreScreen.surface,
      borderRadius: BorderRadius.circular(23),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(23),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(19),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            border: Border.all(
              color: ExploreScreen.sandstone.withOpacity(0.75),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: data.background,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Icon(
                      data.icon,
                      color: data.color,
                      size: 27,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    data.number,
                    style: TextStyle(
                      color: data.color.withOpacity(0.65),
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 19),
              Text(
                data.title,
                style: const TextStyle(
                  color: ExploreScreen.textDark,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.35,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _TrailInfoChip(
                    icon: Icons.place_rounded,
                    label: data.places,
                    color: data.color,
                    background: data.background,
                  ),
                  _TrailInfoChip(
                    icon: Icons.schedule_rounded,
                    label: data.duration,
                    color: data.color,
                    background: data.background,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                data.description,
                style: const TextStyle(
                  color: ExploreScreen.textSecondary,
                  fontSize: 12,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 17),
              Divider(
                color: ExploreScreen.sandstone.withOpacity(0.9),
                height: 1,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Explore this trail',
                    style: TextStyle(
                      color: data.color,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: data.color,
                    size: 16,
                  ),
                  const Spacer(),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: data.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.north_east_rounded,
                      size: 16,
                      color: data.color,
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
}

// ============================================================
// TRAIL INFO CHIP
// ============================================================

class _TrailInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color background;

  const _TrailInfoChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CREATE TRAIL BUTTON
// ============================================================

class _CreateTrailButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CreateTrailButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: ExploreScreen.gold,
        foregroundColor: ExploreScreen.textDark,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 17,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      icon: const Icon(
        Icons.add_location_alt_rounded,
        size: 18,
      ),
      label: const Text(
        'Create my trail',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}
