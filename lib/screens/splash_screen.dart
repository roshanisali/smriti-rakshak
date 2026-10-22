
import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _slideAnimation;

  Timer? _navigationTimer;

  // Heritage theme colors
  static const Color primary = Color(0xFFC6533B);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE6B85C);
  static const Color background = Color(0xFFF7F2E8);
  static const Color forest = Color(0xFF294536);
  static const Color forestLight = Color(0xFF42634B);
  static const Color textDark = Color(0xFF29352C);
  static const Color textMuted = Color(0xFF77786C);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.82,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _slideAnimation = Tween<double>(
      begin: 22,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();

    _navigationTimer = Timer(
      const Duration(seconds: 3),
      () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;
          final isSmall = constraints.maxHeight < 600;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF9F5EB),
                  Color(0xFFF0E5D0),
                  Color(0xFFE6D7BA),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Decorative heritage-inspired circles
                Positioned(
                  top: -140,
                  right: isWide ? -30 : -100,
                  child: _DecorativeCircle(
                    size: isWide ? 430 : 300,
                    color: primary.withOpacity(0.07),
                  ),
                ),

                Positioned(
                  top: constraints.maxHeight * 0.20,
                  left: isWide ? -180 : -120,
                  child: _DecorativeCircle(
                    size: isWide ? 350 : 230,
                    color: forest.withOpacity(0.06),
                  ),
                ),

                Positioned(
                  bottom: -150,
                  right: isWide ? 80 : -100,
                  child: _DecorativeCircle(
                    size: isWide ? 400 : 300,
                    color: gold.withOpacity(0.13),
                  ),
                ),

                // Decorative top border
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          forest,
                          forestLight,
                          gold,
                          primary,
                        ],
                      ),
                    ),
                  ),
                ),

                // Main content
                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 40 : 24,
                      vertical: 35,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 720,
                      ),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                _slideAnimation.value,
                              ),
                              child: Transform.scale(
                                scale: _scaleAnimation.value,
                                child: child,
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Brand emblem
                              Container(
                                width: isWide ? 128 : 112,
                                height: isWide ? 128 : 112,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFFFFCF6),
                                  border: Border.all(
                                    color: gold,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: forest.withOpacity(0.10),
                                      blurRadius: 28,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: isWide ? 98 : 86,
                                      height: isWide ? 98 : 86,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: gold.withOpacity(0.55),
                                          width: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: isWide ? 78 : 68,
                                      height: isWide ? 78 : 68,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: forest.withOpacity(0.07),
                                      ),
                                    ),
                                    Icon(
                                      Icons.account_balance_rounded,
                                      size: isWide ? 53 : 46,
                                      color: forest,
                                    ),
                                    Positioned(
                                      bottom: isWide ? 23 : 20,
                                      child: Container(
                                        width: 27,
                                        height: 2.5,
                                        decoration: BoxDecoration(
                                          color: primary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: isSmall ? 20 : 30),

                              // App name
                              Text(
                                'SMRITI',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isWide ? 43 : 36,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: isWide ? 12 : 9,
                                  color: forest,
                                  height: 1.2,
                                ),
                              ),

                              Text(
                                'RAKSHAK',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isWide ? 43 : 36,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: isWide ? 8 : 6,
                                  color: primary,
                                  height: 1.2,
                                ),
                              ),

                              const SizedBox(height: 19),

                              // Decorative divider
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 42,
                                    height: 1.2,
                                    color: gold,
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.auto_awesome_rounded,
                                    color: primary,
                                    size: 17,
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 42,
                                    height: 1.2,
                                    color: gold,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),

                              // Tagline
                              Text(
                                'Discover  •  Experience  •  Preserve',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isWide ? 15 : 12,
                                  letterSpacing: isWide ? 1.8 : 1.1,
                                  color: forest,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: isSmall ? 30 : 48),

                              // Loading indicator
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    primary,
                                  ),
                                  backgroundColor:
                                      forest.withOpacity(0.10),
                                ),
                              ),

                              const SizedBox(height: 15),

                              Text(
                                'UNLOCKING OUR HERITAGE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 2,
                                  color: forest.withOpacity(0.75),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                'A journey through the stories of India',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textMuted.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Footer
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        12,
                        20,
                        18,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 44,
                            height: 1.2,
                            color: gold,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'PRESERVING STORIES  •  CONNECTING GENERATIONS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isWide ? 10 : 9,
                              letterSpacing: isWide ? 1.5 : 0.8,
                              color: forest.withOpacity(0.65),
                              fontWeight: FontWeight.w700,
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
        },
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _DecorativeCircle({
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
