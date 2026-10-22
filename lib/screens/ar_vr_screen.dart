
import 'package:flutter/material.dart';

class ArVrScreen extends StatelessWidget {
  const ArVrScreen({super.key});

  // ============================================================
  // SMRITI RAKSHAK - PREMIUM HERITAGE THEME
  // ============================================================

  static const Color primary = Color(0xFFC94F36);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE8B957);
  static const Color forest = Color(0xFF263D32);
  static const Color forestLight = Color(0xFF385745);
  static const Color sandstone = Color(0xFFE9DDC8);
  static const Color cream = Color(0xFFFAF6ED);
  static const Color ink = Color(0xFF292C25);
  static const Color muted = Color(0xFF73776D);
  static const Color white = Colors.white;

  // ============================================================
  // SAFE BACK NAVIGATION
  // ============================================================

  static void _goBack(BuildContext context) {
    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      navigator.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are already on the first page.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ============================================================
  // COMING SOON DIALOG
  // ============================================================

  static void _showComingSoon(BuildContext context, String feature) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: cream,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  color: gold.withOpacity(0.22),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: gold.withOpacity(0.65),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: forest,
                  size: 37,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                feature,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: forest,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Something extraordinary is on its way! '
                'We are preparing an immersive journey into '
                'India’s incredible heritage.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: muted,
                  fontSize: 13,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: forest,
                    foregroundColor: cream,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Sounds exciting!',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
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

  // ============================================================
  // MAIN SCREEN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: forest,
        foregroundColor: cream,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 72,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            tooltip: 'Go back',
            onPressed: () => _goBack(context),
            icon: const Icon(Icons.arrow_back_rounded),
            style: IconButton.styleFrom(
              backgroundColor: white.withOpacity(0.08),
              foregroundColor: cream,
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SMRITI RAKSHAK',
              style: TextStyle(
                color: cream,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.8,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'AR / VR EXPERIENCES',
              style: TextStyle(
                color: gold,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.7,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: gold.withOpacity(0.13),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: gold.withOpacity(0.3)),
            ),
            child: const Icon(
              Icons.view_in_ar_rounded,
              color: gold,
              size: 23,
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final desktop = constraints.maxWidth >= 900;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HERO
                  _ArVrHero(
                    desktop: desktop,
                    onTap: () => _showComingSoon(
                      context,
                      'AR Heritage Lens',
                    ),
                  ),

                  // MAIN CONTENT
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      desktop ? 56 : 22,
                      desktop ? 60 : 42,
                      desktop ? 56 : 22,
                      60,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _ArVrSectionTitle(
                          eyebrow: 'DISCOVER A NEW DIMENSION',
                          title: 'History, but make it immersive.',
                          description:
                              'Walk through ancient kingdoms, uncover '
                              'forgotten stories and see India’s heritage '
                              'from an entirely new perspective.',
                        ),

                        const SizedBox(height: 30),

                        // EXPERIENCE CARDS
                        LayoutBuilder(
                          builder: (context, gridConstraints) {
                            final columns =
                                gridConstraints.maxWidth >= 1200
                                    ? 4
                                    : gridConstraints.maxWidth >= 650
                                        ? 2
                                        : 1;

                            const spacing = 20.0;

                            final cardWidth =
                                (gridConstraints.maxWidth -
                                        (columns - 1) * spacing) /
                                    columns;

                            final experiences = [
                              _ArVrFeature(
                                number: '01',
                                title: 'AR Heritage Lens',
                                description:
                                    'Bring historical stories to life '
                                    'with augmented reality.',
                                image: 'assets/images/ShaniwarWada.jpg',
                                icon: Icons.camera_alt_rounded,
                                tag: 'AUGMENTED REALITY',
                                onTap: () => _showComingSoon(
                                  context,
                                  'AR Heritage Lens',
                                ),
                              ),
                              _ArVrFeature(
                                number: '02',
                                title: 'Virtual Tours',
                                description:
                                    'Explore extraordinary monuments '
                                    'from anywhere in the world.',
                                image: 'assets/images/AgaKhanPalace.jpg',
                                icon: Icons.vrpano_rounded,
                                tag: 'VIRTUAL REALITY',
                                onTap: () => _showComingSoon(
                                  context,
                                  'Virtual Tours',
                                ),
                              ),
                              _ArVrFeature(
                                number: '03',
                                title: '3D Heritage',
                                description:
                                    'Discover monuments and artifacts '
                                    'from every angle.',
                                image: 'assets/images/LostFort.jpg',
                                icon: Icons.view_in_ar_rounded,
                                tag: '3D EXPLORATION',
                                onTap: () => _showComingSoon(
                                  context,
                                  '3D Heritage Models',
                                ),
                              ),
                              _ArVrFeature(
                                number: '04',
                                title: 'Time Travel',
                                description:
                                    'Imagine ancient places in their '
                                    'original historical glory.',
                                image: 'assets/images/SinhagadFort.jpg',
                                icon: Icons.history_edu_rounded,
                                tag: 'HISTORICAL STORIES',
                                onTap: () => _showComingSoon(
                                  context,
                                  'Historical Reconstructions',
                                ),
                              ),
                            ];

                            return Wrap(
                              spacing: spacing,
                              runSpacing: 20,
                              children: experiences.map((experience) {
                                return SizedBox(
                                  width: cardWidth,
                                  child: experience,
                                );
                              }).toList(),
                            );
                          },
                        ),

                        const SizedBox(height: 70),

                        // DESTINATIONS
                        const _ArVrSectionTitle(
                          eyebrow: 'THE WORLD IS YOUR TIME MACHINE',
                          title: 'Journeys worth taking.',
                          description:
                              'From ancient cave paintings to magnificent '
                              'temples, discover the stories hidden within '
                              'India’s extraordinary landmarks.',
                        ),

                        const SizedBox(height: 28),

                        SizedBox(
                          height: 335,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _ArVrDestination(
                                title: 'Hampi',
                                subtitle: 'Walk through a lost kingdom',
                                image: 'assets/images/Hampi.jpg',
                                tag: 'KARNATAKA',
                                onTap: () => _showComingSoon(
                                  context,
                                  'Hampi VR Experience',
                                ),
                              ),
                              _ArVrDestination(
                                title: 'Ajanta Caves',
                                subtitle: 'Discover ancient cave art',
                                image: 'assets/images/Ajanta.jpg',
                                tag: 'MAHARASHTRA',
                                onTap: () => _showComingSoon(
                                  context,
                                  'Ajanta Caves Experience',
                                ),
                              ),
                              _ArVrDestination(
                                title: 'Konark',
                                subtitle: 'Explore the Sun Temple',
                                image: 'assets/images/Konark.jpg',
                                tag: 'ODISHA',
                                onTap: () => _showComingSoon(
                                  context,
                                  'Konark Experience',
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 75),

                        // HOW IT WORKS
                        const _ArVrSectionTitle(
                          eyebrow: 'YOUR ADVENTURE, SIMPLIFIED',
                          title: 'Three steps. A whole new world.',
                          description:
                              'Getting closer to history has never '
                              'felt this exciting.',
                        ),

                        const SizedBox(height: 30),

                        LayoutBuilder(
                          builder: (context, stepConstraints) {
                            final horizontal =
                                stepConstraints.maxWidth >= 760;

                            final steps = [
                              const _ArVrStep(
                                number: '01',
                                icon: Icons.explore_rounded,
                                title: 'Choose your destination',
                                description:
                                    'Pick a monument, artifact or '
                                    'historical landmark.',
                              ),
                              const _ArVrStep(
                                number: '02',
                                icon: Icons.view_in_ar_rounded,
                                title: 'Pick your experience',
                                description:
                                    'Choose AR, virtual tours or '
                                    'interactive 3D exploration.',
                              ),
                              const _ArVrStep(
                                number: '03',
                                icon: Icons.auto_stories_rounded,
                                title: 'Live the story',
                                description:
                                    'Uncover history, culture and '
                                    'the stories behind each place.',
                              ),
                            ];

                            if (horizontal) {
                              return Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: steps.map((step) {
                                  return Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 12,
                                      ),
                                      child: step,
                                    ),
                                  );
                                }).toList(),
                              );
                            }

                            return Column(
                              children: steps,
                            );
                          },
                        ),

                        const SizedBox(height: 55),

                        // HERITAGE PASSPORT
                        _HeritagePassport(
                          onTap: () => _showComingSoon(
                            context,
                            'Heritage Passport',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const _ArVrFooter(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// CINEMATIC HERO
// ============================================================

class _ArVrHero extends StatelessWidget {
  final bool desktop;
  final VoidCallback onTap;

  const _ArVrHero({
    required this.desktop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        desktop ? 30 : 14,
        desktop ? 24 : 14,
        desktop ? 30 : 14,
        0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          height: desktop ? 500 : 490,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/LostFort.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: ArVrScreen.forestLight,
                  child: const Icon(
                    Icons.account_balance_rounded,
                    size: 120,
                    color: Colors.white24,
                  ),
                ),
              ),

              // DARK CINEMATIC OVERLAY
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      ArVrScreen.forest.withOpacity(0.98),
                      ArVrScreen.forest.withOpacity(0.88),
                      ArVrScreen.forest.withOpacity(0.52),
                      ArVrScreen.forest.withOpacity(0.12),
                    ],
                    stops: const [0, 0.43, 0.72, 1],
                  ),
                ),
              ),

              // BOTTOM GRADIENT
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      ArVrScreen.forest.withOpacity(0.45),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(desktop ? 55 : 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 570),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ArVrScreen.gold,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.auto_awesome_rounded,
                                size: 14,
                                color: ArVrScreen.forest,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'HISTORY, REIMAGINED',
                                style: TextStyle(
                                  color: ArVrScreen.forest,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 27),

                        Text(
                          'Step inside\nthe past.',
                          style: TextStyle(
                            color: ArVrScreen.cream,
                            fontSize: desktop ? 66 : 49,
                            height: 1.04,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          width: 65,
                          height: 4,
                          decoration: BoxDecoration(
                            color: ArVrScreen.gold,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Some stories deserve more than a page. '
                          'Experience India’s living legacy through '
                          'immersive AR, virtual tours and 3D worlds.',
                          style: TextStyle(
                            color: ArVrScreen.cream.withOpacity(0.88),
                            fontSize: desktop ? 15 : 13,
                            height: 1.8,
                          ),
                        ),

                        const SizedBox(height: 28),

                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            FilledButton.icon(
                              onPressed: onTap,
                              style: FilledButton.styleFrom(
                                backgroundColor: ArVrScreen.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              icon: const Icon(
                                Icons.play_circle_fill_rounded,
                                size: 21,
                              ),
                              label: const Text(
                                'Start Exploring',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                Scrollable.ensureVisible(
                                  context,
                                  duration:
                                      const Duration(milliseconds: 450),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: ArVrScreen.cream,
                                side: BorderSide(
                                  color: ArVrScreen.cream.withOpacity(0.5),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              icon: const Icon(
                                Icons.explore_outlined,
                                size: 19,
                              ),
                              label: const Text('Discover'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 23),

                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: ArVrScreen.gold,
                              size: 17,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'India’s heritage, closer than ever',
                                style: TextStyle(
                                  color: ArVrScreen.cream.withOpacity(0.75),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
                  right: 25,
                  bottom: 25,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: ArVrScreen.forest.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: ArVrScreen.gold.withOpacity(0.65),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          color: ArVrScreen.gold,
                          size: 19,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'DISCOVER. EXPERIENCE. PRESERVE.',
                          style: TextStyle(
                            color: ArVrScreen.cream,
                            fontSize: 9,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w800,
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
// SECTION HEADING
// ============================================================

class _ArVrSectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String description;

  const _ArVrSectionTitle({
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: ArVrScreen.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                eyebrow,
                style: const TextStyle(
                  color: ArVrScreen.primaryDark,
                  fontSize: 10,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          title,
          style: TextStyle(
            color: ArVrScreen.ink,
            fontSize: MediaQuery.sizeOf(context).width >= 650 ? 37 : 29,
            height: 1.16,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 13),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 610),
          child: Text(
            description,
            style: const TextStyle(
              color: ArVrScreen.muted,
              fontSize: 13,
              height: 1.9,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// EXPERIENCE CARDS
// ============================================================

class _ArVrFeature extends StatefulWidget {
  final String number;
  final String title;
  final String description;
  final String image;
  final IconData icon;
  final String tag;
  final VoidCallback onTap;

  const _ArVrFeature({
    required this.number,
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
    required this.tag,
    required this.onTap,
  });

  @override
  State<_ArVrFeature> createState() => _ArVrFeatureState();
}

class _ArVrFeatureState extends State<_ArVrFeature> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        transform: Matrix4.translationValues(0, hovered ? -7 : 0, 0),
        decoration: BoxDecoration(
          color: ArVrScreen.forest,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: ArVrScreen.forest.withOpacity(hovered ? 0.20 : 0.08),
              blurRadius: hovered ? 26 : 14,
              offset: Offset(0, hovered ? 13 : 6),
            ),
          ],
          border: Border.all(
            color: hovered
                ? ArVrScreen.gold.withOpacity(0.8)
                : ArVrScreen.forestLight.withOpacity(0.4),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 205,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedScale(
                      scale: hovered ? 1.05 : 1,
                      duration: const Duration(milliseconds: 350),
                      child: Image.asset(
                        widget.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: ArVrScreen.forestLight,
                          child: Icon(
                            widget.icon,
                            size: 65,
                            color: ArVrScreen.cream.withOpacity(0.6),
                          ),
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
                            ArVrScreen.forest.withOpacity(0.75),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: ArVrScreen.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.number,
                          style: const TextStyle(
                            color: ArVrScreen.forest,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      bottom: 15,
                      child: Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: ArVrScreen.forest.withOpacity(0.93),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: ArVrScreen.gold.withOpacity(0.5),
                          ),
                        ),
                        child: Icon(
                          widget.icon,
                          color: ArVrScreen.gold,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 21, 20, 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tag,
                      style: const TextStyle(
                        color: ArVrScreen.gold,
                        fontSize: 9,
                        letterSpacing: 1.35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 11),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: ArVrScreen.cream,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: ArVrScreen.cream.withOpacity(0.73),
                        fontSize: 12,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: widget.onTap,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ArVrScreen.gold,
                          side: BorderSide(
                            color: ArVrScreen.gold.withOpacity(0.45),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Explore experience',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: 9),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
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
      ),
    );
  }
}

// ============================================================
// DESTINATION CARDS
// ============================================================

class _ArVrDestination extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final String tag;
  final VoidCallback onTap;

  const _ArVrDestination({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.tag,
    required this.onTap,
  });

  @override
  State<_ArVrDestination> createState() => _ArVrDestinationState();
}

class _ArVrDestinationState extends State<_ArVrDestination> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 230),
        transform: Matrix4.translationValues(0, hovered ? -6 : 0, 0),
        width: 285,
        margin: const EdgeInsets.only(right: 18, bottom: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Material(
            color: ArVrScreen.forest,
            child: InkWell(
              onTap: widget.onTap,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedScale(
                    scale: hovered ? 1.045 : 1,
                    duration: const Duration(milliseconds: 350),
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: ArVrScreen.forestLight,
                        child: const Icon(
                          Icons.account_balance_rounded,
                          color: Colors.white54,
                          size: 70,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ArVrScreen.forest.withOpacity(0.40),
                          Colors.transparent,
                          ArVrScreen.forest.withOpacity(0.98),
                        ],
                        stops: const [0, 0.35, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 17,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: ArVrScreen.gold,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Text(
                        widget.tag,
                        style: const TextStyle(
                          color: ArVrScreen.forest,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 17,
                    top: 17,
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: ArVrScreen.forest.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_outward_rounded,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 29,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 17),
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.22),
                        ),
                        const SizedBox(height: 15),
                        const Row(
                          children: [
                            Flexible(
                              child: Text(
                                'EXPLORE DESTINATION',
                                style: TextStyle(
                                  color: ArVrScreen.gold,
                                  fontSize: 9,
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            SizedBox(width: 9),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: ArVrScreen.gold,
                              size: 17,
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
      ),
    );
  }
}

// ============================================================
// HOW IT WORKS
// ============================================================

class _ArVrStep extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String description;

  const _ArVrStep({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: ArVrScreen.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: ArVrScreen.sandstone.withOpacity(0.9),
        ),
        boxShadow: [
          BoxShadow(
            color: ArVrScreen.forest.withOpacity(0.045),
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
                width: 53,
                height: 53,
                decoration: BoxDecoration(
                  color: ArVrScreen.forest,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(
                  icon,
                  color: ArVrScreen.gold,
                  size: 26,
                ),
              ),
              const Spacer(),
              Text(
                number,
                style: TextStyle(
                  color: ArVrScreen.primary.withOpacity(0.22),
                  fontSize: 33,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 21),
          Text(
            'STEP $number',
            style: const TextStyle(
              color: ArVrScreen.primaryDark,
              fontSize: 9,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            title,
            style: const TextStyle(
              color: ArVrScreen.ink,
              fontSize: 17,
              height: 1.35,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: ArVrScreen.muted,
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HERITAGE PASSPORT BANNER
// ============================================================

class _HeritagePassport extends StatelessWidget {
  final VoidCallback onTap;

  const _HeritagePassport({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ArVrScreen.forest,
                ArVrScreen.forestLight,
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: ArVrScreen.gold.withOpacity(0.4),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                top: -45,
                child: Icon(
                  Icons.account_balance_rounded,
                  size: 210,
                  color: Colors.white.withOpacity(0.035),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 500;

                    final content = Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                            color: ArVrScreen.gold.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(
                              color: ArVrScreen.gold.withOpacity(0.45),
                            ),
                          ),
                          child: const Icon(
                            Icons.workspace_premium_rounded,
                            color: ArVrScreen.gold,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 17),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your story. Your heritage.',
                                style: TextStyle(
                                  color: ArVrScreen.gold,
                                  fontSize: 10,
                                  letterSpacing: 1.4,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Collect Heritage Moments',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  height: 1.25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Build your Heritage Passport and '
                                'celebrate every journey through history.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  height: 1.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!compact) ...[
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: ArVrScreen.gold,
                            size: 25,
                          ),
                        ],
                      ],
                    );

                    if (!compact) {
                      return content;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        content,
                        const SizedBox(height: 23),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: ArVrScreen.primary,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'DISCOVER YOUR PASSPORT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  letterSpacing: 0.9,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(width: 9),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 17,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
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
// FOOTER
// ============================================================

class _ArVrFooter extends StatelessWidget {
  const _ArVrFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ArVrScreen.forest,
      padding: const EdgeInsets.fromLTRB(24, 42, 24, 30),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ArVrScreen.gold.withOpacity(0.12),
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: ArVrScreen.gold.withOpacity(0.35),
              ),
            ),
            child: const Icon(
              Icons.account_balance_rounded,
              color: ArVrScreen.gold,
              size: 31,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'SMRITI RAKSHAK',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ArVrScreen.cream,
              fontSize: 16,
              letterSpacing: 2.6,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            'Discover  •  Experience  •  Preserve',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ArVrScreen.cream.withOpacity(0.65),
              fontSize: 11,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 55,
            height: 2,
            color: ArVrScreen.gold.withOpacity(0.65),
          ),
          const SizedBox(height: 20),
          const Text(
            'Preserving yesterday. Inspiring tomorrow.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ArVrScreen.gold,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'A journey through India’s timeless heritage.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ArVrScreen.cream.withOpacity(0.5),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
