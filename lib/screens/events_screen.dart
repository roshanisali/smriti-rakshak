
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  static const Color primary = Color(0xFFC94F36);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE8B957);
  static const Color forest = Color(0xFF263D32);
  static const Color forestLight = Color(0xFF385745);
  static const Color sandstone = Color(0xFFE9DDC8);
  static const Color cream = Color(0xFFF7F0E3);
  static const Color surface = Color(0xFFFFFCF6);
  static const Color textColor = Color(0xFF292C25);
  static const Color secondaryText = Color(0xFF777568);
  static const Color teal = Color(0xFF508477);
  static const Color green = Color(0xFF66865B);

  int selectedDay = 15;

  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  final Map<int, List<Map<String, String>>> events = {
    10: [
      {
        'title': 'Heritage Walk',
        'location': 'Shaniwar Wada, Pune',
        'time': '5:00 PM',
        'category': 'Heritage Walk',
      },
      {
        'title': 'Museum Storytelling',
        'location': 'Raja Dinkar Kelkar Museum',
        'time': '7:00 PM',
        'category': 'Exhibition',
      },
    ],
    11: [
      {
        'title': 'Traditional Art Workshop',
        'location': 'Pune Cultural Centre',
        'time': '11:00 AM',
        'category': 'Workshop',
      },
    ],
    12: [
      {
        'title': 'Lavani Performance',
        'location': 'Cultural Centre, Pune',
        'time': '6:30 PM',
        'category': 'Performance',
      },
      {
        'title': 'Craft Demonstration',
        'location': 'Shilpgram',
        'time': '4:00 PM',
        'category': 'Artisan Event',
      },
    ],
    13: [
      {
        'title': 'Historic Pune Walk',
        'location': 'Shaniwar Wada',
        'time': '8:00 AM',
        'category': 'Heritage Walk',
      },
    ],
    14: [
      {
        'title': 'Heritage Photography Exhibition',
        'location': 'Pune Art Gallery',
        'time': '12:00 PM',
        'category': 'Exhibition',
      },
    ],
    15: [
      {
        'title': 'Ganeshotsav Cultural Celebration',
        'location': 'Pune',
        'time': '6:00 PM',
        'category': 'Festival',
      },
    ],
  };

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get allEvents {
    return events.values.expand((list) => list).toList();
  }

  List<Map<String, String>> get visibleEvents {
    final query = searchQuery.trim().toLowerCase();

    if (query.isNotEmpty) {
      return allEvents.where((event) {
        return event.values.any(
          (value) => value.toLowerCase().contains(query),
        );
      }).toList();
    }

    return events[selectedDay] ?? [];
  }

  void _showInfo(String title, String description) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        icon: const Icon(
          Icons.auto_stories_rounded,
          color: primary,
          size: 34,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: forest,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: Text(
          description,
          style: const TextStyle(
            color: secondaryText,
            height: 1.6,
            fontSize: 13,
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

  void _selectCategory(String category) {
    setState(() {
      searchQuery = category;
      searchController.text = category;
    });

    FocusScope.of(context).unfocus();
  }

  void _clearSearch() {
    setState(() {
      searchQuery = '';
      searchController.clear();
    });

    FocusScope.of(context).unfocus();
  }

  void _goBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are already on the first page.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 950;
    final isTablet = width >= 600 && width < 950;

    final horizontalPadding = isDesktop
        ? 34.0
        : isTablet
            ? 25.0
            : 18.0;

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        foregroundColor: forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          tooltip: 'Go back',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _goBack,
        ),
        titleSpacing: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Events & Experiences',
              style: TextStyle(
                color: forest,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Experience heritage in motion',
              style: TextStyle(
                color: secondaryText,
                fontSize: 11,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: sandstone.withOpacity(0.65),
                borderRadius: BorderRadius.circular(14),
              ),
              child: IconButton(
                tooltip: 'Event information',
                onPressed: () => _showInfo(
                  'Heritage Events',
                  'Explore cultural celebrations, heritage walks, artisan workshops and traditional performances.',
                ),
                icon: const Icon(
                  Icons.event_note_rounded,
                  color: forest,
                  size: 21,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                18,
                horizontalPadding,
                35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _EventsHero(
                    isDesktop: isDesktop,
                    onExplore: () {
                      _showInfo(
                        'Find Your Next Experience',
                        'Choose a date from the calendar or search for a cultural event that interests you.',
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  const _SectionTitle(
                    title: 'Find an Experience',
                    subtitle: 'Search events, places and traditions',
                    icon: Icons.travel_explore_rounded,
                  ),

                  const SizedBox(height: 15),

                  Container(
                    constraints: const BoxConstraints(maxWidth: 720),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: sandstone),
                      boxShadow: [
                        BoxShadow(
                          color: forest.withOpacity(0.035),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() => searchQuery = value);
                      },
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.search_rounded,
                          color: primary,
                        ),
                        hintText: 'Search events, locations, categories...',
                        hintStyle: const TextStyle(
                          color: secondaryText,
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                tooltip: 'Clear search',
                                onPressed: _clearSearch,
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: secondaryText,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  const _SectionTitle(
                    title: 'Featured Experience',
                    subtitle: 'Celebrate Maharashtra’s living traditions',
                    icon: Icons.auto_awesome_rounded,
                  ),

                  const SizedBox(height: 15),

                  _FeaturedEvent(
                    isDesktop: isDesktop,
                    onTap: () => _showInfo(
                      'Ganeshotsav',
                      'Explore one of Maharashtra’s best-known cultural celebrations, with community traditions, music and festive decorations.',
                    ),
                  ),

                  const SizedBox(height: 36),

                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _buildCalendar(),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          flex: 6,
                          child: _buildSelectedEvents(),
                        ),
                      ],
                    )
                  else ...[
                    _buildCalendar(),
                    const SizedBox(height: 28),
                    _buildSelectedEvents(),
                  ],

                  const SizedBox(height: 36),

                  const _SectionTitle(
                    title: 'Explore by Category',
                    subtitle: 'There is a story behind every experience',
                    icon: Icons.category_rounded,
                  ),

                  const SizedBox(height: 16),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final count = constraints.maxWidth >= 950
                          ? 3
                          : constraints.maxWidth >= 580
                              ? 3
                              : 2;

                      return GridView.count(
                        crossAxisCount: count,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 13,
                        childAspectRatio:
                            constraints.maxWidth < 400 ? 1.12 : 1.35,
                        children: [
                          _CategoryCard(
                            icon: Icons.theater_comedy_rounded,
                            title: 'Performances',
                            subtitle: 'Music, dance & theatre',
                            color: primary,
                            onTap: () => _selectCategory('Performance'),
                          ),
                          _CategoryCard(
                            icon: Icons.palette_rounded,
                            title: 'Workshops',
                            subtitle: 'Learn traditional arts',
                            color: gold,
                            onTap: () => _selectCategory('Workshop'),
                          ),
                          _CategoryCard(
                            icon: Icons.account_balance_rounded,
                            title: 'Heritage Walks',
                            subtitle: 'Discover historic places',
                            color: teal,
                            onTap: () => _selectCategory('Heritage Walk'),
                          ),
                          _CategoryCard(
                            icon: Icons.celebration_rounded,
                            title: 'Festivals',
                            subtitle: 'Celebrate local culture',
                            color: primaryDark,
                            onTap: () => _selectCategory('Festival'),
                          ),
                          _CategoryCard(
                            icon: Icons.photo_library_rounded,
                            title: 'Exhibitions',
                            subtitle: 'Art, objects & stories',
                            color: green,
                            onTap: () => _selectCategory('Exhibition'),
                          ),
                          _CategoryCard(
                            icon: Icons.handyman_rounded,
                            title: 'Artisan Events',
                            subtitle: 'Meet traditional makers',
                            color: forestLight,
                            onTap: () => _selectCategory('Artisan Event'),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 36),

                  const _SectionTitle(
                    title: 'Experiences Around Pune',
                    subtitle: 'A few ideas for your next outing',
                    icon: Icons.near_me_rounded,
                  ),

                  const SizedBox(height: 16),

                  if (isDesktop)
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _NearbyEvent(
                            title: 'Heritage Walk',
                            location: 'Shaniwar Wada',
                            date: 'Sep 10 · 5:00 PM',
                            icon: Icons.directions_walk_rounded,
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: _NearbyEvent(
                            title: 'Traditional Art Workshop',
                            location: 'Pune Cultural Centre',
                            date: 'Sep 11 · 11:00 AM',
                            icon: Icons.palette_outlined,
                          ),
                        ),
                      ],
                    )
                  else
                    const Column(
                      children: [
                        _NearbyEvent(
                          title: 'Heritage Walk',
                          location: 'Shaniwar Wada',
                          date: 'Sep 10 · 5:00 PM',
                          icon: Icons.directions_walk_rounded,
                        ),
                        SizedBox(height: 12),
                        _NearbyEvent(
                          title: 'Traditional Art Workshop',
                          location: 'Pune Cultural Centre',
                          date: 'Sep 11 · 11:00 AM',
                          icon: Icons.palette_outlined,
                        ),
                      ],
                    ),

                  const SizedBox(height: 30),

                  _JourneyCard(
                    isDesktop: isDesktop,
                    onTap: () => _showInfo(
                      'Your Heritage Journey',
                      'Keep exploring cultural experiences, discover new traditions and take part in preserving local heritage.',
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'SMRITI RAKSHAK',
                          style: TextStyle(
                            color: forest,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Discover • Experience • Preserve',
                          style: TextStyle(
                            color: secondaryText,
                            fontSize: 11,
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
    );
  }

  Widget _buildCalendar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Event Calendar',
          subtitle: 'Choose a day to see what is happening',
          icon: Icons.calendar_month_rounded,
        ),

        const SizedBox(height: 15),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(14, 19, 14, 17),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: sandstone.withOpacity(0.8)),
            boxShadow: [
              BoxShadow(
                color: forest.withOpacity(0.035),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 43,
                    width: 43,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: primary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'September 2026',
                          style: TextStyle(
                            color: forest,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your month of discovery',
                          style: TextStyle(
                            color: secondaryText,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: gold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${events.length} days',
                      style: const TextStyle(
                        color: primaryDark,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 23),

              const Row(
                children: [
                  _DayName('MON'),
                  _DayName('TUE'),
                  _DayName('WED'),
                  _DayName('THU'),
                  _DayName('FRI'),
                  _DayName('SAT'),
                  _DayName('SUN'),
                ],
              ),

              const SizedBox(height: 12),

              // September 1, 2026 falls on a Tuesday.
              _calendarWeek([0, 1, 2, 3, 4, 5, 6]),
              _calendarWeek([7, 8, 9, 10, 11, 12, 13]),
              _calendarWeek([14, 15, 16, 17, 18, 19, 20]),
              _calendarWeek([21, 22, 23, 24, 25, 26, 27]),
              _calendarWeek([28, 29, 30, 0, 0, 0, 0]),

              const SizedBox(height: 13),

              const Divider(color: sandstone, height: 1),

              const SizedBox(height: 13),

              const Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: gold,
                    size: 8,
                  ),
                  SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      'Events scheduled',
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.touch_app_rounded,
                    color: primary,
                    size: 15,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Tap a date',
                    style: TextStyle(
                      color: primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _calendarWeek(List<int> days) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: days.map((day) {
          if (day == 0) {
            return const Expanded(
              child: SizedBox(height: 48),
            );
          }

          final isSelected = selectedDay == day;
          final hasEvent = events.containsKey(day);

          return Expanded(
            child: Tooltip(
              message: hasEvent ? 'Events available' : 'No events scheduled',
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  setState(() {
                    selectedDay = day;
                    searchQuery = '';
                    searchController.clear();
                  });

                  FocusScope.of(context).unfocus();
                },
                child: SizedBox(
                  height: 48,
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        height: 33,
                        width: 33,
                        decoration: BoxDecoration(
                          color: isSelected ? forest : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? forest
                                : hasEvent
                                    ? gold.withOpacity(0.65)
                                    : Colors.transparent,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: forest.withOpacity(0.16),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            '$day',
                            style: TextStyle(
                              color: isSelected ? Colors.white : textColor,
                              fontSize: 12,
                              fontWeight: isSelected || hasEvent
                                  ? FontWeight.w900
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 3),

                      if (hasEvent)
                        Container(
                          height: 4,
                          width: 4,
                          decoration: BoxDecoration(
                            color: isSelected ? primary : gold,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSelectedEvents() {
    final selectedEvents = visibleEvents;
    final isSearching = searchQuery.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          title: isSearching
              ? 'Search Results'
              : 'Events on September $selectedDay',
          subtitle: isSearching
              ? '${selectedEvents.length} matching experience(s)'
              : 'Plans for your selected day',
          icon: Icons.event_available_rounded,
        ),

        const SizedBox(height: 15),

        if (selectedEvents.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(27),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: sandstone),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.event_busy_rounded,
                  color: secondaryText,
                  size: 40,
                ),
                const SizedBox(height: 12),
                const Text(
                  'No events found',
                  style: TextStyle(
                    color: forest,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Try another date or search term.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                if (isSearching) ...[
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: _clearSearch,
                    icon: const Icon(Icons.refresh_rounded, size: 17),
                    label: const Text('Clear search'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primary,
                      side: const BorderSide(color: sandstone),
                    ),
                  ),
                ],
              ],
            ),
          )
        else
          ...selectedEvents.map(
            (event) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _EventCard(
                title: event['title']!,
                location: event['location']!,
                time: event['time']!,
                category: event['category']!,
                onTap: () => _showInfo(
                  event['title']!,
                  '${event['category']} at ${event['location']}.\n\nTime: ${event['time']}\n\nExplore this experience and discover the stories behind it.',
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================================
// HERO
// ============================================================================

class _EventsHero extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onExplore;

  const _EventsHero({
    required this.isDesktop,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 36 : 23),
      decoration: BoxDecoration(
        color: _EventsScreenState.forest,
        borderRadius: BorderRadius.circular(28),
        image: const DecorationImage(
          image: AssetImage('assets/images/Ganesh.jpg'),
          fit: BoxFit.cover,
          opacity: 0.12,
        ),
        boxShadow: [
          BoxShadow(
            color: _EventsScreenState.forest.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -20,
            child: Icon(
              Icons.account_balance_rounded,
              size: isDesktop ? 180 : 115,
              color: Colors.white.withOpacity(0.055),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _EventsScreenState.gold.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: _EventsScreenState.gold.withOpacity(0.5),
                  ),
                ),
                child: const Text(
                  '✦  CULTURE COMES ALIVE',
                  style: TextStyle(
                    color: _EventsScreenState.gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),

              const SizedBox(height: 23),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 610),
                child: Text(
                  'Make memories.\nDiscover traditions.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isDesktop ? 43 : 33,
                    height: 1.08,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 560),
                child: Text(
                  'From historic walks to vibrant festivals, experience the heritage that brings us together.',
                  style: TextStyle(
                    color: Color(0xFFE7E8DD),
                    fontSize: 13,
                    height: 1.7,
                  ),
                ),
              ),

              const SizedBox(height: 23),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: onExplore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _EventsScreenState.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.explore_rounded, size: 18),
                    label: const Text(
                      'Explore Events',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Discover • Experience • Preserve',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION TITLE
// ============================================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 43,
          width: 43,
          decoration: BoxDecoration(
            color: _EventsScreenState.primary.withOpacity(0.10),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: _EventsScreenState.primary,
            size: 22,
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
                  color: _EventsScreenState.forest,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.35,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _EventsScreenState.secondaryText,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// FEATURED EVENT
// ============================================================================

class _FeaturedEvent extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onTap;

  const _FeaturedEvent({
    required this.isDesktop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _EventsScreenState.forest,
      borderRadius: BorderRadius.circular(26),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: isDesktop ? 325 : 295,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/Ganesh.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _EventsScreenState.primaryDark,
                        _EventsScreenState.primary,
                        _EventsScreenState.gold,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.celebration_rounded,
                    size: 90,
                    color: Colors.white24,
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      _EventsScreenState.forest.withOpacity(0.96),
                      _EventsScreenState.forest.withOpacity(0.67),
                      _EventsScreenState.forest.withOpacity(0.08),
                    ],
                    stops: const [0, 0.62, 1],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(isDesktop ? 30 : 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: _EventsScreenState.gold,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'FEATURED CELEBRATION',
                        style: TextStyle(
                          color: _EventsScreenState.forest,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                    const Spacer(),

                    Text(
                      'Ganeshotsav',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isDesktop ? 39 : 31,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.6,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Celebrate · Discover · Experience',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Wrap(
                      spacing: 17,
                      runSpacing: 9,
                      children: [
                        _FeaturedDetail(
                          icon: Icons.location_on_rounded,
                          text: 'Pune, Maharashtra',
                        ),
                        _FeaturedDetail(
                          icon: Icons.calendar_month_rounded,
                          text: '15 September · 6:00 PM',
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: _EventsScreenState.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Discover the event',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 15,
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

class _FeaturedDetail extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeaturedDetail({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: _EventsScreenState.gold,
          size: 15,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// CALENDAR DAY NAME
// ============================================================================

class _DayName extends StatelessWidget {
  final String name;

  const _DayName(this.name);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: _EventsScreenState.secondaryText,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ============================================================================
// EVENT CARD
// ============================================================================

class _EventCard extends StatelessWidget {
  final String title;
  final String location;
  final String time;
  final String category;
  final VoidCallback onTap;

  const _EventCard({
    required this.title,
    required this.location,
    required this.time,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _EventsScreenState.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _EventsScreenState.sandstone.withOpacity(0.85),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: _EventsScreenState.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.event_available_rounded,
                  color: _EventsScreenState.primary,
                  size: 25,
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
                        color: _EventsScreenState.forest,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: _EventsScreenState.secondaryText,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: const TextStyle(
                              color: _EventsScreenState.secondaryText,
                              fontSize: 11,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: _EventsScreenState.teal,
                          size: 14,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          time,
                          style: const TextStyle(
                            color: _EventsScreenState.teal,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 11),

                    Wrap(
                      spacing: 8,
                      runSpacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _EventsScreenState.gold.withOpacity(0.19),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: _EventsScreenState.primaryDark,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const Text(
                          'View details  →',
                          style: TextStyle(
                            color: _EventsScreenState.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
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
    );
  }
}

// ============================================================================
// CATEGORY CARD
// ============================================================================

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _EventsScreenState.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _EventsScreenState.sandstone),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 41,
                width: 41,
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

              const SizedBox(height: 10),

              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _EventsScreenState.forest,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _EventsScreenState.secondaryText,
                  fontSize: 10,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// NEARBY EVENT
// ============================================================================

class _NearbyEvent extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final IconData icon;

  const _NearbyEvent({
    required this.title,
    required this.location,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _EventsScreenState.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _EventsScreenState.sandstone),
      ),
      child: Row(
        children: [
          Container(
            height: 49,
            width: 49,
            decoration: BoxDecoration(
              color: _EventsScreenState.forest.withOpacity(0.09),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: _EventsScreenState.forest,
              size: 23,
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
                    color: _EventsScreenState.forest,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  location,
                  style: const TextStyle(
                    color: _EventsScreenState.secondaryText,
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  date,
                  style: const TextStyle(
                    color: _EventsScreenState.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: _EventsScreenState.secondaryText,
            size: 14,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// JOURNEY CARD
// ============================================================================

class _JourneyCard extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onTap;

  const _JourneyCard({
    required this.isDesktop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _EventsScreenState.forest,
      borderRadius: BorderRadius.circular(25),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(isDesktop ? 27 : 22),
          child: isDesktop
              ? Row(
                  children: [
                    Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                        color: _EventsScreenState.gold.withOpacity(0.17),
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: const Icon(
                        Icons.confirmation_number_rounded,
                        color: _EventsScreenState.gold,
                        size: 31,
                      ),
                    ),

                    const SizedBox(width: 19),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Heritage Journey',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Discover experiences, connect with culture and keep your memories alive.',
                            style: TextStyle(
                              color: Color(0xFFD5DCCF),
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    const _JourneyStat(value: '3', label: 'Events'),

                    const SizedBox(width: 24),

                    const _JourneyStat(value: '2', label: 'Walks'),

                    const SizedBox(width: 24),

                    const _JourneyStat(value: '1', label: 'Workshop'),
                  ],
                )
              : const Column(
                  children: [
                    CircleAvatar(
                      radius: 29,
                      backgroundColor: Color(0x2EE8B957),
                      child: Icon(
                        Icons.confirmation_number_rounded,
                        color: _EventsScreenState.gold,
                        size: 30,
                      ),
                    ),

                    SizedBox(height: 13),

                    Text(
                      'Your Heritage Journey',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    SizedBox(height: 7),

                    Text(
                      'Discover experiences, connect with culture and keep your memories alive.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD5DCCF),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 22),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _JourneyStat(value: '3', label: 'Events'),
                        _JourneyStat(value: '2', label: 'Walks'),
                        _JourneyStat(value: '1', label: 'Workshop'),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ============================================================================
// JOURNEY STAT
// ============================================================================

class _JourneyStat extends StatelessWidget {
  final String value;
  final String label;

  const _JourneyStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: _EventsScreenState.gold,
            fontSize: 23,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFD5DCCF),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
