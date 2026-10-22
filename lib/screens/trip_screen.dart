
import 'package:flutter/material.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
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
  static const Color teal = Color(0xFF367C78);

  final TextEditingController startController = TextEditingController();
  final TextEditingController destinationController =
      TextEditingController();

  DateTime? startDate;
  String? selectedBudget;
  String? selectedDays;
  String? selectedTravelPreference;

  final List<String> selectedInterests = [];

  final List<String> budgetOptions = [
    '₹1,000 – ₹5,000',
    '₹5,000 – ₹10,000',
    '₹10,000 – ₹20,000',
    '₹20,000 – ₹30,000',
    '₹30,000+',
  ];

  final List<String> daysOptions = [
    '1 Day',
    '2 Days',
    '3 Days',
    '4 Days',
    '5+ Days',
  ];

  final List<Map<String, dynamic>> exploreOptions = [
    {'title': 'Temples', 'icon': Icons.temple_hindu, 'color': primary},
    {'title': 'Forts', 'icon': Icons.castle, 'color': primaryDark},
    {
      'title': 'Monuments',
      'icon': Icons.account_balance,
      'color': gold,
    },
    {'title': 'Museums', 'icon': Icons.museum, 'color': teal},
    {
      'title': 'Art & Culture',
      'icon': Icons.palette,
      'color': Color(0xFF8B6A9E),
    },
    {
      'title': 'Archaeological Sites',
      'icon': Icons.architecture,
      'color': forestLight,
    },
    {
      'title': 'Heritage Villages',
      'icon': Icons.home_work,
      'color': Color(0xFFB7793F),
    },
    {
      'title': 'Heritage + Nature',
      'icon': Icons.landscape,
      'color': Color(0xFF60865C),
    },
  ];

  final List<Map<String, dynamic>> travelOptions = [
    {
      'title': 'Car / Taxi',
      'icon': Icons.directions_car,
      'color': primary,
    },
    {
      'title': 'Public Transport',
      'icon': Icons.directions_bus,
      'color': teal,
    },
    {
      'title': 'Walking',
      'icon': Icons.directions_walk,
      'color': forestLight,
    },
    {
      'title': 'Any',
      'icon': Icons.alt_route,
      'color': Color(0xFFB58A37),
    },
  ];

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _selectStartDate() async {
    final DateTime today = DateUtils.dateOnly(DateTime.now());

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? today,
      firstDate: today,
      lastDate: DateTime(today.year + 2),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primary,
              onPrimary: Colors.white,
              surface: surface,
              onSurface: textColor,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: surface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && mounted) {
      setState(() => startDate = pickedDate);
    }
  }

  // ============================================================
  // GENERATE TRIP
  // ============================================================

  void _generateTrip() {
    if (startController.text.trim().isEmpty ||
        destinationController.text.trim().isEmpty ||
        startDate == null ||
        selectedBudget == null ||
        selectedDays == null ||
        selectedTravelPreference == null ||
        selectedInterests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please complete all trip details first.',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: forest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
        contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        title: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: forest.withOpacity(0.09),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: forest,
                size: 26,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Trip Details Ready!',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 19,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Here is your heritage trip summary.',
                style: TextStyle(
                  fontSize: 13,
                  color: secondaryText,
                ),
              ),
              const SizedBox(height: 18),
              _SummaryRow(
                icon: Icons.trip_origin,
                label: 'Starting point',
                value: startController.text.trim(),
              ),
              _SummaryRow(
                icon: Icons.location_on_outlined,
                label: 'Destination',
                value: destinationController.text.trim(),
              ),
              _SummaryRow(
                icon: Icons.calendar_month_outlined,
                label: 'Start date',
                value:
                    '${startDate!.day}/${startDate!.month}/${startDate!.year}',
              ),
              _SummaryRow(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Budget',
                value: selectedBudget!,
              ),
              _SummaryRow(
                icon: Icons.timelapse,
                label: 'Duration',
                value: selectedDays!,
              ),
              _SummaryRow(
                icon: Icons.directions_car_outlined,
                label: 'Travel',
                value: selectedTravelPreference!,
              ),
              _SummaryRow(
                icon: Icons.explore_outlined,
                label: 'Interests',
                value: selectedInterests.join(', '),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: gold.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: primary,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your trip details are collected. Connect your AI trip-planning feature here to generate a complete itinerary.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: ElevatedButton.styleFrom(
                backgroundColor: forest,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Got it',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    startController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  // ============================================================
  // MAIN SCREEN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: forest,
            size: 19,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan Your Journey',
              style: TextStyle(
                color: forest,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Create your perfect heritage trip',
              style: TextStyle(
                color: secondaryText,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= 900;
          final double contentWidth =
              isWide ? 1000 : constraints.maxWidth;

          return Stack(
            children: [
              Positioned(
                top: -70,
                right: -60,
                child: _BackgroundCircle(
                  size: 190,
                  color: primary.withOpacity(0.055),
                ),
              ),
              Positioned(
                top: 400,
                left: -80,
                child: _BackgroundCircle(
                  size: 180,
                  color: gold.withOpacity(0.09),
                ),
              ),
              SafeArea(
                child: Center(
                  child: SizedBox(
                    width: contentWidth,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 32 : 18,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildIntroCard(isWide),
                          const SizedBox(height: 28),
                          if (isWide)
                            _buildWideLocationDateSection()
                          else
                            _buildMobileLocationDateSection(),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildBudgetSection()),
                              SizedBox(width: isWide ? 20 : 12),
                              Expanded(child: _buildDurationSection()),
                            ],
                          ),
                          const SizedBox(height: 32),
                          _buildExploreSection(),
                          const SizedBox(height: 32),
                          _buildTravelSection(),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: ElevatedButton(
                              onPressed: _generateTrip,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: forest,
                                foregroundColor: Colors.white,
                                elevation: 4,
                                shadowColor: forest.withOpacity(0.20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.auto_awesome_rounded,
                                    size: 21,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Generate My Trip',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 19,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.park_outlined,
                                  size: 15,
                                  color: forestLight,
                                ),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    'AI-powered heritage trip planning',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // INTRO CARD
  // ============================================================

  Widget _buildIntroCard(bool isWide) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 30 : 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [forest, forestLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: gold.withOpacity(0.40),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: forest.withOpacity(0.14),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isWide ? 72 : 58,
            height: isWide ? 72 : 58,
            decoration: BoxDecoration(
              color: gold.withOpacity(0.17),
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: gold.withOpacity(0.45),
              ),
            ),
            child: Icon(
              Icons.map_rounded,
              color: gold,
              size: isWide ? 36 : 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Build Your Heritage Trip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isWide ? 22 : 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Discover historic places, plan your route, and create a journey worth remembering.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.82),
                    fontSize: isWide ? 13 : 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          if (isWide) ...[
            const SizedBox(width: 20),
            Icon(
              Icons.explore_rounded,
              size: 58,
              color: gold.withOpacity(0.75),
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // LOCATION AND DATE
  // ============================================================

  Widget _buildMobileLocationDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          title: 'Starting Point',
          icon: Icons.trip_origin,
        ),
        const SizedBox(height: 10),
        _InputCard(
          controller: startController,
          hint: 'Where are you starting from?',
          icon: Icons.location_on_outlined,
          color: primary,
        ),
        const SizedBox(height: 20),
        const _SectionLabel(
          title: 'Destination',
          icon: Icons.place_outlined,
        ),
        const SizedBox(height: 10),
        _InputCard(
          controller: destinationController,
          hint: 'Where do you want to go?',
          icon: Icons.location_searching_rounded,
          color: forestLight,
        ),
        const SizedBox(height: 20),
        _buildDateSection(),
      ],
    );
  }

  Widget _buildWideLocationDateSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionLabel(
                title: 'Starting Point',
                icon: Icons.trip_origin,
              ),
              const SizedBox(height: 10),
              _InputCard(
                controller: startController,
                hint: 'Starting location',
                icon: Icons.location_on_outlined,
                color: primary,
              ),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionLabel(
                title: 'Destination',
                icon: Icons.place_outlined,
              ),
              const SizedBox(height: 10),
              _InputCard(
                controller: destinationController,
                hint: 'Destination location',
                icon: Icons.location_searching_rounded,
                color: forestLight,
              ),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(child: _buildDateSection()),
      ],
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          title: 'Start Date',
          icon: Icons.calendar_month_outlined,
        ),
        const SizedBox(height: 10),
        Material(
          color: surface,
          borderRadius: BorderRadius.circular(17),
          child: InkWell(
            borderRadius: BorderRadius.circular(17),
            onTap: _selectStartDate,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                border: Border.all(
                  color: startDate == null
                      ? sandstone
                      : forestLight.withOpacity(0.55),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: gold.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: forest,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      startDate == null
                          ? 'Choose a date'
                          : '${startDate!.day.toString().padLeft(2, '0')}/'
                              '${startDate!.month.toString().padLeft(2, '0')}/'
                              '${startDate!.year}',
                      style: TextStyle(
                        color: startDate == null
                            ? secondaryText
                            : textColor,
                        fontSize: 12,
                        fontWeight: startDate == null
                            ? FontWeight.w500
                            : FontWeight.w700,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 21,
                    color: forest,
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
  // BUDGET AND DURATION
  // ============================================================

  Widget _buildBudgetSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          title: 'Budget',
          icon: Icons.account_balance_wallet_outlined,
        ),
        const SizedBox(height: 10),
        _DropdownCard(
          value: selectedBudget,
          hint: 'Select budget',
          icon: Icons.currency_rupee_rounded,
          color: gold,
          items: budgetOptions,
          onChanged: (value) => setState(() => selectedBudget = value),
        ),
      ],
    );
  }

  Widget _buildDurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          title: 'Duration',
          icon: Icons.timelapse_rounded,
        ),
        const SizedBox(height: 10),
        _DropdownCard(
          value: selectedDays,
          hint: 'Select days',
          icon: Icons.date_range_outlined,
          color: teal,
          items: daysOptions,
          onChanged: (value) => setState(() => selectedDays = value),
        ),
      ],
    );
  }

  // ============================================================
  // EXPLORE INTERESTS
  // ============================================================

  Widget _buildExploreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          title: 'What would you like to explore?',
          icon: Icons.explore_outlined,
        ),
        const SizedBox(height: 7),
        const Text(
          'Choose all the experiences you are interested in.',
          style: TextStyle(
            fontSize: 12,
            color: secondaryText,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final int columns = constraints.maxWidth >= 800
                ? 4
                : constraints.maxWidth >= 500
                    ? 3
                    : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exploreOptions.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 78,
              ),
              itemBuilder: (context, index) {
                final item = exploreOptions[index];
                final String title = item['title'] as String;
                final IconData icon = item['icon'] as IconData;
                final Color color = item['color'] as Color;
                final bool selected = selectedInterests.contains(title);

                return _InterestTile(
                  title: title,
                  icon: icon,
                  color: color,
                  selected: selected,
                  onTap: () {
                    setState(() {
                      if (selected) {
                        selectedInterests.remove(title);
                      } else {
                        selectedInterests.add(title);
                      }
                    });
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // TRAVEL PREFERENCE
  // ============================================================

  Widget _buildTravelSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          title: 'Travel Preference',
          icon: Icons.directions_car_outlined,
        ),
        const SizedBox(height: 7),
        const Text(
          'How would you prefer to travel?',
          style: TextStyle(
            fontSize: 12,
            color: secondaryText,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final int columns = constraints.maxWidth >= 500 ? 4 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: travelOptions.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 78,
              ),
              itemBuilder: (context, index) {
                final item = travelOptions[index];
                final String title = item['title'] as String;
                final IconData icon = item['icon'] as IconData;
                final Color color = item['color'] as Color;

                return _TravelTile(
                  title: title,
                  icon: icon,
                  color: color,
                  selected: selectedTravelPreference == title,
                  onTap: () {
                    setState(() => selectedTravelPreference = title);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

// ================================================================
// BACKGROUND DECORATION
// ================================================================

class _BackgroundCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BackgroundCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

// ================================================================
// SECTION LABEL
// ================================================================

class _SectionLabel extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionLabel({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: _TripScreenState.gold.withOpacity(0.20),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            icon,
            size: 17,
            color: _TripScreenState.forest,
          ),
        ),
        const SizedBox(width: 9),
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: _TripScreenState.textColor,
            ),
          ),
        ),
      ],
    );
  }
}

