
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

  // ============================================================
  // CATEGORY DATA
  // Images are added to category cards for a richer UI.
  // ============================================================

  static const List<Map<String, dynamic>> categories = [
    {
      'title': 'Folk Arts',
      'icon': Icons.palette_rounded,
      'image': 'assets/images/warli.jpeg',
      'color': Color(0xFFEEDCC5),
      'description': 'Art that tells stories of everyday life.',
    },
    {
      'title': 'Music & Dance',
      'icon': Icons.music_note_rounded,
      'image': 'assets/images/lavani.jpg',
      'color': Color(0xFFF5DCD5),
      'description': 'Feel the rhythm of living traditions.',
    },
    {
      'title': 'Crafts',
      'icon': Icons.brush_rounded,
      'image': 'assets/images/paithani.jpeg',
      'color': Color(0xFFDCE8D8),
      'description': 'Discover the skill behind handmade treasures.',
    },
    {
      'title': 'Food',
      'icon': Icons.restaurant_rounded,
      'image': 'assets/images/potter.jpeg',
      'color': Color(0xFFF3E7BD),
      'description': 'Explore regional flavours and food stories.',
    },
    {
      'title': 'Languages',
      'icon': Icons.translate_rounded,
      'image': 'assets/images/artist.jpeg',
      'color': Color(0xFFDFE8F2),
      'description': 'Discover the voices that carry our stories.',
    },
    {
      'title': 'Festivals',
      'icon': Icons.celebration_rounded,
      'image': 'assets/images/Ganesh.jpg',
      'color': Color(0xFFF0DDEA),
      'description': 'Celebrate traditions that unite communities.',
    },
  ];

  // ============================================================
  // TRADITIONS
  // ============================================================

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
      'description':
          'Ganeshotsav brings communities together through devotion, public celebrations, music, art and shared traditions.',
    },
    {
      'title': 'Gudi Padwa',
      'subtitle': 'Welcome the traditional Maharashtrian New Year',
      'image': 'assets/images/gudiPadwa.jpeg',
      'tag': 'NEW YEAR',
      'description':
          'Gudi Padwa marks the traditional Maharashtrian New Year and is celebrated with decorated gudis, festive food and family traditions.',
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
            maxHeight: MediaQuery.of(sheetContext).size.height * 0.86,
          ),
          decoration: const BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _CultureImage(path: image),
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
                        left: 22,
                        bottom: 22,
                        right: 70,
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.8,
                            shadows: [
                              Shadow(
                                color: Colors.black38,
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 14,
                        right: 14,
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withValues(alpha: 0.5),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: gold.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          '✦  LIVING HERITAGE',
                          style: TextStyle(
                            color: primaryDark,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        description,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 14,
                          height: 1.9,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: sandstone),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.favorite_rounded,
                              color: primary,
                              size: 24,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Every tradition carries a story worth preserving.',
                                style: TextStyle(
                                  color: forest,
                                  fontSize: 12,
                                  height: 1.6,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          icon: const Icon(Icons.explore_rounded),
                          label: const Text(
                            'Continue exploring',
                            style: TextStyle(fontWeight: FontWeight.w800),
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
    final List<Map<String, String>> matching;

    switch (category) {
      case 'Folk Arts':
        matching = traditions
            .where((item) => item['title'] == 'Warli Art')
            .toList();
        break;

      case 'Music & Dance':
        matching = traditions
            .where(
              (item) =>
                  item['title'] == 'Lavani' ||
                  item['title'] == 'Dhol Tasha',
            )
            .toList();
        break;

      case 'Crafts':
        matching = traditions
            .where(
              (item) =>
                  item['title'] == 'Paithani' ||
                  item['title'] == 'Warli Art',
            )
            .toList();
        break;

      case 'Festivals':
        matching = festivals;
        break;

      case 'Food':
        _showMessage(
          context,
          'Our regional food stories collection is coming soon!',
        );
        return;

      case 'Languages':
        _showMessage(
          context,
          'Our languages and oral traditions collection is coming soon!',
        );
        return;

      default:
        matching = [];
    }

    if (matching.isEmpty) {
      _showMessage(context, '$category collection is coming soon!');
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: cream,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: sandstone,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                category,
                style: const TextStyle(
                  color: forest,
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Choose a story and discover the tradition behind it.',
                style: TextStyle(color: muted, height: 1.5),
              ),
              const SizedBox(height: 18),
              ...matching.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(17),
                      onTap: () {
                        Navigator.pop(sheetContext);
                        _showTopicDetails(
                          context,
                          item['title']!,
                          item['description']!,
                          item['image']!,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: SizedBox(
                                width: 72,
                                height: 72,
                                child: _CultureImage(path: item['image']!),
                              ),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: const TextStyle(
                                      color: forest,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    item['subtitle']!,
                                    style: const TextStyle(
                                      color: muted,
                                      fontSize: 11,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectSearchTopic(BuildContext context, String topic) {
    final traditionMatches =
        traditions.where((item) => item['title'] == topic).toList();

    if (traditionMatches.isNotEmpty) {
      final item = traditionMatches.first;
      _showTopicDetails(
        context,
        item['title']!,
        item['description']!,
        item['image']!,
      );
      return;
    }

    final festivalMatches =
        festivals.where((item) => item['title'] == topic).toList();

    if (festivalMatches.isNotEmpty) {
      final item = festivalMatches.first;
      _showTopicDetails(
        context,
        item['title']!,
        item['description']!,
        item['image']!,
      );
      return;
    }

    _openCategory(context, topic);
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
                        onTopicSelected: (topic) =>
                            _selectSearchTopic(context, topic),
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
                  // ==================================================
                  // HERO
                  // ==================================================

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 700;

                      return Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: wide ? 400 : 430,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: forest,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: forest.withValues(alpha: 0.17),
                              blurRadius: 25,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.31,
                                child: _CultureImage(
                                  path: 'assets/images/warli.jpeg',
                                ),
                              ),
                            ),
                            const Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xF5263D32),
                                      Color(0xD9263D32),
                                      Color(0x55263D32),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -65,
                              top: -80,
                              child: Container(
                                width: 260,
                                height: 260,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: gold.withValues(alpha: 0.17),
                                    width: 32,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 16,
                              child: Icon(
                                Icons.account_balance_rounded,
                                size: wide ? 175 : 115,
                                color: Colors.white.withValues(alpha: 0.09),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(wide ? 38 : 25),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 570,
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
                                          color: gold.withValues(alpha: 0.4),
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
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      'Culture is our\nliving legacy.',
                                      style: TextStyle(
                                        color: cream,
                                        fontSize: wide ? 51 : 39,
                                        height: 1.08,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -1.7,
                                      ),
                                    ),
                                    const SizedBox(height: 17),
                                    Text(
                                      'Every art form holds a memory. Every rhythm '
                                      'carries a story. Discover the traditions that '
                                      'keep Maharashtra’s identity alive.',
                                      style: TextStyle(
                                        color: cream.withValues(alpha: 0.9),
                                        fontSize: 13,
                                        height: 1.8,
                                      ),
                                    ),
                                    const SizedBox(height: 25),
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
                                              horizontal: 18,
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
                                                alpha: 0.55,
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

                  const SizedBox(height: 22),

                  // ==================================================
                  // QUICK FACTS
                  // ==================================================

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final compact = constraints.maxWidth < 540;

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

                  // ==================================================
                  // CULTURE OF THE DAY
                  // ==================================================

                  const _SectionTitle(
                    eyebrow: 'A LITTLE CULTURE, EVERY DAY',
                    title: 'Culture of the day',
                    subtitle: 'One tradition. Countless stories.',
                  ),

                  const SizedBox(height: 18),

                  _CultureOfDayCard(
                    onTap: () => _showTopicDetails(
                      context,
                      traditions[2]['title']!,
                      traditions[2]['description']!,
                      traditions[2]['image']!,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ==================================================
                  // CATEGORIES WITH IMAGES
                  // ==================================================

                  const _SectionTitle(
                    eyebrow: 'FIND YOUR INTEREST',
                    title: 'Explore culture',
                    subtitle: 'Choose a path into Maharashtra’s heritage.',
                  ),

                  const SizedBox(height: 18),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth >= 1000
                          ? 3
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
                          childAspectRatio: constraints.maxWidth >= 700
                              ? 1.18
                              : 0.92,
                        ),
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          return _CultureCategory(
                            title: category['title'] as String,
                            icon: category['icon'] as IconData,
                            image: category['image'] as String,
                            color: category['color'] as Color,
                            description: category['description'] as String,
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

                  // ==================================================
                  // TRADITIONS
                  // ==================================================

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
                    height: 325,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: traditions.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 15),
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

                  // ==================================================
                  // FESTIVALS
                  // ==================================================

                  const _SectionTitle(
                    eyebrow: 'CELEBRATE TOGETHER',
                    title: 'Festivals & celebrations',
                    subtitle: 'Traditions that bring communities together.',
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
                                  onTap: () => _showTopicDetails(
                                    context,
                                    festival['title']!,
                                    festival['description']!,
                                    festival['image']!,
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
                              onTap: () => _showTopicDetails(
                                context,
                                festival['title']!,
                                festival['description']!,
                                festival['image']!,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // QUEST BANNER WITH BACKGROUND IMAGE
                  // ==================================================

                  _CultureQuestCard(
                    onTap: () => _showQuestDialog(context),
                  ),

                  const SizedBox(height: 40),

                  // ==================================================
                  // MAKERS
                  // ==================================================

                  const _SectionTitle(
                    eyebrow: 'HANDS THAT KEEP HISTORY ALIVE',
                    title: 'Meet the makers',
                    subtitle:
                        'Discover the people and skills behind our traditions.',
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    height: 245,
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

                  const SizedBox(height: 35),

                  // ==================================================
                  // CLOSING BANNER
                  // ==================================================

                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE3D1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: sandstone),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -10,
                          top: 0,
                          bottom: 0,
                          width: 150,
                          child: Opacity(
                            opacity: 0.22,
                            child: _CultureImage(
                              path: 'assets/images/paithani.jpeg',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
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

                              const text = Column(
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
                                  const Expanded(child: text),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
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
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: CultureScreen.sandstone),
        boxShadow: [
          BoxShadow(
            color: CultureScreen.forest.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: CultureScreen.cream,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: CultureScreen.primary, size: 23),
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
      height: 300,
      decoration: BoxDecoration(
        color: CultureScreen.forest,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: CultureScreen.forest.withValues(alpha: 0.14),
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
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.transparent,
                  Color(0xAA263D32),
                  Color(0xF5263D32),
                ],
                stops: [0, 0.42, 1],
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
                constraints: const BoxConstraints(maxWidth: 320),
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
                        color: Colors.white.withValues(alpha: 0.92),
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
// IMAGE-BACKED CATEGORY CARD
// ================================================================

class _CultureCategory extends StatefulWidget {
  final String title;
  final IconData icon;
  final String image;
  final Color color;
  final String description;
  final VoidCallback onTap;

  const _CultureCategory({
    required this.title,
    required this.icon,
    required this.image,
    required this.color,
    required this.description,
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
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isHovered ? CultureScreen.primary : CultureScreen.sandstone,
            width: isHovered ? 1.4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: CultureScreen.forest.withValues(
                alpha: isHovered ? 0.13 : 0.05,
              ),
              blurRadius: isHovered ? 18 : 9,
              offset: Offset(0, isHovered ? 8 : 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedOpacity(
                  opacity: isHovered ? 1 : 0.88,
                  duration: const Duration(milliseconds: 200),
                  child: _CultureImage(path: widget.image),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        CultureScreen.forest.withValues(alpha: 0.02),
                        CultureScreen.forest.withValues(alpha: 0.25),
                        CultureScreen.forest.withValues(alpha: 0.94),
                      ],
                      stops: const [0, 0.35, 1],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      color: CultureScreen.forest,
                      size: 21,
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isHovered
                          ? CultureScreen.gold
                          : Colors.white.withValues(alpha: 0.92),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      size: 16,
                      color: CultureScreen.forest,
                    ),
                  ),
                ),
                Positioned(
                  left: 13,
                  right: 12,
                  bottom: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: 10,
                          height: 1.45,
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
        width: 245,
        transform: Matrix4.translationValues(0, isHovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          border: Border.all(color: CultureScreen.sandstone),
          boxShadow: [
            BoxShadow(
              color: CultureScreen.forest.withValues(
                alpha: isHovered ? 0.13 : 0.05,
              ),
              blurRadius: isHovered ? 20 : 10,
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
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x11000000),
                              Colors.transparent,
                              Color(0x55000000),
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
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: isHovered
                                ? CultureScreen.gold
                                : Colors.white.withValues(alpha: 0.96),
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
          border: Border.all(color: CultureScreen.sandstone),
          boxShadow: [
            BoxShadow(
              color: CultureScreen.forest.withValues(alpha: 0.07),
              blurRadius: 16,
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
                  height: 205,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _CultureImage(path: widget.image),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0x66000000),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 13,
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
                      Positioned(
                        right: 13,
                        bottom: 13,
                        child: Container(
                          width: 37,
                          height: 37,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.96),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_outward_rounded,
                            color: CultureScreen.primary,
                            size: 18,
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
// CULTURE QUEST BANNER WITH IMAGE
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
        boxShadow: [
          BoxShadow(
            color: CultureScreen.forest.withValues(alpha: 0.13),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.19,
              child: _CultureImage(path: 'assets/images/warli.jpeg'),
            ),
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xF5263D32),
                    Color(0xD9263D32),
                    Color(0x77263D32),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -25,
            bottom: -40,
            child: Icon(
              Icons.explore_rounded,
              size: 200,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Positioned(
            right: 25,
            top: 20,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 32,
              color: CultureScreen.gold.withValues(alpha: 0.65),
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
                    color: CultureScreen.gold.withValues(alpha: 0.17),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: CultureScreen.gold.withValues(alpha: 0.4),
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
                  'Test what you know, uncover fascinating facts, '
                  'and celebrate the culture around you.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
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
        width: 185,
        transform: Matrix4.translationValues(0, isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(color: CultureScreen.sandstone),
          boxShadow: [
            BoxShadow(
              color: CultureScreen.forest.withValues(alpha: 0.07),
              blurRadius: 14,
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
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color(0x33000000),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.95),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_outline_rounded,
                              color: CultureScreen.primary,
                              size: 19,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: CultureScreen.gold,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'ARTISAN',
                              style: TextStyle(
                                color: CultureScreen.forest,
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                              ),
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
                Icons.auto_stories_rounded,
                color: CultureScreen.forest,
                size: 36,
              ),
              SizedBox(height: 6),
              Text(
                'Heritage collection',
                style: TextStyle(
                  color: CultureScreen.forest,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
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
