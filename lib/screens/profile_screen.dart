import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

  void _showComingSoon(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.auto_awesome_rounded,
              color: primary,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: const Text(
          'Log Out?',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out of Smriti Rakshak?',
          style: TextStyle(
            color: secondaryText,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: secondaryText,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Log Out'),
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
  elevation: 0,
  scrolledUnderElevation: 0,
  backgroundColor: background,
  foregroundColor: textColor,
  leading: IconButton(
    tooltip: 'Go back',
    onPressed: () => Navigator.maybePop(context),
    icon: const Icon(
      Icons.arrow_back_rounded,
      color: forest,
    ),
  ),
  titleSpacing: 0,
  title: const Text(
    'My Profile',
    style: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w900,
      letterSpacing: -0.5,
    ),
  ),
  actions: [
    IconButton(
      tooltip: 'Settings',
      onPressed: () => _showComingSoon(context, 'Settings'),
      style: IconButton.styleFrom(
        backgroundColor: surface,
        foregroundColor: forest,
      ),
      icon: const Icon(Icons.settings_outlined),
    ),
    const SizedBox(width: 18),
  ],
),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 1000;

            final horizontalPadding =
                constraints.maxWidth >= 1200
                    ? 40.0
                    : constraints.maxWidth >= 700
                        ? 28.0
                        : 16.0;

            return SingleChildScrollView(
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
                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: _profileHeader(context),
                            ),
                            const SizedBox(width: 26),
                            Expanded(
                              flex: 5,
                              child: _passportSection(),
                            ),
                          ],
                        )
                      else ...[
                        _profileHeader(context),
                        const SizedBox(height: 30),
                        _passportSection(),
                      ],
                      const SizedBox(height: 34),
                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _achievementsSection(context),
                            ),
                            const SizedBox(width: 28),
                            Expanded(
                              child: _activitySection(context),
                            ),
                          ],
                        )
                      else ...[
                        _achievementsSection(context),
                        const SizedBox(height: 32),
                        _activitySection(context),
                      ],
                      const SizedBox(height: 32),
                      _preferencesSection(context),
                      const SizedBox(height: 32),
                      _accountSection(context),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: OutlinedButton.icon(
                          onPressed: () => _showLogoutDialog(context),
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text(
                            'Log Out',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primary,
                            side: BorderSide(
                              color: primary.withValues(alpha: 0.5),
                            ),
                            backgroundColor: surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Divider(
                        color: sandstone,
                        thickness: 1,
                      ),
                      const SizedBox(height: 22),
                      const Center(
                        child: Text(
                          'SMRITI RAKSHAK',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.4,
                            color: forest,
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Center(
                        child: Text(
                          'Discover • Experience • Preserve',
                          style: TextStyle(
                            fontSize: 12,
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
  // PROFILE HEADER
  // ============================================================

  Widget _profileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            forest,
            forestLight,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.12),
            blurRadius: 26,
            offset: const Offset(0, 12),
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
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
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
                      'HERITAGE EXPLORER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.park_outlined,
                color: gold,
                size: 25,
              ),
            ],
          ),
          const SizedBox(height: 28),
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF3E6CE),
                    border: Border.all(
                      color: gold,
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 60,
                    color: forest,
                  ),
                ),
                Positioned(
                  right: -2,
                  bottom: 0,
                  child: Container(
                    width: 33,
                    height: 33,
                    decoration: BoxDecoration(
                      color: gold,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: forest,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      size: 15,
                      color: forest,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Explorer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.6,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Your journey through India’s heritage starts here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => _showComingSoon(context, 'Edit Profile'),
              icon: const Icon(
                Icons.edit_outlined,
                size: 17,
              ),
              label: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white.withValues(alpha: 0.06),
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.40),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERITAGE PASSPORT
  // ============================================================

  Widget _passportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'My Heritage Passport',
          subtitle: 'Your personal record of heritage discoveries.',
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 360;

            return Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.account_balance_rounded,
                    value: '12',
                    label: 'Sites',
                    color: primary,
                    compact: compact,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.document_scanner_rounded,
                    value: '08',
                    label: 'Scans',
                    color: forestLight,
                    compact: compact,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.emoji_events_rounded,
                    value: '05',
                    label: 'Badges',
                    color: const Color(0xFFB78725),
                    compact: compact,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: sandstone),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8E6C5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.local_fire_department_rounded,
                  color: primary,
                  size: 29,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '7 Day Discovery Streak',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Keep exploring to extend your streak!',
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.local_fire_department_rounded,
                color: primary,
                size: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ACHIEVEMENTS
  // ============================================================

  Widget _achievementsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: _SectionTitle(
                title: 'Achievements',
                subtitle: 'Milestones from your journey.',
              ),
            ),
            TextButton(
              onPressed: () => _showComingSoon(
                context,
                'All Achievements',
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 550 ? 3 : 2;
            final spacing = 12.0;
            final cardWidth =
                (constraints.maxWidth - spacing * (columns - 1)) /
                    columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                _BadgeCard(
                  width: cardWidth,
                  icon: Icons.explore_rounded,
                  title: 'Explorer',
                  subtitle: '5 Sites',
                  color: primary,
                ),
                _BadgeCard(
                  width: cardWidth,
                  icon: Icons.camera_alt_rounded,
                  title: 'Observer',
                  subtitle: '5 Scans',
                  color: forestLight,
                ),
                _BadgeCard(
                  width: cardWidth,
                  icon: Icons.menu_book_rounded,
                  title: 'Historian',
                  subtitle: 'Learn 10 Stories',
                  color: const Color(0xFFB78725),
                ),
                _BadgeCard(
                  width: cardWidth,
                  icon: Icons.map_rounded,
                  title: 'Traveller',
                  subtitle: '3 Trips',
                  color: const Color(0xFF587B5B),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // ACTIVITY
  // ============================================================

  Widget _activitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'My Activity',
          subtitle: 'Pick up where your heritage journey left off.',
        ),
        const SizedBox(height: 16),
        _ProfileMenuTile(
          icon: Icons.favorite_rounded,
          title: 'Saved Heritage',
          subtitle: 'Sites and stories you want to revisit',
          color: primary,
          onTap: () => _showComingSoon(context, 'Saved Heritage'),
        ),
        const SizedBox(height: 10),
        _ProfileMenuTile(
          icon: Icons.map_rounded,
          title: 'My Trips',
          subtitle: 'View your planned heritage journeys',
          color: forestLight,
          onTap: () => _showComingSoon(context, 'My Trips'),
        ),
        const SizedBox(height: 10),
        _ProfileMenuTile(
          icon: Icons.document_scanner_rounded,
          title: 'Scan History',
          subtitle: 'Revisit your previous discoveries',
          color: const Color(0xFFB78725),
          onTap: () => _showComingSoon(context, 'Scan History'),
        ),
      ],
    );
  }

  // ============================================================
  // PREFERENCES
  // ============================================================

  Widget _preferencesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Preferences',
          subtitle: 'Make Smriti Rakshak work for you.',
        ),
        const SizedBox(height: 16),
        _ProfileMenuTile(
          icon: Icons.language_rounded,
          title: 'Language',
          subtitle: 'English',
          color: forestLight,
          onTap: () => _showComingSoon(context, 'Language'),
        ),
        const SizedBox(height: 10),
        _ProfileMenuTile(
          icon: Icons.accessibility_new_rounded,
          title: 'Accessibility',
          subtitle: 'Voice, text and accessibility options',
          color: primary,
          onTap: () => _showComingSoon(context, 'Accessibility'),
        ),
        const SizedBox(height: 10),
        _ProfileMenuTile(
          icon: Icons.notifications_none_rounded,
          title: 'Notifications',
          subtitle: 'Manage alerts and heritage updates',
          color: const Color(0xFFB78725),
          onTap: () => _showComingSoon(context, 'Notifications'),
        ),
      ],
    );
  }

  // ============================================================
  // ACCOUNT
  // ============================================================

  Widget _accountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Account',
          subtitle: 'Your account and support options.',
        ),
        const SizedBox(height: 16),
        _ProfileMenuTile(
          icon: Icons.security_rounded,
          title: 'Privacy & Security',
          subtitle: 'Control your account and data',
          color: primary,
          onTap: () => _showComingSoon(context, 'Privacy & Security'),
        ),
        const SizedBox(height: 10),
        _ProfileMenuTile(
          icon: Icons.help_outline_rounded,
          title: 'Help & Support',
          subtitle: 'Get help with Smriti Rakshak',
          color: forestLight,
          onTap: () => _showComingSoon(context, 'Help & Support'),
        ),
      ],
    );
  }
}

// ================================================================
// SECTION TITLE
// ================================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionTitle({
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.4,
            color: ProfileScreen.textColor,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 13,
              color: ProfileScreen.secondaryText,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

// ================================================================
// PASSPORT STAT CARD
// ================================================================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final bool compact;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: compact ? 15 : 19,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ProfileScreen.sandstone),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: compact ? 22 : 26,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: ProfileScreen.textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ProfileScreen.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  static const Color surfaceColor = ProfileScreen.surface;
}

// ================================================================
// ACHIEVEMENT BADGE CARD
// ================================================================

class _BadgeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final double width;

  const _BadgeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 135),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ProfileScreen.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ProfileScreen.sandstone),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: ProfileScreen.textColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: ProfileScreen.secondaryText,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// PROFILE MENU TILE
// ================================================================

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ProfileScreen.surface,
      borderRadius: BorderRadius.circular(19),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(19),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: ProfileScreen.sandstone),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: ProfileScreen.textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ProfileScreen.secondaryText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: ProfileScreen.secondaryText,
                size: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }
}