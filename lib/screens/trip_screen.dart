
import 'package:flutter/material.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  // ============================================================
  // SMRITI RAKSHAK — REFINED HERITAGE PALETTE
  // ============================================================

  static const Color primary = Color(0xFFE0533C);
  static const Color primaryDark = Color(0xFFA6321F);
  static const Color gold = Color(0xFFF2A922);
  static const Color background = Color(0xFFF7F5F0);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF172B26);
  static const Color secondaryText = Color(0xFF64736D);
  static const Color forest = Color(0xFF174C3B);
  static const Color forestLight = Color(0xFF28745A);
  static const Color sandstone = Color(0xFFE5E3D9);
  static const Color teal = Color(0xFF178A88);
  static const Color lavender = Color(0xFF8870B5);
  static const Color peach = Color(0xFFFFE8DD);

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

  late final List<Map<String, dynamic>> exploreOptions = [
    {'title': 'Temples', 'icon': Icons.temple_hindu_rounded, 'color': primary},
    {'title': 'Forts', 'icon': Icons.castle_rounded, 'color': forest},
    {
      'title': 'Monuments',
      'icon': Icons.account_balance_rounded,
      'color': Color(0xFFB77919),
    },
    {'title': 'Museums', 'icon': Icons.museum_rounded, 'color': teal},
    {
      'title': 'Art & Culture',
      'icon': Icons.palette_rounded,
      'color': lavender,
    },
    {
      'title': 'Archaeological Sites',
      'icon': Icons.architecture_rounded,
      'color': forestLight,
    },
    {
      'title': 'Heritage Villages',
      'icon': Icons.house_siding_rounded,
      'color': Color(0xFFB76C43),
    },
    {
      'title': 'Heritage + Nature',
      'icon': Icons.landscape_rounded,
      'color': Color(0xFF54865A),
    },
  ];

  late final List<Map<String, dynamic>> travelOptions = [
    {
      'title': 'Car / Taxi',
      'icon': Icons.directions_car_rounded,
      'color': primary,
    },
    {
      'title': 'Public Transport',
      'icon': Icons.directions_bus_rounded,
      'color': teal,
    },
    {
      'title': 'Walking',
      'icon': Icons.directions_walk_rounded,
      'color': forestLight,
    },
    {
      'title': 'Any',
      'icon': Icons.alt_route_rounded,
      'color': Color(0xFFB77919),
    },
  ];

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _selectStartDate() async {
    final today = DateUtils.dateOnly(DateTime.now());

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? today,
      firstDate: today,
      lastDate: DateTime(today.year + 2),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: forest,
              onPrimary: Colors.white,
              surface: surface,
              onSurface: textColor,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: surface,
              headerBackgroundColor: forest,
              headerForegroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              todayBorder: const BorderSide(color: primary),
              todayForegroundColor:
                  const WidgetStatePropertyAll(primary),
              dayForegroundColor:
                  const WidgetStatePropertyAll(textColor),
              yearForegroundColor:
                  const WidgetStatePropertyAll(textColor),
              cancelButtonStyle: TextButton.styleFrom(
                foregroundColor: secondaryText,
              ),
              confirmButtonStyle: TextButton.styleFrom(
                foregroundColor: forest,
              ),
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
  // FORM VALIDATION + TRIP SUMMARY
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
          content: const Row(
            children: [
              Icon(Icons.info_outline_rounded, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text('Please complete all trip details first.'),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: forest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: surface,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(27),
        ),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 490),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(23, 24, 18, 23),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [forest, forestLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 49,
                        width: 49,
                        decoration: BoxDecoration(
                          color: gold.withValues(alpha: 0.19),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: gold.withValues(alpha: 0.4),
                          ),
                        ),
                        child: const Icon(
                          Icons.check_circle_rounded,
                          color: gold,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 13),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Journey Awaits!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Your trip preferences are ready.',
                              style: TextStyle(
                                color: Color(0xFFD8E9E1),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'YOUR TRIP OVERVIEW',
                        style: TextStyle(
                          color: primary,
                          fontSize: 10,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _SummaryRow(
                        icon: Icons.trip_origin_rounded,
                        label: 'Starting point',
                        value: startController.text.trim(),
                        color: teal,
                      ),
                      _SummaryRow(
                        icon: Icons.location_on_rounded,
                        label: 'Destination',
                        value: destinationController.text.trim(),
                        color: primary,
                      ),
                      _SummaryRow(
                        icon: Icons.calendar_month_rounded,
                        label: 'Start date',
                        value:
                            '${startDate!.day}/${startDate!.month}/${startDate!.year}',
                        color: lavender,
                      ),
                      _SummaryRow(
                        icon: Icons.account_balance_wallet_rounded,
                        label: 'Budget',
                        value: selectedBudget!,
                        color: const Color(0xFFB77919),
                      ),
                      _SummaryRow(
                        icon: Icons.timelapse_rounded,
                        label: 'Duration',
                        value: selectedDays!,
                        color: forestLight,
                      ),
                      _SummaryRow(
                        icon: Icons.directions_rounded,
                        label: 'Travel preference',
                        value: selectedTravelPreference!,
                        color: teal,
                      ),
                      _SummaryRow(
                        icon: Icons.explore_rounded,
                        label: 'Interests',
                        value: selectedInterests.join(', '),
                        color: primary,
                      ),
                      const SizedBox(height: 7),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4DB),
                          borderRadius: BorderRadius.circular(17),
                          border: Border.all(
                            color: gold.withValues(alpha: 0.45),
                          ),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              color: Color(0xFF9B6810),
                              size: 22,
                            ),
                            SizedBox(width: 11),
                            Expanded(
                              child: Text(
                                'Your preferences have been collected. Connect your AI itinerary generator to turn these details into a day-by-day heritage adventure.',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.55,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 51,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: forest,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Continue Exploring',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
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
        scrolledUnderElevation: 0,
        leading: IconButton(
          tooltip: 'Go back',
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: forest,
            size: 23,
          ),
          onPressed: () {
            final navigator = Navigator.of(context);
            if (navigator.canPop()) {
              navigator.pop();
            } else {
              navigator.maybePop();
            }
          },
        ),
        titleSpacing: 2,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan Your Journey',
              style: TextStyle(
                color: textColor,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Your next story starts here',
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
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              height: 41,
              width: 41,
              decoration: BoxDecoration(
                color: peach,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.explore_rounded,
                color: primary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final contentWidth = isWide ? 1000.0 : constraints.maxWidth;

          return Stack(
            children: [
              Positioned(
                top: 35,
                right: -90,
                child: _BackgroundCircle(
                  size: 220,
                  color: primary.withValues(alpha: 0.045),
                ),
              ),
              Positioned(
                top: 470,
                left: -95,
                child: _BackgroundCircle(
                  size: 200,
                  color: gold.withValues(alpha: 0.075),
                ),
              ),
              SafeArea(
                child: Center(
                  child: SizedBox(
                    width: contentWidth,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        isWide ? 32 : 18,
                        10,
                        isWide ? 32 : 18,
                        28,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildIntroCard(isWide),
                          const SizedBox(height: 28),
                          _buildStepHeading(
                            number: '01',
                            title: 'The Essentials',
                            subtitle:
                                'Where are you going, and when does your adventure begin?',
                          ),
                          const SizedBox(height: 16),
                          if (isWide)
                            _buildWideLocationDateSection()
                          else
                            _buildMobileLocationDateSection(),
                          const SizedBox(height: 30),
                          _buildStepHeading(
                            number: '02',
                            title: 'Your Trip Details',
                            subtitle:
                                'Set your budget and choose how long you want to explore.',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildBudgetSection()),
                              const SizedBox(width: 13),
                              Expanded(child: _buildDurationSection()),
                            ],
                          ),
                          const SizedBox(height: 31),
                          _buildStepHeading(
                            number: '03',
                            title: 'Choose Your Experience',
                            subtitle:
                                'Select the heritage experiences that interest you most.',
                          ),
                          const SizedBox(height: 16),
                          _buildExploreSection(),
                          const SizedBox(height: 31),
                          _buildStepHeading(
                            number: '04',
                            title: 'Getting Around',
                            subtitle:
                                'Choose your preferred way to travel.',
                          ),
                          const SizedBox(height: 16),
                          _buildTravelSection(),
                          const SizedBox(height: 30),
                          _buildPlanningNote(),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: _generateTrip,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: Colors.white,
                                elevation: 3,
                                shadowColor:
                                    primary.withValues(alpha: 0.25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.auto_awesome_rounded, size: 21),
                                  SizedBox(width: 10),
                                  Text(
                                    'Generate My Trip',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(width: 9),
                                  Icon(Icons.arrow_forward_rounded, size: 19),
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
                                  Icons.eco_rounded,
                                  size: 15,
                                  color: forestLight,
                                ),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    'Discover the past. Experience the present.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: secondaryText,
                                      fontWeight: FontWeight.w600,
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
      padding: EdgeInsets.all(isWide ? 29 : 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF123C30), Color(0xFF28745A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: gold.withValues(alpha: 0.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.16),
            blurRadius: 23,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -14,
            top: -28,
            child: Icon(
              Icons.account_balance_rounded,
              size: isWide ? 180 : 130,
              color: Colors.white.withValues(alpha: 0.055),
            ),
          ),
          Positioned(
            right: 65,
            bottom: -32,
            child: Icon(
              Icons.landscape_rounded,
              size: 110,
              color: gold.withValues(alpha: 0.09),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isWide ? 72 : 57,
                height: isWide ? 72 : 57,
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(
                    color: gold.withValues(alpha: 0.55),
                  ),
                ),
                child: Icon(
                  Icons.map_rounded,
                  color: gold,
                  size: isWide ? 37 : 30,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: gold.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'YOUR NEXT ADVENTURE',
                        style: TextStyle(
                          color: Color(0xFFFFD88A),
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Build Your Heritage Trip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isWide ? 23 : 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Discover hidden gems, walk through history, and create a journey that is uniquely yours.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: isWide ? 13 : 12,
                        height: 1.65,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepHeading({
    required String number,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 39,
          height: 39,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: forest,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: forest.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: gold,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
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
                  color: textColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.35,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  color: secondaryText,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // LOCATION + DATE
  // ============================================================

  Widget _buildMobileLocationDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          title: 'Starting Point',
          icon: Icons.trip_origin_rounded,
          color: teal,
        ),
        const SizedBox(height: 9),
        _InputCard(
          controller: startController,
          hint: 'Where are you starting from?',
          icon: Icons.location_on_rounded,
          color: teal,
        ),
        const SizedBox(height: 18),
        const _SectionLabel(
          title: 'Destination',
          icon: Icons.place_rounded,
          color: primary,
        ),
        const SizedBox(height: 9),
        _InputCard(
          controller: destinationController,
          hint: 'Where would you like to go?',
          icon: Icons.location_searching_rounded,
          color: primary,
        ),
        const SizedBox(height: 18),
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
                icon: Icons.trip_origin_rounded,
                color: teal,
              ),
              const SizedBox(height: 9),
              _InputCard(
                controller: startController,
                hint: 'Starting location',
                icon: Icons.location_on_rounded,
                color: teal,
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionLabel(
                title: 'Destination',
                icon: Icons.place_rounded,
                color: primary,
              ),
              const SizedBox(height: 9),
              _InputCard(
                controller: destinationController,
                hint: 'Destination location',
                icon: Icons.location_searching_rounded,
                color: primary,
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
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
          icon: Icons.calendar_month_rounded,
          color: lavender,
        ),
        const SizedBox(height: 9),
        Material(
          color: surface,
          borderRadius: BorderRadius.circular(17),
          child: InkWell(
            borderRadius: BorderRadius.circular(17),
            onTap: _selectStartDate,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                border: Border.all(
                  color: startDate == null ? sandstone : lavender,
                  width: startDate == null ? 1 : 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 43,
                    height: 43,
                    decoration: BoxDecoration(
                      color: lavender.withValues(alpha: 0.11),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: lavender,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
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
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Travel date',
                          style: TextStyle(
                            color: secondaryText,
                            fontSize: 10,
                          ),
                        ),
                      ],
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
  // BUDGET + DURATION
  // ============================================================

  Widget _buildBudgetSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          title: 'Budget',
          icon: Icons.account_balance_wallet_rounded,
          color: Color(0xFFB77919),
        ),
        const SizedBox(height: 9),
        _DropdownCard(
          value: selectedBudget,
          hint: 'Select budget',
          icon: Icons.currency_rupee_rounded,
          color: const Color(0xFFB77919),
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
          color: teal,
        ),
        const SizedBox(height: 9),
        _DropdownCard(
          value: selectedDays,
          hint: 'Select days',
          icon: Icons.date_range_rounded,
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
        const Text(
          'Pick your favourite experiences',
          style: TextStyle(
            color: secondaryText,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 800
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
                crossAxisSpacing: 11,
                mainAxisSpacing: 11,
                mainAxisExtent: 83,
              ),
              itemBuilder: (context, index) {
                final item = exploreOptions[index];
                final title = item['title'] as String;

                return _InterestTile(
                  title: title,
                  icon: item['icon'] as IconData,
                  color: item['color'] as Color,
                  selected: selectedInterests.contains(title),
                  onTap: () {
                    setState(() {
                      if (selectedInterests.contains(title)) {
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
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: forestLight,
              size: 16,
            ),
            const SizedBox(width: 7),
            Text(
              selectedInterests.isEmpty
                  ? 'Select one or more interests'
                  : '${selectedInterests.length} experience${selectedInterests.length == 1 ? '' : 's'} selected',
              style: const TextStyle(
                color: secondaryText,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (selectedInterests.isNotEmpty) ...[
              const Spacer(),
              TextButton(
                onPressed: () => setState(selectedInterests.clear),
                child: const Text(
                  'Clear',
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ],
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
        const Text(
          'Choose what works best for your journey.',
          style: TextStyle(
            color: secondaryText,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 500 ? 4 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: travelOptions.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 11,
                mainAxisSpacing: 11,
                mainAxisExtent: 83,
              ),
              itemBuilder: (context, index) {
                final item = travelOptions[index];
                final title = item['title'] as String;

                return _TravelTile(
                  title: title,
                  icon: item['icon'] as IconData,
                  color: item['color'] as Color,
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

  // ============================================================
  // PLANNING NOTE
  // ============================================================

  Widget _buildPlanningNote() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3EC),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFCFE1D2),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.tips_and_updates_rounded,
            color: forest,
            size: 23,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A little planning goes a long way',
                  style: TextStyle(
                    color: forest,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Choose a realistic budget and leave room to discover local food, crafts and unexpected heritage gems.',
                  style: TextStyle(
                    color: Color(0xFF456458),
                    fontSize: 11,
                    height: 1.6,
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
// DECORATIVE BACKGROUND CIRCLE
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
  final Color color;

  const _SectionLabel({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 17, color: color),
        ),
        const SizedBox(width: 9),
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
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
        border: Border.all(color: _TripScreenState.sandstone),
        boxShadow: [
          BoxShadow(
            color: _TripScreenState.textColor.withValues(alpha: 0.035),
            blurRadius: 13,
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
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.11),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 19),
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
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 3),
      decoration: BoxDecoration(
        color: _TripScreenState.surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: _TripScreenState.sandstone),
        boxShadow: [
          BoxShadow(
            color: _TripScreenState.textColor.withValues(alpha: 0.035),
            blurRadius: 13,
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
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(
                    color: _TripScreenState.secondaryText,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
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
            fontSize: 11,
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
            horizontal: 9,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: selected ? color : _TripScreenState.sandstone,
              width: selected ? 1.6 : 1,
            ),
            color: selected
                ? color.withValues(alpha: 0.075)
                : _TripScreenState.surface,
          ),
          child: Row(
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, color: color, size: 19),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10.5,
                    height: 1.3,
                    fontWeight: FontWeight.w800,
                    color: _TripScreenState.textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selected)
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: color,
                    size: 16,
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
            horizontal: 9,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: selected ? color : _TripScreenState.sandstone,
              width: selected ? 1.6 : 1,
            ),
            color: selected
                ? color.withValues(alpha: 0.075)
                : _TripScreenState.surface,
          ),
          child: Row(
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, color: color, size: 19),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10.5,
                    height: 1.3,
                    fontWeight: FontWeight.w800,
                    color: _TripScreenState.textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selected)
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: color,
                    size: 16,
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
// SUMMARY ROW
// ================================================================

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 10,
                      color: _TripScreenState.secondaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.45,
                      fontWeight: FontWeight.w800,
                      color: _TripScreenState.textColor,
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
}
