import 'package:flutter/material.dart';

class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});

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

  static const Color teal = Color(0xFF477F86);
  static const Color green = Color(0xFF587B5B);

  void _showComingSoon(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: Text(
          '$title will be available soon.',
          style: const TextStyle(
            color: secondaryText,
            height: 1.5,
          ),
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: textColor,
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quest',
              style: TextStyle(
                color: textColor,
                fontSize: 21,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              'Turn exploration into an adventure',
              style: TextStyle(
                color: secondaryText,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: sandstone),
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: Color(0xFFB78725),
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 950;

            final horizontalPadding =
                constraints.maxWidth >= 1200
                    ? 40.0
                    : constraints.maxWidth >= 700
                        ? 28.0
                        : 16.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                18,
                horizontalPadding,
                40,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1180,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _intro(isWide),
                      const SizedBox(height: 26),

                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 5,
                              child: _ProgressCard(),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  const _StreakCard(),
                                  const SizedBox(height: 16),
                                  const _SectionTitle(
                                    icon: Icons.today_rounded,
                                    title: "Today's Quest",
                                  ),
                                  const SizedBox(height: 13),
                                  const _DailyQuestCard(),
                                ],
                              ),
                            ),
                          ],
                        )
                      else ...[
                        const _ProgressCard(),
                        const SizedBox(height: 15),
                        const _StreakCard(),
                        const SizedBox(height: 28),
                        const _SectionTitle(
                          icon: Icons.today_rounded,
                          title: "Today's Quest",
                        ),
                        const SizedBox(height: 13),
                        const _DailyQuestCard(),
                      ],

                      const SizedBox(height: 34),

                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _categoriesSection(),
                            ),
                            const SizedBox(width: 28),
                            const Expanded(
                              child: _EarnSection(),
                            ),
                          ],
                        )
                      else ...[
                        _categoriesSection(),
                        const SizedBox(height: 32),
                        const _EarnSection(),
                      ],

                      const SizedBox(height: 34),

                      _SectionTitle(
                        icon: Icons.workspace_premium_rounded,
                        title: 'Your Badges',
                        action: 'View all',
                        onAction: () => _showComingSoon(
                          context,
                          'All Badges',
                        ),
                      ),
                      const SizedBox(height: 15),
                      const _BadgesSection(),

                      const SizedBox(height: 34),

                      const _SectionTitle(
                        icon: Icons.menu_book_rounded,
                        title: 'Heritage Passport',
                      ),
                      const SizedBox(height: 15),
                      const _PassportCard(),

                      const SizedBox(height: 30),
                      const Divider(color: sandstone),
                      const SizedBox(height: 22),

                      const Center(
                        child: Text(
                          'SMRITI RAKSHAK',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.2,
                            color: forest,
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Center(
                        child: Text(
                          'Discover • Experience • Preserve',
                          style: TextStyle(
                            fontSize: 11,
                            color: secondaryText,
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
      ),
    );
  }

  // ============================================================
  // INTRO
  // ============================================================

  Widget _intro(bool isWide) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Heritage Journey',
                style: TextStyle(
                  fontSize: isWide ? 31 : 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.7,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Complete challenges, discover heritage and earn rewards.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: secondaryText,
                ),
              ),
            ],
          ),
        ),
        if (isWide) ...[
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: sandstone),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.stars_rounded,
                  color: Color(0xFFB78725),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Collect points. Unlock badges.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // QUEST CATEGORIES
  // ============================================================

  Widget _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          icon: Icons.grid_view_rounded,
          title: 'Quest Categories',
        ),
        const SizedBox(height: 15),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 570 ? 3 : 2;

            return GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: const [
                _QuestCategory(
                  icon: Icons.account_balance_rounded,
                  title: 'Heritage Hunt',
                  subtitle: 'Discover monuments',
                  color: primary,
                ),
                _QuestCategory(
                  icon: Icons.theater_comedy_rounded,
                  title: 'Culture Challenge',
                  subtitle: 'Test your knowledge',
                  color: teal,
                ),
                _QuestCategory(
                  icon: Icons.auto_stories_rounded,
                  title: 'Story Seeker',
                  subtitle: 'Explore heritage stories',
                  color: Color(0xFFB78725),
                ),
                _QuestCategory(
                  icon: Icons.explore_rounded,
                  title: 'Explorer Quest',
                  subtitle: 'Discover new places',
                  color: green,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ================================================================
// SECTION TITLE
// ================================================================

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const _SectionTitle({
    required this.icon,
    required this.title,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: QuestScreen.primary.withOpacity(0.09),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            color: QuestScreen.primary,
            size: 19,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
              color: QuestScreen.textColor,
            ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              action!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: QuestScreen.primary,
              ),
            ),
          ),
      ],
    );
  }
}

// ================================================================
// PROGRESS CARD
// ================================================================

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            QuestScreen.forest,
            QuestScreen.forestLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: QuestScreen.forest.withOpacity(0.13),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
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
                  color: Colors.white.withOpacity(0.11),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: QuestScreen.gold,
                  size: 29,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1,250',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 29,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Heritage Points',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: QuestScreen.gold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: QuestScreen.gold.withOpacity(0.35),
                  ),
                ),
                child: const Text(
                  'BRONZE',
                  style: TextStyle(
                    color: QuestScreen.gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 27),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Progress to Silver',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '72%',
                style: TextStyle(
                  color: QuestScreen.gold,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0.72,
              minHeight: 9,
              backgroundColor: Color(0x33FFFFFF),
              valueColor: AlwaysStoppedAnimation<Color>(
                QuestScreen.gold,
              ),
            ),
          ),
          const SizedBox(height: 11),
          const Text(
            '250 points to Silver Explorer',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.09),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: QuestScreen.gold,
                  size: 19,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Every discovery brings you closer to your next reward.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      height: 1.5,
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
// STREAK CARD
// ================================================================

