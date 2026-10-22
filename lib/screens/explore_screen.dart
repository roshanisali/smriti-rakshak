
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  // ============================================================
  // HERITAGE COLORS
  // ============================================================

  static const Color primary = Color(0xFFC6533B);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE6B85C);
  static const Color background = Color(0xFFF7F2E8);
  static const Color surface = Color(0xFFFFFCF6);
  static const Color textDark = Color(0xFF29352C);
  static const Color textSecondary = Color(0xFF77786C);
  static const Color forest = Color(0xFF294536);
  static const Color forestLight = Color(0xFF42634B);
  static const Color sandstone = Color(0xFFE8DDC9);
  static const Color teal = Color(0xFF47877A);
  static const Color green = Color(0xFF63845A);
  static const Color purple = Color(0xFF87705E);

  // ============================================================
  // NAVIGATION AND MESSAGES
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
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  void _showCategoryMessage(BuildContext context, String category) {
    _showMessage(context, 'Explore $category discoveries.');
  }

  void _showTrailDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        icon: const Icon(
          Icons.route_rounded,
          color: primary,
          size: 36,
        ),
        title: const Text(
          'Create your heritage trail',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textDark,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: const Text(
          'Choose places that interest you and plan your own cultural '
          'journey. Your trail can later connect with maps and saved '
          'discoveries.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textSecondary,
            height: 1.6,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
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
            final isDesktop = width >= 1000;
            final isTablet = width >= 650 && width < 1000;

            final horizontalPadding = isDesktop
                ? 48.0
                : isTablet
                    ? 30.0
                    : 18.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1320),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      22,
                      horizontalPadding,
                      42,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // HEADER

                        Row(
                          children: [
                            _CircleButton(
                              icon: Icons.arrow_back_rounded,
                              tooltip: 'Go back',
                              onTap: () => _goBack(context),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SMRITI RAKSHAK',
                                    style: TextStyle(
                                      fontSize: 10,
                                      letterSpacing: 2.2,
                                      fontWeight: FontWeight.w900,
                                      color: primary,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Explore heritage',
                                    style: TextStyle(
                                      fontSize: 24,
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
                        ),

                        const SizedBox(height: 28),

                        // INTRODUCTION BANNER

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isDesktop ? 36 : 24),
                          decoration: BoxDecoration(
                            color: forest,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: gold.withOpacity(0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: forest.withOpacity(0.08),
                                blurRadius: 22,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: -12,
                                top: -18,
                                child: Icon(
                                  Icons.account_balance_rounded,
                                  size: isDesktop ? 180 : 120,
                                  color: Colors.white.withOpacity(0.055),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: gold.withOpacity(0.16),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: gold.withOpacity(0.4),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.explore_rounded,
                                          color: gold,
                                          size: 15,
                                        ),
                                        SizedBox(width: 7),
                                        Text(
                                          'YOUR NEXT DISCOVERY',
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
                                  const SizedBox(height: 20),
                                  Text(
                                    'Every place has\na story to tell.',
                                    style: TextStyle(
                                      color: surface,
                                      fontSize: isDesktop ? 43 : 34,
                                      height: 1.12,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                  const SizedBox(height: 13),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 520,
                                    ),
                                    child: Text(
                                      'Walk through ancient forts, discover '
                                      'forgotten stories, and experience the '
                                      'living culture of Maharashtra.',
                                      style: TextStyle(
                                        color: Color(0xCCFFFCF6),
                                        fontSize: 13,
                                        height: 1.7,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 23),
                                  const Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      _BannerChip(
                                        icon: Icons.castle_rounded,
                                        label: 'Historic forts',
                                      ),
                                      _BannerChip(
                                        icon: Icons.palette_rounded,
                                        label: 'Local crafts',
                                      ),
                                      _BannerChip(
                                        icon: Icons.temple_hindu_rounded,
                                        label: 'Living traditions',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 36),

                        // MOOD CATEGORIES

                        const _SectionHeading(
                          eyebrow: 'FIND YOUR PATH',
                          title: 'What are you in the mood for?',
                          subtitle: 'Choose a journey that speaks to you.',
                        ),

                        const SizedBox(height: 18),

                        LayoutBuilder(
                          builder: (context, categoryConstraints) {
                            final availableWidth =
                                categoryConstraints.maxWidth;

                            final columns = availableWidth >= 1000
                                ? 5
                                : availableWidth >= 650
                                    ? 3
                                    : 2;

                            final itemWidth =
                                (availableWidth - (columns - 1) * 12) /
                                    columns;

                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _MoodCard(
                                  width: itemWidth,
                                  icon: Icons.landscape_rounded,
                                  title: 'Epic Fortresses',
                                  subtitle: 'Legends carved in stone',
                                  color: primary,
                                  onTap: () => _showCategoryMessage(
                                    context,
                                    'Epic Fortresses',
                                  ),
                                ),
                                _MoodCard(
                                  width: itemWidth,
                                  icon: Icons.palette_rounded,
                                  title: 'Art & Craft',
                                  subtitle: 'Meet local artisans',
                                  color: gold,
                                  onTap: () => _showCategoryMessage(
                                    context,
                                    'Art & Craft',
                                  ),
                                ),
                                _MoodCard(
                                  width: itemWidth,
                                  icon: Icons.auto_stories_rounded,
                                  title: 'Hidden Stories',
                                  subtitle: 'Uncover the past',
                                  color: teal,
                                  onTap: () => _showCategoryMessage(
                                    context,
                                    'Hidden Stories',
                                  ),
                                ),
                                _MoodCard(
                                  width: itemWidth,
                                  icon: Icons.temple_hindu_rounded,
                                  title: 'Sacred Places',
                                  subtitle: 'Explore timeless faith',
                                  color: green,
                                  onTap: () => _showCategoryMessage(
                                    context,
                                    'Sacred Places',
                                  ),
                                ),
                                _MoodCard(
                                  width: itemWidth,
                                  icon: Icons.music_note_rounded,
                                  title: 'Living Culture',
                                  subtitle: 'Traditions that live on',
                                  color: purple,
                                  onTap: () => _showCategoryMessage(
                                    context,
                                    'Living Culture',
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 38),

                        // FEATURED DISCOVERIES

                        _SectionHeading(
                          eyebrow: 'HANDPICKED FOR YOU',
                          title: 'Featured discoveries',
                          subtitle: 'Places and stories worth your time.',
                          action: 'View all',
                          onAction: () => _showMessage(
                            context,
                            'You are viewing our featured discoveries.',
                          ),
                        ),

                        const SizedBox(height: 18),

                        if (isDesktop)
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _FeaturedCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1600100397608-f010eaa1f2e6?auto=format&fit=crop&w=900&q=80',
                                  title: 'The Stone Stories',
                                  subtitle: 'Ancient architecture',
                                  tag: 'TIMELESS',
                                  height: 350,
                                ),
                              ),
                              SizedBox(width: 18),
                              Expanded(
                                child: _FeaturedCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?auto=format&fit=crop&w=900&q=80',
                                  title: 'Sacred India',
                                  subtitle: 'Temples and traditions',
                                  tag: 'CULTURE',
                                  height: 350,
                                ),
                              ),
                              SizedBox(width: 18),
                              Expanded(
                                child: _FeaturedCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=900&q=80',
                                  title: 'Stories in Stone',
                                  subtitle: 'Forgotten monuments',
                                  tag: 'EXPLORE',
                                  height: 350,
                                ),
                              ),
                            ],
                          )
                        else
                          SizedBox(
                            height: 310,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: const [
                                _FeaturedCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1600100397608-f010eaa1f2e6?auto=format&fit=crop&w=900&q=80',
                                  title: 'The Stone Stories',
                                  subtitle: 'Ancient architecture',
                                  tag: 'TIMELESS',
                                  height: 310,
                                ),
                                _FeaturedCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?auto=format&fit=crop&w=900&q=80',
                                  title: 'Sacred India',
                                  subtitle: 'Temples and traditions',
                                  tag: 'CULTURE',
                                  height: 310,
                                ),
                                _FeaturedCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=900&q=80',
                                  title: 'Stories in Stone',
                                  subtitle: 'Forgotten monuments',
                                  tag: 'EXPLORE',
                                  height: 310,
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 40),

                        // HERITAGE TRAILS

                        _SectionHeading(
                          eyebrow: 'CURATED JOURNEYS',
                          title: 'Explore a trail',
                          subtitle:
                              'Follow a path through history and culture.',
                          action: 'See more',
                          onAction: () => _showMessage(
                            context,
                            'Explore our curated heritage trails.',
                          ),
                        ),

                        const SizedBox(height: 18),

                        if (isDesktop)
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _TrailCard(
                                  number: '01',
                                  title: 'Maratha Legacy',
                                  places: '6 places  •  1 day',
                                  description:
                                      'Walk through the legacy of the Maratha empire.',
                                  icon: Icons.shield_rounded,
                                  color: primary,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _TrailCard(
                                  number: '02',
                                  title: 'Art Beyond Time',
                                  places: '5 places  •  2 days',
                                  description:
                                      'Discover craftsmanship passed through generations.',
                                  icon: Icons.brush_rounded,
                                  color: gold,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _TrailCard(
                                  number: '03',
                                  title: 'Sacred Maharashtra',
                                  places: '7 places  •  Weekend',
                                  description:
                                      'Experience sacred sites and living traditions.',
                                  icon: Icons.temple_hindu_rounded,
                                  color: green,
                                ),
                              ),
                            ],
                          )
                        else
                          const Column(
                            children: [
                              _TrailCard(
                                number: '01',
                                title: 'Maratha Legacy',
                                places: '6 places  •  1 day',
                                description:
                                    'Walk through the legacy of the Maratha empire.',
                                icon: Icons.shield_rounded,
                                color: primary,
                              ),
                              SizedBox(height: 12),
                              _TrailCard(
                                number: '02',
                                title: 'Art Beyond Time',
                                places: '5 places  •  2 days',
                                description:
                                    'Discover craftsmanship passed through generations.',
                                icon: Icons.brush_rounded,
                                color: gold,
                              ),
                              SizedBox(height: 12),
                              _TrailCard(
                                number: '03',
                                title: 'Sacred Maharashtra',
                                places: '7 places  •  Weekend',
                                description:
                                    'Experience sacred sites and living traditions.',
                                icon: Icons.temple_hindu_rounded,
                                color: green,
                              ),
                            ],
                          ),

                        const SizedBox(height: 36),

                        // CREATE YOUR OWN TRAIL

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isDesktop ? 34 : 24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [primaryDark, primary],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(27),
                            boxShadow: [
                              BoxShadow(
                                color: primary.withOpacity(0.17),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: isDesktop
                              ? Row(
                                  children: [
                                    _routeIcon(),
                                    const SizedBox(width: 26),
                                    const Expanded(
                                      child: _TrailBannerText(),
                                    ),
                                    const SizedBox(width: 20),
                                    _StartTrailButton(
                                      onTap: () => _showTrailDialog(context),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _routeIcon(),
                                    const SizedBox(height: 20),
                                    const _TrailBannerText(),
                                    const SizedBox(height: 20),
                                    _StartTrailButton(
                                      onTap: () => _showTrailDialog(context),
                                    ),
                                  ],
                                ),
                        ),

                        const SizedBox(height: 35),

                        // FOOTER

                        const Center(
                          child: Column(
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: sandstone,
                                  shape: BoxShape.circle,
                                ),
                                child: SizedBox(
                                  width: 54,
                                  height: 54,
                                  child: Icon(
                                    Icons.account_balance_rounded,
                                    color: primary,
                                    size: 27,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Discover. Experience. Preserve.',
                                style: TextStyle(
                                  color: textDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Every discovery keeps a story alive.',
                                style: TextStyle(
                                  color: textSecondary,
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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _routeIcon() {
    return Container(
      width: 78,
      height: 78,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.22),
        ),
      ),
      child: const Icon(
        Icons.route_rounded,
        size: 39,
        color: Colors.white,
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
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ExploreScreen.sandstone.withOpacity(0.8),
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
// BANNER CHIP
// ============================================================

class _BannerChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BannerChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
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
            size: 14,
            color: ExploreScreen.gold,
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.w700,
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
              Text(
                eyebrow,
                style: const TextStyle(
                  color: ExploreScreen.primary,
                  fontSize: 9,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                  color: ExploreScreen.textDark,
                  letterSpacing: -0.35,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 6),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  action!,
                  style: const TextStyle(
                    color: ExploreScreen.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: ExploreScreen.primary,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ============================================================
// MOOD CARD
// ============================================================

class _MoodCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MoodCard({
    required this.width,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: ExploreScreen.surface,
        borderRadius: BorderRadius.circular(19),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(19),
          child: Container(
            constraints: const BoxConstraints(minHeight: 150),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: ExploreScreen.sandstone.withOpacity(0.8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 13),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    fontWeight: FontWeight.w900,
                    color: ExploreScreen.textDark,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.4,
                    color: ExploreScreen.textSecondary,
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
// FEATURED DISCOVERY CARD
// ============================================================

class _FeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String tag;
  final double height;

  const _FeaturedCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.height,
  });

  void _showCardMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: ExploreScreen.forest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: height,
      margin: const EdgeInsets.only(right: 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ExploreScreen.sandstone,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: ExploreScreen.sandstone.withOpacity(0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: ExploreScreen.forest.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return Container(
                color: ExploreScreen.sandstone,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ExploreScreen.primary,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: ExploreScreen.sandstone,
                child: const Center(
                  child: Icon(
                    Icons.account_balance_rounded,
                    size: 60,
                    color: ExploreScreen.forestLight,
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
                  Colors.black.withOpacity(0.24),
                  Colors.transparent,
                  ExploreScreen.forest.withOpacity(0.95),
                ],
                stops: const [0, 0.34, 1],
              ),
            ),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: ExploreScreen.surface.withOpacity(0.95),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  color: ExploreScreen.forest,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Material(
              color: Colors.black.withOpacity(0.28),
              shape: const CircleBorder(),
              child: IconButton(
                tooltip: 'Save discovery',
                onPressed: () => _showCardMessage(
                  context,
                  '$title selected to save.',
                ),
                icon: const Icon(
                  Icons.bookmark_border_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            left: 18,
            right: 16,
            bottom: 19,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _showCardMessage(
                  context,
                  '$title details coming soon.',
                ),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    right: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          height: 1.2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xDFFFFFFF),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Row(
                        children: [
                          Text(
                            'Discover story',
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
                            size: 15,
                          ),
                        ],
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

// ============================================================
// HERITAGE TRAIL CARD
// ============================================================

class _TrailCard extends StatelessWidget {
  final String number;
  final String title;
  final String places;
  final String description;
  final IconData icon;
  final Color color;

  const _TrailCard({
    required this.number,
    required this.title,
    required this.places,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ExploreScreen.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('$title trail details coming soon.'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: ExploreScreen.forest,
              ),
            );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ExploreScreen.sandstone.withOpacity(0.9),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 43,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  number,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: ExploreScreen.background,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: ExploreScreen.textDark,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      places,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: ExploreScreen.primary,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.45,
                        color: ExploreScreen.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: ExploreScreen.textSecondary,
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
// CREATE YOUR OWN TRAIL BANNER TEXT
// ============================================================

class _TrailBannerText extends StatelessWidget {
  const _TrailBannerText();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR HERITAGE TRAIL',
          style: TextStyle(
            color: Color(0xDFFFFFFF),
            fontSize: 10,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Create your own cultural journey.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            height: 1.2,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Choose the places, traditions and stories you want to experience.',
          style: TextStyle(
            color: Color(0xDFFFFFFF),
            fontSize: 12,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// START TRAIL BUTTON
// ============================================================

class _StartTrailButton extends StatelessWidget {
  final VoidCallback onTap;

  const _StartTrailButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: ExploreScreen.surface,
        foregroundColor: ExploreScreen.primaryDark,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
      icon: const Icon(
        Icons.route_rounded,
        size: 17,
      ),
      label: const Text(
        'Start exploring',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}
