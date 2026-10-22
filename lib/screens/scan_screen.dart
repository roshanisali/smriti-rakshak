import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

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

  // ============================================================
  // COMING SOON DIALOG
  // ============================================================

  void _showComingSoon(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                  fontWeight: FontWeight.w900,
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
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Heritage Scanner',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Discover the stories behind history',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: secondaryText,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: sandstone),
              ),
              child: const Icon(
                Icons.document_scanner_rounded,
                color: primary,
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

            final padding = constraints.maxWidth >= 1200
                ? 42.0
                : constraints.maxWidth >= 700
                    ? 28.0
                    : 16.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                padding,
                18,
                padding,
                36,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIntro(isWide),
                      const SizedBox(height: 26),

                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: _ScannerHero(
                                onScan: () => _showComingSoon(
                                  context,
                                  'Heritage Scanner',
                                ),
                              ),
                            ),
                            const SizedBox(width: 28),
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  _buildScanTypes(
                                    context,
                                    isWide: true,
                                  ),
                                  const SizedBox(height: 24),
                                  _buildPassportCard(),
                                ],
                              ),
                            ),
                          ],
                        )
                      else ...[
                        _ScannerHero(
                          onScan: () => _showComingSoon(
                            context,
                            'Heritage Scanner',
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildScanTypes(
                          context,
                          isWide: false,
                        ),
                        const SizedBox(height: 30),
                        _buildAiFeatures(),
                        const SizedBox(height: 30),
                        _buildRecentScans(context),
                        const SizedBox(height: 26),
                        _buildPassportCard(),
                      ],

                      if (isWide) ...[
                        const SizedBox(height: 36),
                        _buildAiFeatures(),
                        const SizedBox(height: 36),
                        _buildRecentScans(context),
                        const SizedBox(height: 30),
                      ],

                      const SizedBox(height: 26),
                      const Center(
                        child: Text(
                          'SMRITI RAKSHAK',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: forest,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
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

  Widget _buildIntro(bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF0E5D0),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history_edu_rounded,
                size: 15,
                color: primaryDark,
              ),
              SizedBox(width: 7),
              Text(
                'YOUR WINDOW INTO THE PAST',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  color: primaryDark,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Scan. Discover.\nRemember.',
          style: TextStyle(
            fontSize: isWide ? 38 : 32,
            height: 1.12,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
            color: textColor,
          ),
        ),
        const SizedBox(height: 12),
        const SizedBox(
          width: 590,
          child: Text(
            'Point your camera at a heritage object or site and uncover '
            'the stories, people and history behind it.',
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: secondaryText,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SCAN TYPES
  // ============================================================

  Widget _buildScanTypes(
    BuildContext context, {
    required bool isWide,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          icon: Icons.category_rounded,
          title: 'What can you scan?',
          subtitle: 'Choose your next heritage discovery.',
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            const columns = 2;

            final ratio = constraints.maxWidth < 330
                ? 0.95
                : isWide
                    ? 1.20
                    : 1.30;

            return GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: ratio,
              children: [
                _ScanTypeCard(
                  icon: Icons.account_balance_rounded,
                  title: 'Monuments',
                  description: 'Identify heritage sites',
                  color: primary,
                  onTap: () => _showComingSoon(
                    context,
                    'Monument Scanner',
                  ),
                ),
                _ScanTypeCard(
                  icon: Icons.museum_rounded,
                  title: 'Artifacts',
                  description: 'Explore objects and art',
                  color: gold,
                  onTap: () => _showComingSoon(
                    context,
                    'Artifact Scanner',
                  ),
                ),
                _ScanTypeCard(
                  icon: Icons.menu_book_rounded,
                  title: 'Inscriptions',
                  description: 'Read ancient scripts',
                  color: forestLight,
                  onTap: () => _showComingSoon(
                    context,
                    'Inscription Scanner',
                  ),
                ),
                _ScanTypeCard(
                  icon: Icons.image_search_rounded,
                  title: 'Old Photos',
                  description: 'Discover their history',
                  color: const Color(0xFF8A7653),
                  onTap: () => _showComingSoon(
                    context,
                    'Photo Explorer',
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // AI FEATURES
  // ============================================================

  Widget _buildAiFeatures() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          icon: Icons.auto_awesome_rounded,
          title: 'What AI can uncover',
          subtitle: 'Every discovery has a story to tell.',
        ),
        SizedBox(height: 16),
        _FeatureTile(
          icon: Icons.auto_awesome_rounded,
          title: 'AI Identification',
          description:
              'Help identify monuments, artifacts and heritage elements.',
          color: primary,
        ),
        SizedBox(height: 11),
        _FeatureTile(
          icon: Icons.history_edu_rounded,
          title: 'Story & History',
          description:
              'Explore historical context, stories and cultural significance.',
          color: gold,
        ),
        SizedBox(height: 11),
        _FeatureTile(
          icon: Icons.verified_rounded,
          title: 'Authenticity Check',
          description:
              'Flag potentially misleading claims for further verification.',
          color: forestLight,
        ),
        SizedBox(height: 11),
        _FeatureTile(
          icon: Icons.translate_rounded,
          title: 'Language & Inscriptions',
          description:
              'Understand inscriptions and heritage information in your language.',
          color: Color(0xFF8A7653),
        ),
      ],
    );
  }

  // ============================================================
  // RECENT SCANS
  // ============================================================

  Widget _buildRecentScans(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: _SectionTitle(
                icon: Icons.history_rounded,
                title: 'Recent Scans',
              ),
            ),
            TextButton(
              onPressed: () => _showComingSoon(
                context,
                'Scan History',
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 30,
          ),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: sandstone),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.qr_code_scanner_rounded,
                size: 46,
                color: Color(0xFFB3A995),
              ),
              SizedBox(height: 13),
              Text(
                'No scans yet',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Your scanned heritage discoveries will appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.6,
                  color: secondaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HERITAGE PASSPORT
  // ============================================================

  Widget _buildPassportCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            forest,
            Color(0xFF1D3528),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: gold.withOpacity(0.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: forest.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: gold.withOpacity(0.16),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: gold.withOpacity(0.35),
              ),
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              color: gold,
              size: 30,
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Build your Heritage Passport',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.35,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Every discovery becomes part of your journey.',
                  style: TextStyle(
                    color: Color(0xFFD8DFD5),
                    fontSize: 12,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward_rounded,
            color: gold,
            size: 22,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SCANNER HERO
// ============================================================

class _ScannerHero extends StatelessWidget {
  final VoidCallback? onScan;

  const _ScannerHero({this.onScan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 370),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ScanScreen.forest,
            ScanScreen.forestLight,
            Color(0xFF536C4A),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: ScanScreen.forest.withOpacity(0.16),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Positioned(
              top: -55,
              right: -35,
              child: _DecorativeCircle(
                size: 180,
                color: ScanScreen.gold.withOpacity(0.10),
              ),
            ),
            Positioned(
              bottom: -70,
              left: -45,
              child: _DecorativeCircle(
                size: 200,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
            Positioned(
              top: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.20),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: ScanScreen.gold,
                      size: 13,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'AI DISCOVERY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 22),
                  Container(
                    width: 190,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: ScanScreen.gold.withOpacity(0.65),
                        width: 1.5,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ScanScreen.gold.withOpacity(0.10),
                          ),
                        ),
                        const Icon(
                          Icons.account_balance_rounded,
                          size: 62,
                          color: Colors.white,
                        ),
                        const Positioned(
                          top: 8,
                          left: 8,
                          child: _ScannerCorner(),
                        ),
                        const Positioned(
                          top: 8,
                          right: 8,
                          child: _ScannerCorner(rotate: 1),
                        ),
                        const Positioned(
                          bottom: 8,
                          left: 8,
                          child: _ScannerCorner(rotate: 3),
                        ),
                        const Positioned(
                          bottom: 8,
                          right: 8,
                          child: _ScannerCorner(rotate: 2),
                        ),
                        Positioned(
                          left: 22,
                          right: 22,
                          top: 73,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: ScanScreen.gold,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: ScanScreen.gold.withOpacity(0.5),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 23),
                  const Text(
                    'Ready to explore?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Scan a monument, artifact or inscription',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.82),
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 23),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: onScan ??
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Heritage Scanner will be available soon.',
                                ),
                              ),
                            );
                          },
                      icon: const Icon(
                        Icons.document_scanner_rounded,
                        size: 20,
                      ),
                      label: const Text(
                        'Start Scanning',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ScanScreen.gold,
                        foregroundColor: ScanScreen.forest,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Text(
                    'Camera scanning is a planned feature',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      fontSize: 10,
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
// DECORATIVE CIRCLE
// ============================================================

class _DecorativeCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _DecorativeCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

// ============================================================
// SCANNER CORNERS
// ============================================================

class _ScannerCorner extends StatelessWidget {
  final int rotate;

  const _ScannerCorner({this.rotate = 0});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotate * 1.5708,
      child: const SizedBox(
        width: 25,
        height: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white,
                width: 3.5,
              ),
              left: BorderSide(
                color: Colors.white,
                width: 3.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION TITLE
// ============================================================

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const _SectionTitle({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 39,
          height: 39,
          decoration: BoxDecoration(
            color: ScanScreen.primary.withOpacity(0.09),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: ScanScreen.primary,
            size: 21,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.3,
                  fontWeight: FontWeight.w900,
                  color: ScanScreen.textColor,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: ScanScreen.secondaryText,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SCAN TYPE CARD
// ============================================================

class _ScanTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _ScanTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ScanScreen.surface,
      borderRadius: BorderRadius.circular(21),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(21),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            border: Border.all(
              color: ScanScreen.sandstone,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 25,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: ScanScreen.textColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.4,
                  color: ScanScreen.secondaryText,
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
// AI FEATURE TILE
// ============================================================

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: ScanScreen.surface,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: ScanScreen.sandstone,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: ScanScreen.textColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.6,
                    color: ScanScreen.secondaryText,
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