class _StreakCard extends StatelessWidget {
  const _StreakCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: QuestScreen.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: QuestScreen.sandstone),
      ),
      child: Row(
        children: [
          Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              color: QuestScreen.gold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: QuestScreen.primary,
              size: 27,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '5 Day Explorer Streak',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: QuestScreen.textColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Keep exploring to maintain your streak!',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: QuestScreen.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '5 days',
            style: TextStyle(
              color: QuestScreen.primary,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// DAILY QUEST
// ================================================================

class _DailyQuestCard extends StatelessWidget {
  const _DailyQuestCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: QuestScreen.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: QuestScreen.sandstone,
        ),
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
                  color: QuestScreen.primary.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'DAILY CHALLENGE',
                  style: TextStyle(
                    color: QuestScreen.primary,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.stars_rounded,
                color: Color(0xFFB78725),
                size: 17,
              ),
              const SizedBox(width: 5),
              const Text(
                '+50 XP',
                style: TextStyle(
                  color: QuestScreen.primaryDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 57,
                height: 57,
                decoration: BoxDecoration(
                  color: QuestScreen.teal.withOpacity(0.11),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.search_rounded,
                  color: QuestScreen.teal,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Identify the Monument',
                      style: TextStyle(
                        color: QuestScreen.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Can you identify today's heritage site?",
                      style: TextStyle(
                        color: QuestScreen.secondaryText,
                        fontSize: 11,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Daily quest will be available soon!',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: QuestScreen.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Play Quest  →',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
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
// QUEST CATEGORY CARD
// ================================================================

class _QuestCategory extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _QuestCategory({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: QuestScreen.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title quests will be available soon!'),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: QuestScreen.sandstone,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.11),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 23,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: QuestScreen.textColor,
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
                  color: QuestScreen.secondaryText,
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
// EXPLORE AND EARN
// ================================================================

class _EarnSection extends StatelessWidget {
  const _EarnSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SectionTitle(
          icon: Icons.stars_rounded,
          title: 'Explore & Earn',
        ),
        SizedBox(height: 15),
        _EarnCard(
          icon: Icons.location_on_rounded,
          title: 'Discover a Heritage Site',
          points: '+20',
          color: QuestScreen.primary,
        ),
        SizedBox(height: 10),
        _EarnCard(
          icon: Icons.quiz_rounded,
          title: 'Complete a Culture Quiz',
          points: '+50',
          color: QuestScreen.teal,
        ),
        SizedBox(height: 10),
        _EarnCard(
          icon: Icons.view_in_ar_rounded,
          title: 'Explore a Virtual Tour',
          points: '+30',
          color: Color(0xFFB78725),
        ),
        SizedBox(height: 10),
        _EarnCard(
          icon: Icons.camera_alt_rounded,
          title: 'Scan a Heritage Site',
          points: '+40',
          color: QuestScreen.green,
        ),
      ],
    );
  }
}

class _EarnCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String points;
  final Color color;

  const _EarnCard({
    required this.icon,
    required this.title,
    required this.points,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: QuestScreen.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: QuestScreen.sandstone),
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: color.withOpacity(0.11),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: QuestScreen.textColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: QuestScreen.gold.withOpacity(0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              points,
              style: const TextStyle(
                color: QuestScreen.primaryDark,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// BADGES
// ================================================================

class _BadgesSection extends StatelessWidget {
  const _BadgesSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 137,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          _BadgeCard(
            icon: Icons.account_balance_rounded,
            title: 'Explorer',
            color: QuestScreen.primary,
          ),
          _BadgeCard(
            icon: Icons.theater_comedy_rounded,
            title: 'Culture Keeper',
            color: QuestScreen.teal,
          ),
          _BadgeCard(
            icon: Icons.auto_stories_rounded,
            title: 'Story Seeker',
            color: Color(0xFFB78725),
          ),
          _BadgeCard(
            icon: Icons.map_rounded,
            title: 'Trailblazer',
            color: QuestScreen.green,
          ),
          _BadgeCard(
            icon: Icons.shield_rounded,
            title: 'Guardian',
            color: QuestScreen.primaryDark,
          ),
        ],
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _BadgeCard({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: QuestScreen.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: QuestScreen.sandstone),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 51,
            height: 51,
            decoration: BoxDecoration(
              color: color.withOpacity(0.11),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: QuestScreen.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// HERITAGE PASSPORT
// ================================================================

class _PassportCard extends StatelessWidget {
  const _PassportCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            QuestScreen.forest,
            QuestScreen.forestLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: QuestScreen.forest.withOpacity(0.13),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 51,
                height: 51,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.11),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: QuestScreen.gold,
                  size: 27,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Heritage Passport',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Your journey through India's heritage",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.auto_awesome_rounded,
                color: QuestScreen.gold,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.09),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            child: const Row(
              children: [
                _PassportStat(number: '12', label: 'Sites'),
                _PassportStat(number: '4', label: 'States'),
                _PassportStat(number: '27', label: 'Quests'),
                _PassportStat(number: '8', label: 'Badges'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PassportStat extends StatelessWidget {
  final String number;
  final String label;

  const _PassportStat({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}