// ================================================================
// LOCATION INPUT
// ================================================================

class _InputCard extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final Color color;

  const _InputCard({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _TripScreenState.surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: _TripScreenState.sandstone,
        ),
        boxShadow: [
          BoxShadow(
            color: _TripScreenState.forest.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 13,
          color: _TripScreenState.textColor,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 12,
            color: _TripScreenState.secondaryText,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 17,
          ),
        ),
      ),
    );
  }
}

// ================================================================
// DROPDOWN CARD
// ================================================================

class _DropdownCard extends StatelessWidget {
  final String? value;
  final String hint;
  final IconData icon;
  final Color color;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownCard({
    required this.value,
    required this.hint,
    required this.icon,
    required this.color,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _TripScreenState.surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: _TripScreenState.sandstone,
        ),
        boxShadow: [
          BoxShadow(
            color: _TripScreenState.forest.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),
          dropdownColor: _TripScreenState.surface,
          hint: Row(
            children: [
              Icon(icon, color: color, size: 19),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(
                    color: _TripScreenState.secondaryText,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: _TripScreenState.forest,
          ),
          style: const TextStyle(
            color: _TripScreenState.textColor,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ================================================================
// INTEREST TILE
// ================================================================

class _InterestTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _InterestTile({
    required this.title,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _TripScreenState.surface,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: selected ? color : _TripScreenState.sandstone,
              width: selected ? 1.6 : 1,
            ),
            color: selected
                ? color.withOpacity(0.09)
                : _TripScreenState.surface,
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _TripScreenState.textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selected) ...[
                const SizedBox(width: 3),
                Icon(
                  Icons.check_circle_rounded,
                  color: color,
                  size: 16,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// TRAVEL TILE
// ================================================================

class _TravelTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _TravelTile({
    required this.title,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _TripScreenState.surface,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: selected ? color : _TripScreenState.sandstone,
              width: selected ? 1.6 : 1,
            ),
            color: selected
                ? color.withOpacity(0.09)
                : _TripScreenState.surface,
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _TripScreenState.textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selected) ...[
                const SizedBox(width: 3),
                Icon(
                  Icons.check_circle_rounded,
                  color: color,
                  size: 16,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// TRIP SUMMARY ROW
// ================================================================

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: _TripScreenState.forest.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: _TripScreenState.forest,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: _TripScreenState.secondaryText,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _TripScreenState.textColor,
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
