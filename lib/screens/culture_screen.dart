import 'package:flutter/material.dart';

class CultureScreen extends StatelessWidget {
  const CultureScreen({super.key});

  // ============================================================
  // SMRITI RAKSHAK THEME
  // ============================================================

  static const Color primary = Color(0xFFC94F36);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE8B957);
  static const Color forest = Color(0xFF263D32);
  static const Color forestLight = Color(0xFF385745);
  static const Color sandstone = Color(0xFFE9DDC8);
  static const Color cream = Color(0xFFFAF6EE);
  static const Color ink = Color(0xFF292C25);
  static const Color muted = Color(0xFF77776D);
  static const Color white = Colors.white;

  static const List<Map<String, dynamic>> categories = [
    {'title': 'Folk Arts', 'icon': Icons.palette_rounded, 'color': Color(0xFFEEDCC5)},
    {'title': 'Music & Dance', 'icon': Icons.music_note_rounded, 'color': Color(0xFFF5DCD5)},
    {'title': 'Crafts', 'icon': Icons.brush_rounded, 'color': Color(0xFFDCE8D8)},
    {'title': 'Food', 'icon': Icons.restaurant_rounded, 'color': Color(0xFFF3E7BD)},
    {'title': 'Languages', 'icon': Icons.translate_rounded, 'color': Color(0xFFDFE8F2)},
    {'title': 'Festivals', 'icon': Icons.celebration_rounded, 'color': Color(0xFFF0DDEA)},
  ];

  static const List<Map<String, String>> traditions = [
    {
      'title': 'Paithani',
      'subtitle': 'The royal weave of Maharashtra',
      'image': 'assets/images/paithani.jpeg',
      'tag': 'HANDLOOM',
      'description':
          'Paithani is a celebrated Maharashtrian silk sari known for its intricate motifs, vibrant colours and traditional weaving techniques.',
    },
    {
      'title': 'Warli Art',
      'subtitle': 'Stories painted through symbols',
      'image': 'assets/images/warli.jpeg',
      'tag': 'FOLK ART',
      'description':
          'Warli painting uses simple geometric forms to depict nature, village life, rituals and community celebrations.',
    },
    {
      'title': 'Lavani',
      'subtitle': 'Rhythm, expression and tradition',
      'image': 'assets/images/lavani.jpg',
      'tag': 'DANCE',
      'description':
          'Lavani is a lively Maharashtrian folk performance combining expressive dance, music and storytelling.',
    },
    {
      'title': 'Dhol Tasha',
      'subtitle': 'The powerful beat of celebration',
      'image': 'assets/images/dholTasha.jpeg',
      'tag': 'MUSIC',
      'description':
          'Dhol-Tasha pathaks bring communities together through powerful percussion, rhythmic performances and festive energy.',
    },
  ];

  static const List<Map<String, String>> festivals = [
    {
      'title': 'Ganeshotsav',
      'subtitle': 'A celebration of devotion and community',
      'image': 'assets/images/Ganesh.jpg',
      'tag': 'CULTURAL FESTIVAL',
    },
    {
      'title': 'Gudi Padwa',
      'subtitle': 'Welcome the traditional Maharashtrian New Year',
      'image': 'assets/images/gudiPadwa.jpeg',
      'tag': 'NEW YEAR',
    },
  ];

  static const List<Map<String, String>> makers = [
    {
      'name': 'Paithani Weaver',
      'craft': 'Traditional handloom',
      'image': 'assets/images/weaver.jpeg',
    },
    {
      'name': 'Warli Artist',
      'craft': 'Tribal folk painting',
      'image': 'assets/images/artist.jpeg',
    },
    {
      'name': 'Pottery Artisan',
      'craft': 'Traditional pottery',
      'image': 'assets/images/potter.jpeg',
    },
  ];

  // ============================================================
  // HELPERS
  // ============================================================

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: forest,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  void _goBack(BuildContext context) {
    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      navigator.pop();
    } else {
      _showMessage(context, 'You are already on the first page.');
    }
  }

  void _showTopicDetails(
    BuildContext context,
    String title,
    String description,
    String image,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * 0.82,
          ),
          decoration: const BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  child: SizedBox(
                    height: 230,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _CultureImage(path: image),
                        Positioned(
                          top: 14,
                          right: 14,
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withValues(alpha: 0.45),
                            child: IconButton(
                              tooltip: 'Close',
                              onPressed: () => Navigator.pop(sheetContext),
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LIVING HERITAGE',
                        style: TextStyle(
                          color: primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          color: forest,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        description,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 14,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => Navigator.pop(sheetContext),
                          style: FilledButton.styleFrom(
                            backgroundColor: forest,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          icon: const Icon(Icons.arrow_back_rounded),
                          label: const Text('Continue exploring'),
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

  void _showQuestDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        icon: Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: gold.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.workspace_premium_rounded,
            color: primary,
            size: 42,
          ),
        ),
        title: const Text(
          'Culture Quest',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: forest,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: const Text(
          'Ready to explore Maharashtra’s living heritage? Discover traditions, '
          'learn fascinating facts and test your cultural knowledge.',
          textAlign: TextAlign.center,
          style: TextStyle(color: muted, height: 1.7),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              _showMessage(context, 'Culture Quest is coming soon!');
            },
            child: const Text('Let’s Explore'),
          ),
        ],
      ),
    );
  }

  void _openCategory(BuildContext context, String category) {
    final matching = traditions.where((item) {
      switch (category) {
        case 'Folk Arts':
          return item['title'] == 'Warli Art';
        case 'Music & Dance':
          return item['title'] == 'Lavani' ||
              item['title'] == 'Dhol Tasha';
        case 'Crafts':
          return item['title'] == 'Paithani' ||
              item['title'] == 'Warli Art';
        default:
          return false;
      }
    }).toList();

    if (matching.isNotEmpty) {
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: cream,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
        builder: (sheetContext) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    color: forest,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Discover traditions connected to your interests.',
                  style: TextStyle(color: muted, height: 1.5),
                ),
                const SizedBox(height: 16),
                ...matching.map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 58,
                        height: 58,
                        child: _CultureImage(path: item['image']!),
                      ),
                    ),
                    title: Text(
                      item['title']!,
                      style: const TextStyle(
                        color: forest,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(
                      item['subtitle']!,
                      style: const TextStyle(color: muted, fontSize: 12),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: primary,
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _showTopicDetails(
                        context,
                        item['title']!,
                        item['description']!,
                        item['image']!,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      _showMessage(context, '$category collection is coming soon!');
    }
  }

  // ============================================================
  // MAIN PAGE
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: cream,
              surfaceTintColor: cream,
              pinned: true,
              elevation: 0,
              scrolledUnderElevation: 1,
              leading: IconButton(
                tooltip: 'Back',
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: forest,
                ),
                onPressed: () => _goBack(context),
              ),
              titleSpacing: 0,
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Living Culture',
                    style: TextStyle(
                      color: forest,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Stories, traditions & people',
                    style: TextStyle(
                      color: muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  tooltip: 'Search culture',
                  icon: const Icon(
                    Icons.search_rounded,
                    color: forest,
                    size: 26,
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: _CultureSearchDelegate(
                        onTopicSelected: (topic) {
                          final item = traditions.where(
                            (element) => element['title'] == topic,
                          );

                          if (item.isNotEmpty) {
                            _showTopicDetails(
                              context,
                              item.first['title']!,
                              item.first['description']!,
                              item.first['image']!,
                            );
                          } else {
                            _showMessage(
                              context,
                              '$topic collection is coming soon!',
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // HERO SECTION

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 700;

                      return Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: wide ? 370 : 390,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: forest,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: forest.withValues(alpha: 0.14),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.26,
                                child: _CultureImage(
                                  path: 'assets/images/warli.jpeg',
                                ),
                              ),
                            ),
                            Positioned(
                              right: -70,
                              top: -90,
                              child: Container(
                                width: 270,
                                height: 270,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: gold.withValues(alpha: 0.15),
                                    width: 35,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 25,
                              bottom: 22,
                              child: Icon(
                                Icons.account_balance_rounded,
                                size: wide ? 150 : 90,
                                color: Colors.white.withValues(alpha: 0.07),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(wide ? 38 : 26),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 560,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 13,
                                        vertical: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: gold.withValues(alpha: 0.16),
                                        border: Border.all(
                                          color: gold.withValues(alpha: 0.35),
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.auto_awesome_rounded,
                                            color: gold,
                                            size: 14,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'MAHARASHTRA’S LIVING HERITAGE',
                                            style: TextStyle(
                                              color: gold,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Text(
                                      'Culture is our\nliving legacy.',
                                      style: TextStyle(
                                        color: cream,
                                        fontSize: wide ? 50 : 39,
                                        height: 1.08,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -1.7,
                                      ),
                                    ),
                                    const SizedBox(height: 17),
                                    Text(
                                      'From timeless folk art to vibrant festivals, '
                                      'discover the traditions that make our heritage extraordinary.',
                                      style: TextStyle(
                                        color: cream.withValues(alpha: 0.86),
                                        fontSize: 14,
                                        height: 1.8,
                                      ),
                                    ),
                                    const SizedBox(height: 26),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        FilledButton.icon(
                                          onPressed: () {
                                            _showMessage(
                                              context,
                                              'Explore the collections below!',
                                            );
                                          },
                                          style: FilledButton.styleFrom(
                                            backgroundColor: gold,
                                            foregroundColor: forest,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 19,
                                              vertical: 15,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.explore_rounded,
                                            size: 18,
                                          ),
                                          label: const Text(
                                            'Explore Culture',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        OutlinedButton.icon(
                                          onPressed: () =>
                                              _showQuestDialog(context),
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: cream,
                                            side: BorderSide(
                                              color: cream.withValues(
                                                alpha: 0.5,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 17,
                                              vertical: 15,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.stars_rounded,
                                            size: 18,
                                          ),
                                          label: const Text(
                                            'Culture Quest',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
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
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  // QUICK FACT STRIP

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final compact = constraints.maxWidth < 500;

                      final facts = [
                        (
                          Icons.palette_rounded,
                          'Folk art',
                          'Stories in every stroke',
                        ),
                        (
                          Icons.music_note_rounded,
                          'Traditions',
                          'Rhythm across generations',
                        ),
                        (
                          Icons.people_alt_rounded,
                          'Communities',
                          'People behind our culture',
                        ),
                      ];

                      if (compact) {
                        return Column(
                          children: facts
                              .map(
                                (fact) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: _FactTile(
                                    icon: fact.$1,
                                    title: fact.$2,
                                    subtitle: fact.$3,
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      }

                      return Row(
                        children: facts
                            .map(
                              (fact) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: _FactTile(
                                    icon: fact.$1,
                                    title: fact.$2,
                                    subtitle: fact.$3,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 38),

                  // CULTURE OF THE DAY

                  const _SectionTitle(
                    eyebrow: 'A LITTLE CULTURE, EVERY DAY',
                    title: 'Culture of the day',
                    subtitle: 'One tradition. Countless stories.',
                  ),

                  const SizedBox(height: 18),

                  _CultureOfDayCard(
                    onTap: () => _showTopicDetails(
                      context,
                      'Lavani',
                      traditions[2]['description']!,
                      'assets/images/lavani.jpg',
                    ),
                  ),

                  const SizedBox(height: 40),

                  // CATEGORIES

                  const _SectionTitle(
                    eyebrow: 'FIND YOUR INTEREST',
                    title: 'Explore culture',
                    subtitle: 'Which part of our heritage calls to you?',
                  ),

                  const SizedBox(height: 18),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth >= 950
                          ? 6
                          : constraints.maxWidth >= 560
                              ? 3
                              : 2;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 13,
                          childAspectRatio: 1.04,
                        ),
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          return _CultureCategory(
                            title: category['title'] as String,
                            icon: category['icon'] as IconData,
                            color: category['color'] as Color,
                            onTap: () => _openCategory(
                              context,
                              category['title'] as String,
                            ),
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // TRADITIONS

                  _SectionTitle(
                    eyebrow: 'ROOTED IN HISTORY',
                    title: 'Discover traditions',
                    subtitle:
                        'Meet the practices passed down through generations.',
                    action: 'Explore all',
                    onAction: () => _showMessage(
                      context,
                      'You are viewing our featured traditions.',
                    ),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    height: 310,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: traditions.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final item = traditions[index];

                        return _TraditionCard(
                          title: item['title']!,
                          subtitle: item['subtitle']!,
                          image: item['image']!,
                          tag: item['tag']!,
                          onTap: () => _showTopicDetails(
                            context,
                            item['title']!,
                            item['description']!,
                            item['image']!,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  // FESTIVALS

                  const _SectionTitle(
                    eyebrow: 'CELEBRATE TOGETHER',
                    title: 'Festivals & events',
                    subtitle:
                        'Celebrations that bring communities together.',
                  ),

                  const SizedBox(height: 18),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 600;

                      if (wide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: festivals.map((festival) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: festival == festivals.first ? 14 : 0,
                                ),
                                child: _FestivalCard(
                                  title: festival['title']!,
                                  subtitle: festival['subtitle']!,
                                  image: festival['image']!,
                                  tag: festival['tag']!,
                                  onTap: () => _showMessage(
                                    context,
                                    '${festival['title']} details coming soon!',
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }

                      return Column(
                        children: festivals.map((festival) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: _FestivalCard(
                              title: festival['title']!,
                              subtitle: festival['subtitle']!,
                              image: festival['image']!,
                              tag: festival['tag']!,
                              onTap: () => _showMessage(
                                context,
                                '${festival['title']} details coming soon!',
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // QUEST BANNER

                  _CultureQuestCard(
                    onTap: () => _showQuestDialog(context),
                  ),

                  const SizedBox(height: 40),

                  // MAKERS

                  const _SectionTitle(
                    eyebrow: 'HANDS THAT KEEP HISTORY ALIVE',
                    title: 'Meet the makers',
                    subtitle:
                        'Discover the people behind our living traditions.',
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    height: 230,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: makers.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final maker = makers[index];

                        return _MakerCard(
                          name: maker['name']!,
                          craft: maker['craft']!,
                          image: maker['image']!,
                          onTap: () => _showMessage(
                            context,
                            '${maker['name']} profile coming soon!',
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 34),

                  // CLOSING BANNER

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE3D1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: sandstone.withValues(alpha: 0.9),
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final compact = constraints.maxWidth < 420;

                        final icon = Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.account_balance_rounded,
                            color: primary,
                            size: 30,
                          ),
                        );

                        final text = const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Heritage lives through us.',
                              style: TextStyle(
                                color: forest,
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.4,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              'Discover it. Experience it. Preserve it.',
                              style: TextStyle(
                                color: muted,
                                fontSize: 12,
                                height: 1.6,
                              ),
                            ),
                          ],
                        );

                        if (compact) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              icon,
                              const SizedBox(height: 16),
                              text,
                            ],
                          );
                        }

                        return Row(
                          children: [
                            icon,
                            const SizedBox(width: 16),
                            Expanded(child: text),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 26),

                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'SMRITI RAKSHAK',
                          style: TextStyle(
                            color: forest,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.5,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Keeping our stories alive, for generations.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: muted,
                            fontSize: 11,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// FACT TILE
// ================================================================

class _FactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FactTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: CultureScreen.sandstone),
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: CultureScreen.cream,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: CultureScreen.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: CultureScreen.forest,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: CultureScreen.muted,
                    fontSize: 10,
                    height: 1.4,
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

// ================================================================
// SECTION TITLE
// ================================================================

class _SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final String? action;
  final VoidCallback? onAction;

  const _SectionTitle({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            color: CultureScreen.primary,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: CultureScreen.forest,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.9,
                ),
              ),
            ),
            if (action != null)
              TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(
                  foregroundColor: CultureScreen.primary,
                  padding: const EdgeInsets.only(left: 8, bottom: 3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      action!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_rounded, size: 15),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: CultureScreen.muted,
            fontSize: 13,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

// ================================================================
// CULTURE OF THE DAY
// ================================================================

class _CultureOfDayCard extends StatelessWidget {
  final VoidCallback onTap;

  const _CultureOfDayCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: BoxDecoration(
        color: CultureScreen.forest,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: CultureScreen.forest.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _CultureImage(path: 'assets/images/lavani.jpg'),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.transparent,
                  CultureScreen.forest.withValues(alpha: 0.45),
                  CultureScreen.forest.withValues(alpha: 0.97),
                ],
                stops: const [0, 0.35, 1],
              ),
            ),
          ),
          Positioned(
            right: -25,
            bottom: -45,
            child: Icon(
              Icons.theater_comedy_rounded,
              size: 180,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: CultureScreen.gold,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        '✦  TODAY’S PICK',
                        style: TextStyle(
                          color: CultureScreen.forest,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'Lavani',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'The expressive folk dance of Maharashtra, '
                      'celebrated for its rhythm, storytelling and energy.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 17),
                    TextButton.icon(
                      onPressed: onTap,
                      style: TextButton.styleFrom(
                        foregroundColor: CultureScreen.gold,
                        padding: EdgeInsets.zero,
                      ),
                      icon: const Text(
                        'Discover its story',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      label: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// CATEGORY TILE
// ================================================================

class _CultureCategory extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CultureCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<_CultureCategory> createState() => _CultureCategoryState();
}

class _CultureCategoryState extends State<_CultureCategory> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: isHovered ? CultureScreen.forest : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isHovered
                ? CultureScreen.forest
                : CultureScreen.sandstone.withValues(alpha: 0.8),
          ),
          boxShadow: [
            BoxShadow(
              color: CultureScreen.forest.withValues(
                alpha: isHovered ? 0.13 : 0.035,
              ),
              blurRadius: isHovered ? 18 : 8,
              offset: Offset(0, isHovered ? 8 : 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(22),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: isHovered
                          ? Colors.white.withValues(alpha: 0.12)
                          : widget.color,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      widget.icon,
                      color: isHovered ? CultureScreen.gold : CultureScreen.forest,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isHovered ? Colors.white : CultureScreen.forest,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: isHovered
                        ? CultureScreen.gold
                        : CultureScreen.primary.withValues(alpha: 0.8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// TRADITION CARD
// ================================================================

class _TraditionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final String tag;
  final VoidCallback onTap;

  const _TraditionCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.tag,
    required this.onTap,
  });

  @override
  State<_TraditionCard> createState() => _TraditionCardState();
}

class _TraditionCardState extends State<_TraditionCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 235,
        transform: Matrix4.translationValues(0, isHovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: CultureScreen.forest.withValues(
                alpha: isHovered ? 0.12 : 0.045,
              ),
              blurRadius: isHovered ? 20 : 9,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _CultureImage(path: widget.image),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.05),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.2),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: CultureScreen.cream,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            widget.tag,
                            style: const TextStyle(
                              color: CultureScreen.forest,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_outward_rounded,
                            color: CultureScreen.primary,
                            size: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 14, 15, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CultureScreen.forest,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CultureScreen.muted,
                          fontSize: 11,
                          height: 1.5,
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

// ================================================================
// FESTIVAL CARD
// ================================================================

class _FestivalCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final String tag;
  final VoidCallback onTap;

  const _FestivalCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.tag,
    required this.onTap,
  });

  @override
  State<_FestivalCard> createState() => _FestivalCardState();
}

class _FestivalCardState extends State<_FestivalCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: CultureScreen.forest.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _CultureImage(path: widget.image),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.4),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        bottom: 13,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: CultureScreen.gold,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            widget.tag,
                            style: const TextStyle(
                              color: CultureScreen.forest,
                              fontSize: 9,
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
                  padding: const EdgeInsets.all(17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: CultureScreen.forest,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: CultureScreen.muted,
                          fontSize: 12,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Discover tradition',
                            style: TextStyle(
                              color: CultureScreen.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: CultureScreen.primary,
                            size: 16,
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

// ================================================================
// CULTURE QUEST
// ================================================================

class _CultureQuestCard extends StatelessWidget {
  final VoidCallback onTap;

  const _CultureQuestCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CultureScreen.forest,
        borderRadius: BorderRadius.circular(26),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -25,
            bottom: -40,
            child: Icon(
              Icons.explore_rounded,
              size: 200,
              color: Colors.white.withValues(alpha: 0.055),
            ),
          ),
          Positioned(
            right: 25,
            top: 20,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 32,
              color: CultureScreen.gold.withValues(alpha: 0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: CultureScreen.gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: CultureScreen.gold.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: CultureScreen.gold,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your next adventure\nstarts with a question.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    height: 1.2,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 11),
                Text(
                  'Test what you know, discover something new, '
                  'and celebrate the culture around you.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 12,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 21),
                FilledButton.icon(
                  onPressed: onTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: CultureScreen.gold,
                    foregroundColor: CultureScreen.forest,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward_rounded, size: 17),
                  label: const Text(
                    'Start Culture Quest',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
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

// ================================================================
// MAKER CARD
// ================================================================

class _MakerCard extends StatefulWidget {
  final String name;
  final String craft;
  final String image;
  final VoidCallback onTap;

  const _MakerCard({
    required this.name,
    required this.craft,
    required this.image,
    required this.onTap,
  });

  @override
  State<_MakerCard> createState() => _MakerCardState();
}

class _MakerCardState extends State<_MakerCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 180,
        transform: Matrix4.translationValues(0, isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          boxShadow: [
            BoxShadow(
              color: CultureScreen.forest.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _CultureImage(path: widget.image),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 31,
                            height: 31,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.94),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_outline_rounded,
                              color: CultureScreen.primary,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 12, 13, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CultureScreen.forest,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.craft,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CultureScreen.muted,
                          fontSize: 10,
                          height: 1.5,
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

// ================================================================
// IMAGE WITH FALLBACK
// ================================================================

class _CultureImage extends StatelessWidget {
  final String path;

  const _CultureImage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: CultureScreen.sandstone,
          alignment: Alignment.center,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                color: CultureScreen.forest,
                size: 36,
              ),
              SizedBox(height: 6),
              Text(
                'Image unavailable',
                style: TextStyle(
                  color: CultureScreen.forest,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ================================================================
// CULTURE SEARCH
// ================================================================

class _CultureSearchDelegate extends SearchDelegate<String> {
  final ValueChanged<String> onTopicSelected;

  _CultureSearchDelegate({required this.onTopicSelected});

  final List<Map<String, String>> topics = const [
    {
      'title': 'Folk Arts',
      'subtitle': 'Traditional visual arts and storytelling',
    },
    {
      'title': 'Music & Dance',
      'subtitle': 'Lavani, folk music and traditional performances',
    },
    {
      'title': 'Crafts',
      'subtitle': 'Paithani weaving, Warli art and pottery',
    },
    {
      'title': 'Food',
      'subtitle': 'Regional flavours and culinary traditions',
    },
    {
      'title': 'Languages',
      'subtitle': 'Languages, dialects and oral traditions',
    },
    {
      'title': 'Festivals',
      'subtitle': 'Ganeshotsav, Gudi Padwa and more',
    },
    {
      'title': 'Paithani',
      'subtitle': 'The traditional silk weave of Maharashtra',
    },
    {
      'title': 'Warli Art',
      'subtitle': 'Tribal painting and storytelling',
    },
    {
      'title': 'Lavani',
      'subtitle': 'Maharashtrian folk dance',
    },
    {
      'title': 'Dhol Tasha',
      'subtitle': 'Traditional percussion and celebration',
    },
    {
      'title': 'Ganeshotsav',
      'subtitle': 'A festival of devotion and community',
    },
    {
      'title': 'Gudi Padwa',
      'subtitle': 'The traditional Maharashtrian New Year',
    },
    {
      'title': 'Paithani Weaver',
      'subtitle': 'Traditional handloom artisan',
    },
    {
      'title': 'Warli Artist',
      'subtitle': 'Traditional folk artist',
    },
    {
      'title': 'Pottery Artisan',
      'subtitle': 'Traditional pottery maker',
    },
  ];

  @override
  String get searchFieldLabel => 'Search traditions, art, festivals...';

  @override
  TextStyle get searchFieldStyle => const TextStyle(
        color: CultureScreen.forest,
        fontSize: 15,
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: CultureScreen.cream,
      appBarTheme: const AppBarTheme(
        backgroundColor: CultureScreen.cream,
        foregroundColor: CultureScreen.forest,
        elevation: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: CultureScreen.muted),
        border: InputBorder.none,
      ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: CultureScreen.primary,
            surface: CultureScreen.cream,
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Clear search',
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final searchText = query.trim().toLowerCase();

    final results = topics.where((topic) {
      return topic['title']!.toLowerCase().contains(searchText) ||
          topic['subtitle']!.toLowerCase().contains(searchText);
    }).toList();

    if (results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 46,
              color: CultureScreen.muted,
            ),
            SizedBox(height: 12),
            Text(
              'No cultural topics found',
              style: TextStyle(
                color: CultureScreen.forest,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Try searching for art, dance or festivals.',
              style: TextStyle(
                color: CultureScreen.muted,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final topic = results[index];

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            leading: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: CultureScreen.cream,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.auto_stories_rounded,
                color: CultureScreen.primary,
              ),
            ),
            title: Text(
              topic['title']!,
              style: const TextStyle(
                color: CultureScreen.forest,
                fontWeight: FontWeight.w900,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                topic['subtitle']!,
                style: const TextStyle(
                  color: CultureScreen.muted,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: CultureScreen.primary,
              size: 15,
            ),
            onTap: () {
              final title = topic['title']!;
              close(context, title);
              onTopicSelected(title);
            },
          ),
        );
      },
    );
  }
}