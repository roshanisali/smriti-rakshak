import 'package:flutter/material.dart';

import 'explore_screen.dart';
import 'map_screen.dart';
import 'trip_screen.dart';
import 'culture_screen.dart';
import 'quest_screen.dart';
import 'sites_screen.dart';
import 'events_screen.dart';
import 'ar_vr_screen.dart';
import 'scan_screen.dart';
import 'profile_screen.dart';
import 'discover_screen.dart';
import 'connect_screen.dart';

// ============================================================
// SMRITI RAKSHAK - HERITAGE WEBSITE HOMEPAGE
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primary = Color(0xFFC94F36);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE8B957);
  static const Color forest = Color(0xFF263D32);
  static const Color forestLight = Color(0xFF385745);
  static const Color sandstone = Color(0xFFE9DDC8);
  static const Color cream = Color(0xFFF7F0E3);
  static const Color ink = Color(0xFF292C25);
  static const Color muted = Color(0xFF6F7165);

  int selectedIndex = 0;

  final List<Widget> pages = const [
    SizedBox(),
    DiscoverScreen(),
    ExploreScreen(),
    MapScreen(),
    TripScreen(),
    SitesScreen(),
    CultureScreen(),
    QuestScreen(),
    EventsScreen(),
    ArVrScreen(),
    ScanScreen(),
    ConnectScreen(),
    ProfileScreen(),
  ];

  // ============================================================
  // NAVIGATION
  // ============================================================

  void openPage(int index) {
    if (index < 0 || index >= pages.length) return;

    setState(() {
      selectedIndex = index;
    });
  }

  int get mobileSelectedIndex {
    switch (selectedIndex) {
      case 0:
        return 0;
      case 1:
      case 2:
      case 5:
      case 6:
        return 1;
      case 3:
        return 2;
      case 11:
        return 3;
      case 12:
        return 4;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 900;

        return Scaffold(
          backgroundColor: sandstone,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _WebsiteHeader(
                  desktop: desktop,
                  selectedIndex: selectedIndex,
                  onNavigate: openPage,
                  forest: forest,
                  primary: primary,
                  gold: gold,
                  cream: cream,
                ),

                Expanded(
                  child: selectedIndex == 0
                      ? _buildHomePage(desktop)
                      : KeyedSubtree(
                          key: ValueKey(selectedIndex),
                          child: pages[selectedIndex],
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: desktop
              ? null
              : NavigationBar(
                  selectedIndex: mobileSelectedIndex,
                  backgroundColor: cream,
                  indicatorColor: gold.withOpacity(0.4),
                  onDestinationSelected: (index) {
                    const destinations = [0, 1, 3, 11, 12];
                    openPage(destinations[index]);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore_rounded),
                      label: 'Discover',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.map_outlined),
                      selectedIcon: Icon(Icons.map_rounded),
                      label: 'Nearby',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.groups_outlined),
                      selectedIcon: Icon(Icons.groups_rounded),
                      label: 'Community',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline_rounded),
                      selectedIcon: Icon(Icons.person_rounded),
                      label: 'Profile',
                    ),
                  ],
                ),
        );
      },
    );
  }

  // ============================================================
  // HOMEPAGE CONTENT
  // ============================================================

  Widget _buildHomePage(bool desktop) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroSection(
            desktop: desktop,
            primary: primary,
            gold: gold,
            forest: forest,
            cream: cream,
            onExplore: () => openPage(2),
            onDiscover: () => openPage(1),
          ),

          _IntroStrip(
            desktop: desktop,
            forest: forest,
            gold: gold,
            cream: cream,
          ),

          _FeatureSection(
            desktop: desktop,
            forest: forest,
            forestLight: forestLight,
            gold: gold,
            cream: cream,
            primary: primary,
            onNavigate: openPage,
          ),

          _DestinationsSection(
            desktop: desktop,
            primary: primary,
            forest: forest,
            ink: ink,
            cream: cream,
            onNavigate: openPage,
          ),

          _IndiaSection(
            desktop: desktop,
            forest: forest,
            primary: primary,
            cream: cream,
            ink: ink,
          ),

          _CommunitySection(
            desktop: desktop,
            forest: forest,
            gold: gold,
            primary: primary,
            cream: cream,
            onNavigate: openPage,
          ),

          _WebsiteFooter(
            forest: forest,
            cream: cream,
            gold: gold,
            onNavigate: openPage,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HEADER / NAVIGATION
// ============================================================

class _WebsiteHeader extends StatelessWidget {
  final bool desktop;
  final int selectedIndex;
  final ValueChanged<int> onNavigate;
  final Color forest;
  final Color primary;
  final Color gold;
  final Color cream;

  const _WebsiteHeader({
    required this.desktop,
    required this.selectedIndex,
    required this.onNavigate,
    required this.forest,
    required this.primary,
    required this.gold,
    required this.cream,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: forest,
      padding: EdgeInsets.symmetric(
        horizontal: desktop ? 48 : 20,
        vertical: 16,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.account_balance_rounded,
              color: Color(0xFF263D32),
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SMRITI RAKSHAK',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: cream,
                    fontWeight: FontWeight.w900,
                    letterSpacing: desktop ? 2.2 : 1,
                    fontSize: desktop ? 17 : 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'DISCOVER  •  EXPERIENCE  •  PRESERVE',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: gold,
                    fontSize: desktop ? 9 : 7,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (desktop) ...[
            const Spacer(),
            _NavText(
              'Home',
              selected: selectedIndex == 0,
              onTap: () => onNavigate(0),
            ),
            _NavText(
              'Discover',
              selected: selectedIndex == 1,
              onTap: () => onNavigate(1),
            ),
            _NavText(
              'Explore',
              selected: selectedIndex == 2,
              onTap: () => onNavigate(2),
            ),
            _NavText(
              'Heritage Sites',
              selected: selectedIndex == 5,
              onTap: () => onNavigate(5),
            ),
            _NavText(
              'Culture',
              selected: selectedIndex == 6,
              onTap: () => onNavigate(6),
            ),
            const SizedBox(width: 16),
            FilledButton.icon(
              onPressed: () => onNavigate(4),
              style: FilledButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 17,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.route_rounded, size: 18),
              label: const Text(
                'Plan a Trip',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NavText extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool selected;

  const _NavText(
    this.label, {
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 3,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? const Color(0xFFE8B957)
                      : const Color(0xFFF7F0E3),
                  fontSize: 12,
                  fontWeight:
                      selected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 2,
                width: selected ? 24 : 0,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8B957),
                  borderRadius: BorderRadius.circular(4),
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
// HERO SECTION
// ============================================================

class _HeroSection extends StatelessWidget {
  final bool desktop;
  final Color primary;
  final Color gold;
  final Color forest;
  final Color cream;
  final VoidCallback onExplore;
  final VoidCallback onDiscover;

  const _HeroSection({
    required this.desktop,
    required this.primary,
    required this.gold,
    required this.forest,
    required this.cream,
    required this.onExplore,
    required this.onDiscover,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        desktop ? 32 : 16,
        desktop ? 28 : 16,
        desktop ? 32 : 16,
        24,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(desktop ? 30 : 22),
        child: SizedBox(
          height: desktop ? 510 : 540,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/LostFort.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF7B6042),
                        Color(0xFF263D32),
                        Color(0xFF17271F),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.account_balance_rounded,
                      size: 150,
                      color: Color(0x55FFFFFF),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      forest.withOpacity(0.96),
                      forest.withOpacity(0.82),
                      forest.withOpacity(0.30),
                    ],
                    stops: const [0, 0.48, 1],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(desktop ? 54 : 26),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: gold,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            '✦  INDIA\'S LIVING HERITAGE',
                            style: TextStyle(
                              color: Color(0xFF263D32),
                              fontSize: 10,
                              letterSpacing: 1.4,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Some stories\nwere never meant\nto be forgotten.',
                          style: TextStyle(
                            color: cream,
                            fontSize: desktop ? 54 : 40,
                            height: 1.08,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.6,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Walk through ancient forts, uncover forgotten '
                          'stories, and experience the culture that shaped us.',
                          style: TextStyle(
                            color: cream.withOpacity(0.88),
                            fontSize: desktop ? 16 : 14,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            FilledButton.icon(
                              onPressed: onExplore,
                              style: FilledButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 23,
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              icon: const Icon(Icons.explore_rounded),
                              label: const Text(
                                'Start Exploring',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: onDiscover,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: cream,
                                side: BorderSide(
                                  color: cream.withOpacity(0.7),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              icon: const Icon(Icons.auto_stories_rounded),
                              label: const Text('Discover Stories'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (desktop)
                Positioned(
                  right: 28,
                  bottom: 28,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xDD263D32),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: gold.withOpacity(0.7)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: gold,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'MAHARASHTRA, INDIA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.bold,
                          ),
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
// INTRO STRIP
// ============================================================

class _IntroStrip extends StatelessWidget {
  final bool desktop;
  final Color forest;
  final Color gold;
  final Color cream;

  const _IntroStrip({
    required this.desktop,
    required this.forest,
    required this.gold,
    required this.cream,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.account_balance_rounded, 'Historic Places', 'Explore our past'),
      (Icons.view_in_ar_rounded, 'Immersive Stories', 'See history differently'),
      (Icons.handshake_rounded, 'Living Traditions', 'Meet local creators'),
      (Icons.favorite_rounded, 'Heritage for All', 'Keep culture alive'),
    ];

    return Container(
      color: forest,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: desktop ? 50 : 22,
        vertical: 28,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        runSpacing: 24,
        spacing: 28,
        children: items.map((item) {
          return SizedBox(
            width: desktop ? 205 : 135,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.$1, color: gold, size: 29),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.$2,
                        style: TextStyle(
                          color: cream,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.$3,
                        style: TextStyle(
                          color: cream.withOpacity(0.65),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ============================================================
// FEATURE SECTION
// ============================================================

class _FeatureSection extends StatelessWidget {
  final bool desktop;
  final Color forest;
  final Color forestLight;
  final Color gold;
  final Color cream;
  final Color primary;
  final ValueChanged<int> onNavigate;

  const _FeatureSection({
    required this.desktop,
    required this.forest,
    required this.forestLight,
    required this.gold,
    required this.cream,
    required this.primary,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final features = [
      _FeatureData(
        number: '01',
        title: 'Find Hidden\nHeritage',
        description:
            'Go beyond the usual tourist trail and uncover remarkable places.',
        image: 'assets/images/SinhagadFort.jpg',
        icon: Icons.explore_rounded,
        action: 'Explore places',
        page: 2,
      ),
      _FeatureData(
        number: '02',
        title: 'Step Into\nAnother Era',
        description:
            'Experience history through immersive AR, VR and 3D stories.',
        image: 'assets/images/LostFort.jpg',
        icon: Icons.view_in_ar_rounded,
        action: 'Enter the past',
        page: 9,
      ),
      _FeatureData(
        number: '03',
        title: 'Travel With\nA Story',
        description:
            'Create meaningful journeys around places, people and culture.',
        image: 'assets/images/AgaKhanPalace.jpg',
        icon: Icons.route_rounded,
        action: 'Plan a journey',
        page: 4,
      ),
      _FeatureData(
        number: '04',
        title: 'Keep Traditions\nAlive',
        description:
            'Discover cultural events, artisans and traditions worth saving.',
        image: 'assets/images/ShaniwarWada.jpg',
        icon: Icons.diversity_3_rounded,
        action: 'Meet the community',
        page: 11,
      ),
    ];

    return Container(
      width: double.infinity,
      color: forest,
      padding: EdgeInsets.fromLTRB(
        desktop ? 48 : 20,
        64,
        desktop ? 48 : 20,
        70,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            eyebrow: 'MORE THAN SIGHTSEEING',
            title: 'History is an experience.',
            description:
                'Choose your path into the past. Every place has a story '
                'waiting to be discovered.',
            light: true,
            gold: gold,
            cream: cream,
          ),
          const SizedBox(height: 36),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1050
                  ? 4
                  : constraints.maxWidth >= 600
                      ? 2
                      : 1;

              final cardWidth =
                  (constraints.maxWidth - (columns - 1) * 18) / columns;

              return Wrap(
                spacing: 18,
                runSpacing: 18,
                children: features.map((feature) {
                  return SizedBox(
                    width: cardWidth,
                    child: _FeatureCard(
                      data: feature,
                      forestLight: forestLight,
                      gold: gold,
                      cream: cream,
                      primary: primary,
                      onTap: () => onNavigate(feature.page),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureData {
  final String number;
  final String title;
  final String description;
  final String image;
  final IconData icon;
  final String action;
  final int page;

  const _FeatureData({
    required this.number,
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
    required this.action,
    required this.page,
  });
}

class _FeatureCard extends StatefulWidget {
  final _FeatureData data;
  final Color forestLight;
  final Color gold;
  final Color cream;
  final Color primary;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.data,
    required this.forestLight,
    required this.gold,
    required this.cream,
    required this.primary,
    required this.onTap,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, hovered ? -7 : 0, 0),
        decoration: BoxDecoration(
          color: widget.forestLight,
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: hovered
                ? widget.gold.withOpacity(0.8)
                : Colors.white.withOpacity(0.08),
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 190,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      data.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFF536B52),
                        child: Icon(
                          data.icon,
                          color: widget.cream.withOpacity(0.7),
                          size: 75,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.35),
                            Colors.transparent,
                            Colors.black.withOpacity(0.35),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: widget.gold,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          data.number,
                          style: const TextStyle(
                            color: Color(0xFF263D32),
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xDD263D32),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(
                          data.icon,
                          color: widget.gold,
                          size: 23,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(21, 21, 21, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                        color: widget.cream,
                        fontSize: 24,
                        height: 1.12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      data.description,
                      style: TextStyle(
                        color: widget.cream.withOpacity(0.72),
                        height: 1.65,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 22),
                    InkWell(
                      onTap: widget.onTap,
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              data.action,
                              style: TextStyle(
                                color: widget.gold,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: widget.gold,
                            size: 18,
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

// ============================================================
// HERITAGE DESTINATIONS
// ============================================================

class _DestinationsSection extends StatelessWidget {
  final bool desktop;
  final Color primary;
  final Color forest;
  final Color ink;
  final Color cream;
  final ValueChanged<int> onNavigate;

  const _DestinationsSection({
    required this.desktop,
    required this.primary,
    required this.forest,
    required this.ink,
    required this.cream,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final places = [
      _PlaceData(
        name: 'Shaniwar Wada',
        location: 'Pune, Maharashtra',
        image: 'assets/images/ShaniwarWada.jpg',
        category: 'HISTORIC FORT',
      ),
      _PlaceData(
        name: 'Aga Khan Palace',
        location: 'Pune, Maharashtra',
        image: 'assets/images/AgaKhanPalace.jpg',
        category: 'CULTURAL LANDMARK',
      ),
      _PlaceData(
        name: 'Sinhagad Fort',
        location: 'Pune, Maharashtra',
        image: 'assets/images/SinhagadFort.jpg',
        category: 'HILLTOP FORT',
      ),
    ];

    return Container(
      color: const Color(0xFFF1E6D3),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        desktop ? 48 : 20,
        68,
        desktop ? 48 : 20,
        72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            eyebrow: 'PLACES THAT STAY WITH YOU',
            title: 'Your next story starts here.',
            description:
                'From powerful forts to remarkable landmarks, explore '
                'the places that shaped our history.',
            light: false,
            gold: const Color(0xFFB78A32),
            cream: ink,
          ),
          const SizedBox(height: 34),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 850 ? 3 : 1;
              final width =
                  (constraints.maxWidth - (columns - 1) * 18) / columns;

              return Wrap(
                spacing: 18,
                runSpacing: 18,
                children: places.map((place) {
                  return SizedBox(
                    width: width,
                    child: _DestinationCard(
                      place: place,
                      primary: primary,
                      forest: forest,
                      cream: cream,
                      onTap: () => onNavigate(5),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 30),
          Center(
            child: OutlinedButton.icon(
              onPressed: () => onNavigate(5),
              style: OutlinedButton.styleFrom(
                foregroundColor: forest,
                side: BorderSide(color: forest.withOpacity(0.5)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 17,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text(
                'Explore All Heritage Sites',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceData {
  final String name;
  final String location;
  final String image;
  final String category;

  const _PlaceData({
    required this.name,
    required this.location,
    required this.image,
    required this.category,
  });
}

class _DestinationCard extends StatefulWidget {
  final _PlaceData place;
  final Color primary;
  final Color forest;
  final Color cream;
  final VoidCallback onTap;

  const _DestinationCard({
    required this.place,
    required this.primary,
    required this.forest,
    required this.cream,
    required this.onTap,
  });

  @override
  State<_DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<_DestinationCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final place = widget.place;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, hovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: widget.cream,
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(hovered ? 0.16 : 0.08),
              blurRadius: hovered ? 22 : 12,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 235,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      place.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFD1B994),
                        child: const Icon(
                          Icons.account_balance_rounded,
                          size: 70,
                          color: Color(0xFF8B7654),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.25),
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: widget.cream,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          place.category,
                          style: TextStyle(
                            color: widget.forest,
                            fontSize: 9,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      right: 18,
                      bottom: 17,
                      child: Text(
                        place.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 17, 19, 19),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: widget.primary,
                      size: 19,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        place.location,
                        style: const TextStyle(
                          color: Color(0xFF6F7165),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: widget.onTap,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: widget.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18,
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
  }
}

// ============================================================
// DISCOVER INDIA SECTION
// ============================================================

class _IndiaSection extends StatelessWidget {
  final bool desktop;
  final Color forest;
  final Color primary;
  final Color cream;
  final Color ink;

  const _IndiaSection({
    required this.desktop,
    required this.forest,
    required this.primary,
    required this.cream,
    required this.ink,
  });

  @override
  Widget build(BuildContext context) {
    final places = [
      (
        'Hampi',
        'Karnataka',
        'assets/images/Hampi.jpg',
        Icons.temple_hindu_rounded,
      ),
      (
        'Ajanta Caves',
        'Maharashtra',
        'assets/images/Ajanta.jpg',
        Icons.account_balance_rounded,
      ),
      (
        'Jaipur',
        'Rajasthan',
        'assets/images/Jaipur.jpg',
        Icons.castle_rounded,
      ),
      (
        'Konark',
        'Odisha',
        'assets/images/Konark.jpg',
        Icons.wb_sunny_rounded,
      ),
    ];

    return Container(
      width: double.infinity,
      color: const Color(0xFFDCC8A8),
      padding: EdgeInsets.fromLTRB(
        desktop ? 48 : 20,
        65,
        desktop ? 48 : 20,
        68,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            eyebrow: 'A COUNTRY FULL OF STORIES',
            title: 'India, carved in time.',
            description:
                'Every region holds a different chapter. Start discovering '
                'the architecture, art and traditions of India.',
            light: false,
            gold: const Color(0xFFB78A32),
            cream: ink,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 900
                  ? 4
                  : constraints.maxWidth >= 560
                      ? 2
                      : 1;

              final width =
                  (constraints.maxWidth - (columns - 1) * 14) / columns;

              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: places.map((place) {
                  return SizedBox(
                    width: width,
                    child: _IndiaPlaceCard(
                      name: place.$1,
                      region: place.$2,
                      image: place.$3,
                      icon: place.$4,
                      forest: forest,
                      cream: cream,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _IndiaPlaceCard extends StatefulWidget {
  final String name;
  final String region;
  final String image;
  final IconData icon;
  final Color forest;
  final Color cream;

  const _IndiaPlaceCard({
    required this.name,
    required this.region,
    required this.image,
    required this.icon,
    required this.forest,
    required this.cream,
  });

  @override
  State<_IndiaPlaceCard> createState() => _IndiaPlaceCardState();
}

class _IndiaPlaceCardState extends State<_IndiaPlaceCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, hovered ? -5 : 0, 0),
        height: 280,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                widget.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFBCA47C),
                  child: Icon(
                    widget.icon,
                    size: 70,
                    color: Colors.white70,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.transparent,
                      Colors.black.withOpacity(0.82),
                    ],
                    stops: const [0, 0.35, 1],
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.forest.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    widget.icon,
                    color: const Color(0xFFE8B957),
                    size: 20,
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
                      widget.region.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFFE8B957),
                        letterSpacing: 1.5,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
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

// ============================================================
// COMMUNITY SECTION
// ============================================================

class _CommunitySection extends StatelessWidget {
  final bool desktop;
  final Color forest;
  final Color gold;
  final Color primary;
  final Color cream;
  final ValueChanged<int> onNavigate;

  const _CommunitySection({
    required this.desktop,
    required this.forest,
    required this.gold,
    required this.primary,
    required this.cream,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1E6D3),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        desktop ? 48 : 20,
        16,
        desktop ? 48 : 20,
        70,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: forest,
          borderRadius: BorderRadius.circular(28),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              right: -30,
              top: -35,
              child: Icon(
                Icons.account_balance_rounded,
                size: desktop ? 300 : 200,
                color: Colors.white.withOpacity(0.045),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(desktop ? 42 : 25),
              child: Flex(
                direction: desktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: desktop
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: desktop ? 3 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HERITAGE BELONGS TO ALL OF US',
                          style: TextStyle(
                            color: gold,
                            letterSpacing: 1.4,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 17),
                        Text(
                          'Be a guardian\nof our stories.',
                          style: TextStyle(
                            color: cream,
                            fontSize: desktop ? 38 : 33,
                            height: 1.12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Connect with culture lovers, discover local '
                          'artisans, and help keep our shared heritage alive.',
                          style: TextStyle(
                            color: cream.withOpacity(0.75),
                            fontSize: 13,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () => onNavigate(11),
                          style: FilledButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 17,
                            ),
                          ),
                          icon: const Icon(Icons.groups_rounded),
                          label: const Text(
                            'Join the Community',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (desktop) const SizedBox(width: 45),
                  if (desktop)
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 245,
                        decoration: BoxDecoration(
                          color: const Color(0xFF385745),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: gold.withOpacity(0.35),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.volunteer_activism_rounded,
                              size: 64,
                              color: gold,
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'DISCOVER. SHARE. PRESERVE.',
                              style: TextStyle(
                                color: cream,
                                letterSpacing: 1.4,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 9),
                            Text(
                              'Every story matters.',
                              style: TextStyle(
                                color: cream.withOpacity(0.65),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SECTION HEADING
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String description;
  final bool light;
  final Color gold;
  final Color cream;

  const _SectionTitle({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.light,
    required this.gold,
    required this.cream,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 3,
              decoration: BoxDecoration(
                color: gold,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              eyebrow,
              style: TextStyle(
                color: gold,
                fontSize: 10,
                letterSpacing: 1.7,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        Text(
          title,
          style: TextStyle(
            color: cream,
            fontSize: 34,
            height: 1.15,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.9,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 590),
          child: Text(
            description,
            style: TextStyle(
              color: cream.withOpacity(light ? 0.7 : 0.8),
              fontSize: 13,
              height: 1.75,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// FOOTER
// ============================================================

class _WebsiteFooter extends StatelessWidget {
  final Color forest;
  final Color cream;
  final Color gold;
  final ValueChanged<int> onNavigate;

  const _WebsiteFooter({
    required this.forest,
    required this.cream,
    required this.gold,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1B2D24),
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 24),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_rounded,
            color: gold,
            size: 38,
          ),
          const SizedBox(height: 12),
          Text(
            'SMRITI RAKSHAK',
            style: TextStyle(
              color: cream,
              fontSize: 16,
              letterSpacing: 2,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover • Experience • Preserve',
            style: TextStyle(
              color: cream.withOpacity(0.65),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 22,
            runSpacing: 12,
            children: [
              _FooterLink(
                'Discover',
                () => onNavigate(1),
                cream,
              ),
              _FooterLink(
                'Explore',
                () => onNavigate(2),
                cream,
              ),
              _FooterLink(
                'Heritage Sites',
                () => onNavigate(5),
                cream,
              ),
              _FooterLink(
                'Culture',
                () => onNavigate(6),
                cream,
              ),
              _FooterLink(
                'Community',
                () => onNavigate(11),
                cream,
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.12),
          ),
          const SizedBox(height: 18),
          Text(
            'Preserving yesterday. Inspiring tomorrow.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: cream.withOpacity(0.55),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _FooterLink(this.label, this.onTap, this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}