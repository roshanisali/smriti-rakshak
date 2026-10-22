
import 'package:flutter/material.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  // ============================================================
  // SMRITI RAKSHAK — COLOUR PALETTE
  // ============================================================

  static const Color primary = Color(0xFFE0533C);
  static const Color primaryDark = Color(0xFFA6321F);
  static const Color gold = Color(0xFFF2A922);
  static const Color background = Color(0xFFFFF8EF);
  static const Color surface = Colors.white;
  static const Color text = Color(0xFF172D26);
  static const Color secondary = Color(0xFF68766F);
  static const Color forest = Color(0xFF173F35);
  static const Color forestLight = Color(0xFF28745D);
  static const Color teal = Color(0xFF168C91);
  static const Color sandstone = Color(0xFFE9DED0);
  static const Color paleGold = Color(0xFFFFF0CE);
  static const Color paleCoral = Color(0xFFFFE8E1);
  static const Color paleGreen = Color(0xFFE6F3EB);

  // ============================================================
  // STATE
  // ============================================================

  String selectedCategory = 'All';
  String searchQuery = '';

  final TextEditingController _searchController =
      TextEditingController();

  final List<String> categories = const [
    'All',
    'Handicrafts',
    'Art',
    'Textiles',
    'Jewellery',
    'Workshops',
    'Experiences',
  ];

  final Set<String> _savedItems = {};
  final List<_Product> _bag = [];

  // ============================================================
  // PRODUCTS
  // ============================================================

  final List<_Product> products = const [
    _Product(
      title: 'Warli Art',
      subtitle: 'Traditional wall art',
      price: '₹1,200',
      seller: 'Local Artisan',
      imagePath: 'assets/images/warli.jpeg',
      category: 'Art',
      accentColor: primary,
    ),
    _Product(
      title: 'Handwoven Textile',
      subtitle: 'Traditional craft',
      price: '₹850',
      seller: 'Craft Collective',
      imagePath: 'assets/images/textile.jpeg',
      category: 'Textiles',
      accentColor: gold,
    ),
    _Product(
      title: 'Blue Pottery',
      subtitle: 'Decorative craft',
      price: '₹1,050',
      seller: 'Heritage Artisan',
      imagePath: 'assets/images/bluepottery.jpeg',
      category: 'Handicrafts',
      accentColor: teal,
    ),
    _Product(
      title: 'Folk Art Print',
      subtitle: 'Regional artwork',
      price: '₹450',
      seller: 'Art Collective',
      imagePath: 'assets/images/folkart.jpeg',
      category: 'Art',
      accentColor: forestLight,
    ),
    _Product(
      title: 'Heritage Jewellery',
      subtitle: 'Traditional design',
      price: '₹1,800',
      seller: 'Craft Studio',
      imagePath: 'assets/images/jewellery.jpeg',
      category: 'Jewellery',
      accentColor: primary,
    ),
    _Product(
      title: 'Handmade Decor',
      subtitle: 'Cultural home decor',
      price: '₹700',
      seller: 'Local Makers',
      imagePath: 'assets/images/homedecor.jpeg',
      category: 'Handicrafts',
      accentColor: gold,
    ),
  ];

  final List<_Product> featuredProducts = const [
    _Product(
      title: 'Warli Heritage Art',
      subtitle: 'Hand-painted traditional artwork',
      price: '₹1,200',
      seller: 'Maya Arts',
      imagePath: 'assets/images/warli.jpeg',
      category: 'Art',
      accentColor: primary,
    ),
    _Product(
      title: 'Paithani Textile',
      subtitle: 'Traditional handwoven textile',
      price: '₹3,800',
      seller: 'Craft Collective',
      imagePath: 'assets/images/paithani3.jpeg',
      category: 'Textiles',
      accentColor: gold,
    ),
    _Product(
      title: 'Terracotta Collection',
      subtitle: 'Handcrafted traditional pottery',
      price: '₹950',
      seller: 'Heritage Hands',
      imagePath: 'assets/images/terracotta.jpeg',
      category: 'Handicrafts',
      accentColor: teal,
    ),
  ];

  // ============================================================
  // CULTURAL EXPERIENCES
  // ============================================================

  final List<_Experience> experiences = const [
    _Experience(
      title: 'Learn Warli Painting',
      description: 'A hands-on workshop with a traditional artist.',
      price: '₹600 / person',
      imagePath: 'assets/images/warliworkshop.jpeg',
      accentColor: primary,
    ),
    _Experience(
      title: 'Traditional Pottery Workshop',
      description: 'Create your own piece with a local artisan.',
      price: '₹750 / person',
      imagePath: 'assets/images/potteryworkshop.jpeg',
      accentColor: teal,
    ),
    _Experience(
      title: 'Heritage Craft Walk',
      description: 'Explore local crafts, makers and traditions.',
      price: '₹500 / person',
      imagePath: 'assets/images/craftwalk.jpeg',
      accentColor: forestLight,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // FILTERING
  // ============================================================

  List<_Product> get filteredProducts {
    final query = searchQuery.toLowerCase().trim();

    return products.where((product) {
      final matchesCategory = selectedCategory == 'All' ||
          product.category == selectedCategory;

      final matchesSearch = query.isEmpty ||
          product.title.toLowerCase().contains(query) ||
          product.subtitle.toLowerCase().contains(query) ||
          product.seller.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  bool _isSaved(String title) => _savedItems.contains(title);

  // ============================================================
  // MESSAGES
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: forest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
  }

  void _toggleSaved(_Product product) {
    final wasSaved = _savedItems.contains(product.title);

    setState(() {
      if (wasSaved) {
        _savedItems.remove(product.title);
      } else {
        _savedItems.add(product.title);
      }
    });

    _showMessage(
      wasSaved
          ? '${product.title} removed from saved items.'
          : '${product.title} saved for later.',
    );
  }

  void _addToBag(_Product product) {
    setState(() => _bag.add(product));
    _showMessage('${product.title} added to your bag.');
  }

  void _clearFilters() {
    setState(() {
      selectedCategory = 'All';
      searchQuery = '';
      _searchController.clear();
    });
  }

  // ============================================================
  // BUTTON STYLES
  // ============================================================

  ButtonStyle _primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  // ============================================================
  // PRICE FORMAT
  // ============================================================

  String _formatPrice(int price) {
    final value = price.toString();
    final result = StringBuffer();

    for (int i = 0; i < value.length; i++) {
      result.write(value[i]);
      final remaining = value.length - i - 1;

      if (remaining > 0 && remaining % 2 == 0) {
        result.write(',');
      }
    }

    return result.toString();
  }

  // ============================================================
  // SHOPPING BAG
  // ============================================================

  void _showBag() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final total = _bag.fold<int>(
              0,
              (sum, product) => sum + product.priceInRupees,
            );

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 42,
                          height: 5,
                          decoration: BoxDecoration(
                            color: sandstone,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 23),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Your shopping bag',
                              style: TextStyle(
                                color: text,
                                fontSize: 23,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: const BoxDecoration(
                              color: paleGold,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Text(
                              '${_bag.length} items',
                              style: const TextStyle(
                                color: primaryDark,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      if (_bag.isEmpty)
                        const Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  color: teal,
                                  size: 58,
                                ),
                                SizedBox(height: 14),
                                Text(
                                  'Your bag is waiting for a story.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: text,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  'Discover handmade heritage treasures.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: secondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else ...[
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: _bag.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final product = _bag[index];

                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: background,
                                  borderRadius: BorderRadius.circular(17),
                                  border: Border.all(
                                    color: sandstone.withValues(alpha: 0.7),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: SizedBox(
                                        width: 68,
                                        height: 68,
                                        child: Image.asset(
                                          product.imagePath,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                            color: paleGold,
                                            child: Icon(
                                              Icons.palette_rounded,
                                              color: product.accentColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 13),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: text,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            product.price,
                                            style: const TextStyle(
                                              color: primary,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      tooltip: 'Remove item',
                                      onPressed: () {
                                        setState(() => _bag.removeAt(index));
                                        setSheetState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: primary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: paleGreen,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Estimated total',
                                  style: TextStyle(
                                    color: forest,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Text(
                                '₹${_formatPrice(total)}',
                                style: const TextStyle(
                                  color: forest,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(sheetContext);
                              _showMessage(
                                'Checkout is a demo. Connect a payment gateway to accept orders.',
                              );
                            },
                            style: _primaryButtonStyle(),
                            child: const Text(
                              'Continue to checkout  →',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // PRODUCT DETAILS
  // ============================================================

  void _showProductDetails(_Product product) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final saved = _isSaved(product.title);

            return Dialog(
              backgroundColor: surface,
              insetPadding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                        child: SizedBox(
                          height: 235,
                          width: double.infinity,
                          child: Image.asset(
                            product.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: paleGold,
                              child: Icon(
                                Icons.palette_rounded,
                                color: product.accentColor,
                                size: 65,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: product.accentColor.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                product.category.toUpperCase(),
                                style: TextStyle(
                                  color: product.accentColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            Text(
                              product.title,
                              style: const TextStyle(
                                color: text,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.subtitle,
                              style: const TextStyle(
                                color: secondary,
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                const Icon(
                                  Icons.storefront_rounded,
                                  color: teal,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Made by ${product.seller}',
                                    style: const TextStyle(
                                      color: secondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Close',
                                  onPressed: () =>
                                      Navigator.pop(dialogContext),
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: secondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.price,
                                    style: const TextStyle(
                                      color: primary,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    _toggleSaved(product);
                                    setDialogState(() {});
                                  },
                                  icon: Icon(
                                    saved
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    size: 18,
                                  ),
                                  label: Text(saved ? 'Saved' : 'Save'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: primary,
                                    side: const BorderSide(color: sandstone),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 13),
                            SizedBox(
                              width: double.infinity,
                              height: 51,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                  _addToBag(product);
                                },
                                icon: const Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 19,
                                ),
                                label: const Text(
                                  'Add to bag',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                style: _primaryButtonStyle(),
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
          },
        );
      },
    );
  }

  // ============================================================
  // CULTURAL EXPERIENCES
  // ============================================================

  void _showExperiences() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        icon: const Icon(
          Icons.auto_awesome_rounded,
          color: gold,
          size: 36,
        ),
        title: const Text(
          'Cultural Experiences',
          style: TextStyle(
            color: forest,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: const Text(
          'Learn traditional crafts, meet local artisans and experience living heritage through hands-on activities.',
          style: TextStyle(
            color: secondary,
            height: 1.7,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Explore below',
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

  void _showExperienceDetails(_Experience experience) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: surface,
        insetPadding: const EdgeInsets.all(22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(27),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(27),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 215,
                    child: Image.asset(
                      experience.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: paleGold,
                        child: Icon(
                          Icons.auto_awesome_rounded,
                          size: 58,
                          color: experience.accentColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'A LIVING HERITAGE EXPERIENCE',
                        style: TextStyle(
                          color: teal,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 11),
                      Text(
                        experience.title,
                        style: const TextStyle(
                          color: forest,
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        experience.description,
                        style: const TextStyle(
                          color: secondary,
                          fontSize: 13,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 17),
                      Text(
                        experience.price,
                        style: TextStyle(
                          color: experience.accentColor,
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 49,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            _showMessage(
                              'Experience booking is a demo and can be connected to a booking system.',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: forest,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Enquire about this experience',
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
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY FILTER
  // ============================================================

  void _showCategoryFilter() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: sandstone,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Browse categories',
                  style: TextStyle(
                    color: forest,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Choose what you would like to discover.',
                  style: TextStyle(color: secondary, fontSize: 13),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 9,
                  runSpacing: 10,
                  children: categories.map((category) {
                    final selected = selectedCategory == category;

                    return ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      showCheckmark: false,
                      selectedColor: forest,
                      backgroundColor: background,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : text,
                        fontWeight: FontWeight.w800,
                      ),
                      side: BorderSide(
                        color: selected ? forest : sandstone,
                      ),
                      onSelected: (_) {
                        setState(() => selectedCategory = category);
                        Navigator.pop(sheetContext);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        toolbarHeight: 82,
        leading: IconButton(
          tooltip: 'Go back',
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              _showMessage('You are already on the main screen.');
            }
          },
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
              'The Heritage Bazaar',
              style: TextStyle(
                color: forest,
                fontSize: 21,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.6,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'CRAFTS  ·  ART  ·  EXPERIENCES',
              style: TextStyle(
                color: secondary,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  tooltip: 'Shopping bag',
                  onPressed: _showBag,
                  style: IconButton.styleFrom(
                    backgroundColor: surface,
                    foregroundColor: forest,
                    fixedSize: const Size(46, 46),
                  ),
                  icon: const Icon(Icons.shopping_bag_outlined),
                ),
                if (_bag.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${_bag.length}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isDesktop = width >= 1050;
          final isTablet = width >= 650 && width < 1050;
          final contentWidth = isDesktop ? 1180.0 : 920.0;

          final crossAxisCount = width >= 1100
              ? 4
              : width >= 650
                  ? 3
                  : 2;

          final horizontalPadding = width < 420 ? 16.0 : 26.0;

          final gridItemHeight = width < 380
              ? 300.0
              : width < 650
                  ? 315.0
                  : width < 1100
                      ? 325.0
                      : 330.0;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              12,
              horizontalPadding,
              36,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SearchBar(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() => searchQuery = value);
                      },
                      onFilter: _showCategoryFilter,
                      onClear: () {
                        setState(() {
                          searchQuery = '';
                          _searchController.clear();
                        });
                      },
                    ),
                    const SizedBox(height: 25),

                    // HERO BANNER
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(isDesktop ? 38 : 25),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF16483B),
                            Color(0xFF226652),
                            Color(0xFF153B32),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: forest.withValues(alpha: 0.19),
                            blurRadius: 26,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -45,
                            right: -35,
                            child: Container(
                              width: 190,
                              height: 190,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: gold.withValues(alpha: 0.15),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -24,
                            bottom: -38,
                            child: Icon(
                              Icons.spa_rounded,
                              size: isDesktop ? 200 : 130,
                              color: Colors.white.withValues(alpha: 0.055),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: gold.withValues(alpha: 0.17),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: gold.withValues(alpha: 0.5),
                                        ),
                                      ),
                                      child: const Text(
                                        '✦  MADE WITH HERITAGE',
                                        style: TextStyle(
                                          color: Color(0xFFFFD985),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.1,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 19),
                                    Text(
                                      'Every craft has\na story.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isDesktop ? 42 : 31,
                                        fontWeight: FontWeight.w900,
                                        height: 1.12,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                    const SizedBox(height: 13),
                                    const Text(
                                      'Bring home the beauty of living traditions. Discover handmade treasures and meet the people keeping culture alive.',
                                      style: TextStyle(
                                        color: Color(0xFFDCEAE2),
                                        fontSize: 13,
                                        height: 1.8,
                                      ),
                                    ),
                                    const SizedBox(height: 23),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: _clearFilters,
                                          icon: const Icon(
                                            Icons.explore_rounded,
                                            size: 18,
                                          ),
                                          label: const Text('Explore collection'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: gold,
                                            foregroundColor: forest,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 18,
                                              vertical: 15,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                        ),
                                        OutlinedButton.icon(
                                          onPressed: _showExperiences,
                                          icon: const Icon(
                                            Icons.auto_awesome_rounded,
                                            size: 17,
                                          ),
                                          label: const Text('Experiences'),
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            side: BorderSide(
                                              color: Colors.white.withValues(
                                                alpha: 0.45,
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
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (width >= 620) ...[
                                SizedBox(width: isDesktop ? 35 : 18),
                                Container(
                                  width: isDesktop ? 165 : 115,
                                  height: isDesktop ? 165 : 115,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: gold.withValues(alpha: 0.13),
                                    border: Border.all(
                                      color: gold.withValues(alpha: 0.45),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.palette_rounded,
                                    color: gold,
                                    size: isDesktop ? 82 : 57,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 34),

                    // CATEGORIES
                    const _SectionHeader(
                      title: 'Explore by craft',
                      subtitle: 'Find something that speaks to you',
                      showViewAll: false,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 47,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 9),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final selected = selectedCategory == category;

                          return ChoiceChip(
                            label: Text(category),
                            selected: selected,
                            showCheckmark: false,
                            onSelected: (_) {
                              setState(() => selectedCategory = category);
                            },
                            selectedColor: forest,
                            backgroundColor: surface,
                            side: BorderSide(
                              color: selected ? forest : sandstone,
                            ),
                            labelStyle: TextStyle(
                              color: selected ? Colors.white : text,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11,
                              vertical: 7,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 34),

                    // FEATURED PRODUCTS
                    _SectionHeader(
                      title: 'Treasures worth discovering',
                      subtitle: 'Handpicked from local creators',
                      onViewAll: _clearFilters,
                    ),
                    const SizedBox(height: 17),
                    SizedBox(
                      height: isDesktop ? 365 : 340,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: featuredProducts.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final product = featuredProducts[index];

                          return SizedBox(
                            width: isDesktop
                                ? 310
                                : isTablet
                                    ? 275
                                    : 250,
                            child: _FeaturedProductCard(
                              product: product,
                              isSaved: _isSaved(product.title),
                              onTap: () => _showProductDetails(product),
                              onFavorite: () => _toggleSaved(product),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 37),

                    // PRODUCT GRID
                    _SectionHeader(
                      title: 'Find your next favourite',
                      subtitle: filteredProducts.isEmpty
                          ? 'No products match your search'
                          : '${filteredProducts.length} handcrafted finds',
                      onViewAll: _clearFilters,
                    ),
                    const SizedBox(height: 17),
                    if (filteredProducts.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(34),
                        decoration: BoxDecoration(
                          color: surface,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: sandstone),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.search_off_rounded,
                              color: teal,
                              size: 48,
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              'No treasures found',
                              style: TextStyle(
                                color: forest,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              'Try another keyword or category.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: secondary,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextButton(
                              onPressed: _clearFilters,
                              child: const Text(
                                'Clear search and filters',
                                style: TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      GridView.builder(
                        itemCount: filteredProducts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: gridItemHeight,
                        ),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];

                          return _GridProductCard(
                            product: product,
                            isSaved: _isSaved(product.title),
                            onTap: () => _showProductDetails(product),
                            onFavorite: () => _toggleSaved(product),
                          );
                        },
                      ),
                    const SizedBox(height: 39),

                    // CULTURAL EXPERIENCES
                    const _SectionHeader(
                      title: 'Experiences that bring culture closer',
                      subtitle: 'Learn directly from tradition bearers',
                      showViewAll: false,
                    ),
                    const SizedBox(height: 18),
                    if (isDesktop)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: experiences.asMap().entries.map((entry) {
                          final index = entry.key;
                          final experience = entry.value;

                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index == experiences.length - 1
                                    ? 0
                                    : 14,
                              ),
                              child: _ExperienceCard(
                                experience: experience,
                                onTap: () =>
                                    _showExperienceDetails(experience),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    else if (isTablet)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: experiences.map((experience) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: _ExperienceCard(
                                experience: experience,
                                compact: true,
                                onTap: () =>
                                    _showExperienceDetails(experience),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    else
                      Column(
                        children: experiences.map((experience) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: _ExperienceCard(
                              experience: experience,
                              onTap: () =>
                                  _showExperienceDetails(experience),
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 39),

                    // SELLER BANNER
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(isDesktop ? 30 : 22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFFF0D4),
                            Color(0xFFFFE5D9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(27),
                        border: Border.all(
                          color: gold.withValues(alpha: 0.45),
                        ),
                      ),
                      child: isDesktop
                          ? Row(
                              children: [
                                const _SellerIcon(),
                                const SizedBox(width: 20),
                                const Expanded(child: _SellerText()),
                                const SizedBox(width: 20),
                                ElevatedButton.icon(
                                  onPressed: () => _showMessage(
                                    'Seller registration can be connected here.',
                                  ),
                                  icon: const Icon(
                                    Icons.storefront_rounded,
                                    size: 18,
                                  ),
                                  label: const Text('Become a seller'),
                                  style: _primaryButtonStyle(),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                const _SellerIcon(),
                                const SizedBox(height: 15),
                                const _SellerText(),
                                const SizedBox(height: 19),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton.icon(
                                    onPressed: () => _showMessage(
                                      'Seller registration can be connected here.',
                                    ),
                                    icon: const Icon(
                                      Icons.storefront_rounded,
                                      size: 18,
                                    ),
                                    label: const Text('Become a seller'),
                                    style: _primaryButtonStyle(),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 28),

                    // FOOTER
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: sandstone),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.spa_rounded,
                            color: teal,
                            size: 27,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Preserving heritage, one creation at a time.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: forest,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'SMRITI RAKSHAK  ·  DISCOVER  ·  EXPERIENCE  ·  PRESERVE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: secondary,
                              fontSize: 9,
                              letterSpacing: 0.7,
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
        },
      ),
    );
  }
}

// ============================================================
// PRODUCT MODEL
// ============================================================

class _Product {
  final String title;
  final String subtitle;
  final String price;
  final String seller;
  final String imagePath;
  final String category;
  final Color accentColor;

  const _Product({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.seller,
    required this.imagePath,
    required this.category,
    required this.accentColor,
  });

  int get priceInRupees {
    final digits = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }
}

// ============================================================
// EXPERIENCE MODEL
// ============================================================

class _Experience {
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final Color accentColor;

  const _Experience({
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.accentColor,
  });
}

// ============================================================
// SEARCH BAR
// ============================================================

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilter;
  final VoidCallback onClear;

  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.onFilter,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: _MarketplaceScreenState.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _MarketplaceScreenState.sandstone),
        boxShadow: [
          BoxShadow(
            color: _MarketplaceScreenState.forest.withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 17),
          const Icon(
            Icons.search_rounded,
            color: _MarketplaceScreenState.teal,
            size: 23,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(
                color: _MarketplaceScreenState.text,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                hintText: 'Search crafts, art, creators...',
                hintStyle: TextStyle(
                  color: _MarketplaceScreenState.secondary,
                  fontSize: 13,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              tooltip: 'Clear search',
              onPressed: onClear,
              icon: const Icon(
                Icons.close_rounded,
                color: _MarketplaceScreenState.secondary,
                size: 19,
              ),
            ),
          Container(
            width: 1,
            height: 27,
            color: _MarketplaceScreenState.sandstone,
          ),
          IconButton(
            tooltip: 'Filter products',
            onPressed: onFilter,
            icon: const Icon(
              Icons.tune_rounded,
              color: _MarketplaceScreenState.primary,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION HEADER
// ============================================================

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onViewAll;
  final bool showViewAll;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    this.onViewAll,
    this.showViewAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 43,
          decoration: BoxDecoration(
            color: _MarketplaceScreenState.primary,
            borderRadius: BorderRadius.circular(10),
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
                  color: _MarketplaceScreenState.forest,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _MarketplaceScreenState.secondary,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        if (showViewAll && onViewAll != null)
          TextButton(
            onPressed: onViewAll,
            child: const Text(
              'View all',
              style: TextStyle(
                color: _MarketplaceScreenState.primary,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// FEATURED PRODUCT CARD
// ============================================================

class _FeaturedProductCard extends StatelessWidget {
  final _Product product;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const _FeaturedProductCard({
    required this.product,
    required this.isSaved,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _MarketplaceScreenState.surface,
      borderRadius: BorderRadius.circular(23),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: _MarketplaceScreenState.sandstone),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      product.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: _MarketplaceScreenState.paleGold,
                        child: Icon(
                          Icons.palette_rounded,
                          color: product.accentColor,
                          size: 52,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: _MarketplaceScreenState.gold,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '✦ FEATURED',
                          style: TextStyle(
                            color: _MarketplaceScreenState.forest,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.7,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _FavoriteButton(
                        isSaved: isSaved,
                        onPressed: onFavorite,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _MarketplaceScreenState.forest,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _MarketplaceScreenState.secondary,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          product.price,
                          style: TextStyle(
                            color: product.accentColor == 
                                    _MarketplaceScreenState.gold
                                ? _MarketplaceScreenState.primaryDark
                                : product.accentColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            product.seller,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: _MarketplaceScreenState.secondary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
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

// ============================================================
// PRODUCT GRID CARD
// ============================================================

class _GridProductCard extends StatelessWidget {
  final _Product product;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const _GridProductCard({
    required this.product,
    required this.isSaved,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _MarketplaceScreenState.surface,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _MarketplaceScreenState.sandstone),
            boxShadow: [
              BoxShadow(
                color: _MarketplaceScreenState.forest.withValues(alpha: 0.025),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      product.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: _MarketplaceScreenState.paleGold,
                        child: Icon(
                          Icons.image_outlined,
                          color: product.accentColor,
                          size: 42,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _FavoriteButton(
                        isSaved: isSaved,
                        onPressed: onFavorite,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _MarketplaceScreenState.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.category,
                          style: TextStyle(
                            color: product.accentColor ==
                                    _MarketplaceScreenState.gold
                                ? _MarketplaceScreenState.primaryDark
                                : product.accentColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _MarketplaceScreenState.forest,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _MarketplaceScreenState.secondary,
                          fontSize: 10,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              product.price,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: product.accentColor ==
                                        _MarketplaceScreenState.gold
                                    ? _MarketplaceScreenState.primaryDark
                                    : product.accentColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              product.seller,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: _MarketplaceScreenState.secondary,
                                fontSize: 9,
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
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// FAVOURITE BUTTON
// ============================================================

class _FavoriteButton extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onPressed;

  const _FavoriteButton({
    required this.isSaved,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _MarketplaceScreenState.surface.withValues(alpha: 0.96),
      shape: const CircleBorder(),
      elevation: 2,
      child: IconButton(
        tooltip: isSaved ? 'Remove from saved items' : 'Save item',
        onPressed: onPressed,
        icon: Icon(
          isSaved
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: isSaved
              ? _MarketplaceScreenState.primary
              : _MarketplaceScreenState.forest,
          size: 18,
        ),
        constraints: const BoxConstraints.tightFor(
          width: 38,
          height: 38,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

// ============================================================
// EXPERIENCE CARD
// ============================================================

class _ExperienceCard extends StatelessWidget {
  final _Experience experience;
  final VoidCallback onTap;
  final bool compact;

  const _ExperienceCard({
    required this.experience,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _MarketplaceScreenState.surface,
      borderRadius: BorderRadius.circular(23),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: _MarketplaceScreenState.sandstone),
          ),
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: compact ? 105 : 155,
                  child: Image.asset(
                    experience.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: _MarketplaceScreenState.paleGold,
                      child: Icon(
                        Icons.auto_awesome_rounded,
                        color: experience.accentColor,
                        size: 42,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                experience.title,
                maxLines: compact ? 3 : 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _MarketplaceScreenState.forest,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                experience.description,
                maxLines: compact ? 4 : 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _MarketplaceScreenState.secondary,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      experience.price,
                      style: TextStyle(
                        color: experience.accentColor ==
                                _MarketplaceScreenState.gold
                            ? _MarketplaceScreenState.primaryDark
                            : experience.accentColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: experience.accentColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: experience.accentColor ==
                              _MarketplaceScreenState.gold
                          ? _MarketplaceScreenState.primaryDark
                          : experience.accentColor,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SELLER SECTION
// ============================================================

class _SellerIcon extends StatelessWidget {
  const _SellerIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            _MarketplaceScreenState.gold,
            Color(0xFFFFD575),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _MarketplaceScreenState.gold.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Icon(
        Icons.storefront_rounded,
        color: _MarketplaceScreenState.forest,
        size: 33,
      ),
    );
  }
}

class _SellerText extends StatelessWidget {
  const _SellerText();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Are you a creator or artisan?',
          style: TextStyle(
            color: _MarketplaceScreenState.forest,
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 7),
        Text(
          'Share your craft with the world and help keep cultural traditions alive.',
          style: TextStyle(
            color: _MarketplaceScreenState.secondary,
            fontSize: 13,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}
