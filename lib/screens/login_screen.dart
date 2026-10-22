import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool obscurePassword = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const Color primary = Color(0xFFC6533B);
  static const Color primaryDark = Color(0xFF963B29);
  static const Color gold = Color(0xFFE6B85C);
  static const Color background = Color(0xFFF7F2E8);
  static const Color surface = Color(0xFFFFFCF6);
  static const Color text = Color(0xFF29352C);
  static const Color secondaryText = Color(0xFF77786C);
  static const Color forest = Color(0xFF294536);
  static const Color forestLight = Color(0xFF42634B);
  static const Color sandstone = Color(0xFFE8DDC9);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void openHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final isDesktop = screenWidth >= 950;
            final isTablet = screenWidth >= 600 && screenWidth < 950;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop
                    ? 42
                    : isTablet
                        ? 28
                        : 16,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: isDesktop
                      ? _buildDesktopLayout()
                      : _buildMobileLayout(isTablet),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP LAYOUT
  // ============================================================

  Widget _buildDesktopLayout() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: sandstone.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.09),
            blurRadius: 35,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _buildHeritagePanel(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 54,
                  vertical: 48,
                ),
                child: _buildForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE / TABLET LAYOUT
  // ============================================================

  Widget _buildMobileLayout(bool isTablet) {
    return Column(
      children: [
        _buildCompactHeader(isTablet),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 520),
          padding: EdgeInsets.all(isTablet ? 32 : 23),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: sandstone.withValues(alpha: 0.8),
            ),
            boxShadow: [
              BoxShadow(
                color: forest.withValues(alpha: 0.06),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: _buildForm(),
        ),
        const SizedBox(height: 25),
        const Text(
          'Preserving the past • Exploring the future',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: secondaryText,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DESKTOP HERITAGE PANEL
  // ============================================================

  Widget _buildHeritagePanel() {
    return Container(
      constraints: const BoxConstraints(minHeight: 690),
      padding: const EdgeInsets.all(42),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            forest,
            forestLight,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -25,
            bottom: 65,
            child: Icon(
              Icons.account_balance_rounded,
              size: 220,
              color: Colors.white.withValues(alpha: 0.045),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBrandHeader(),
              const SizedBox(height: 58),
              Container(
                width: 58,
                height: 4,
                decoration: BoxDecoration(
                  color: gold,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Every monument\nhas a story.',
                style: TextStyle(
                  color: surface,
                  fontSize: 43,
                  height: 1.16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Discover India’s timeless heritage, explore hidden places, '
                'and keep our culture alive for generations to come.',
                style: TextStyle(
                  color: surface.withValues(alpha: 0.82),
                  fontSize: 14,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 38),
              _buildFeature(
                Icons.explore_rounded,
                'Discover',
                'Find remarkable places and hidden heritage.',
              ),
              const SizedBox(height: 22),
              _buildFeature(
                Icons.auto_stories_rounded,
                'Experience',
                'Explore stories, traditions and culture.',
              ),
              const SizedBox(height: 22),
              _buildFeature(
                Icons.volunteer_activism_rounded,
                'Preserve',
                'Help protect the legacy of our past.',
              ),
              const Spacer(),
              const SizedBox(height: 35),
              Row(
                children: [
                  const Icon(
                    Icons.diamond_outlined,
                    color: gold,
                    size: 19,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'DISCOVER  •  EXPERIENCE  •  PRESERVE',
                      style: TextStyle(
                        color: surface.withValues(alpha: 0.8),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
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

  // ============================================================
  // BRAND HEADER
  // ============================================================

  Widget _buildBrandHeader() {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: gold.withValues(alpha: 0.7),
            ),
          ),
          child: const Icon(
            Icons.account_balance_rounded,
            color: gold,
            size: 25,
          ),
        ),
        const SizedBox(width: 12),
        const Flexible(
          child: Text(
            'SMRITI RAKSHAK',
            style: TextStyle(
              color: surface,
              fontSize: 17,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FEATURE ROW
  // ============================================================

  Widget _buildFeature(
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          child: Icon(
            icon,
            color: gold,
            size: 22,
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
                  color: surface,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(
                  color: surface.withValues(alpha: 0.75),
                  fontSize: 12,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // COMPACT HEADER
  // ============================================================

  Widget _buildCompactHeader(bool isTablet) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 520),
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isTablet ? 30 : 25,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            forest,
            forestLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -5,
            top: -12,
            child: Icon(
              Icons.account_balance_rounded,
              size: 105,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
          Column(
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  color: surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: gold,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.account_balance_rounded,
                  color: primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'SMRITI RAKSHAK',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.8,
                  color: surface,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Discover  •  Experience  •  Preserve',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.5,
                  color: Color(0xFFFFE8B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOGIN / SIGNUP FORM
  // ============================================================

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.waving_hand_rounded,
                color: primary,
                size: 15,
              ),
              const SizedBox(width: 7),
              Text(
                isLogin ? 'WELCOME BACK' : 'JOIN OUR COMMUNITY',
                style: const TextStyle(
                  color: primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 19),
        Text(
          isLogin ? 'Welcome back!' : 'Create your account',
          style: const TextStyle(
            fontSize: 29,
            height: 1.2,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.7,
            color: text,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isLogin
              ? 'Continue your journey through India’s heritage.'
              : 'Join us in discovering and preserving our cultural heritage.',
          style: const TextStyle(
            fontSize: 13,
            height: 1.7,
            color: secondaryText,
          ),
        ),
        const SizedBox(height: 28),

        // EMAIL
        _buildFieldLabel('Email address'),
        const SizedBox(height: 9),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: _inputDecoration(
            hint: 'Enter your email',
            icon: Icons.email_outlined,
          ),
        ),

        const SizedBox(height: 20),

        // PASSWORD
        _buildFieldLabel('Password'),
        const SizedBox(height: 9),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => openHome(),
          decoration: _inputDecoration(
            hint: 'Enter your password',
            icon: Icons.lock_outline_rounded,
            suffix: IconButton(
              tooltip: obscurePassword ? 'Show password' : 'Hide password',
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: secondaryText,
                size: 20,
              ),
            ),
          ),
        ),

        if (isLogin)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Password recovery is not connected yet.',
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: forestLight,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          )
        else
          const SizedBox(height: 20),

        const SizedBox(height: 8),

        // MAIN BUTTON
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: openHome,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              elevation: 2,
              shadowColor: primary.withValues(alpha: 0.22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin ? 'LOGIN' : 'CREATE ACCOUNT',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 19,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 23),

        // DIVIDER
        Row(
          children: [
            Expanded(
              child: Divider(
                color: sandstone,
                thickness: 1,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                'OR',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: secondaryText,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: sandstone,
                thickness: 1,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // GUEST BUTTON
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: openHome,
            icon: const Icon(
              Icons.explore_outlined,
              color: forestLight,
              size: 20,
            ),
            label: const Text(
              'Explore as Guest',
              style: TextStyle(
                color: forest,
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: forestLight.withValues(alpha: 0.35),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // SWITCH LOGIN / SIGNUP
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                isLogin
                    ? "Don't have an account? "
                    : 'Already have an account? ',
                style: const TextStyle(
                  fontSize: 12,
                  color: secondaryText,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(
                  isLogin ? 'Sign up' : 'Login',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FIELD LABEL
  // ============================================================

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w900,
        color: text,
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: secondaryText,
        fontSize: 13,
      ),
      prefixIcon: Icon(
        icon,
        color: primary,
        size: 20,
      ),
      suffixIcon: suffix,
      filled: true,
      fillColor: background,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: sandstone.withValues(alpha: 0.75),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: primary,
          width: 1.5,
        ),
      ),
    );
  }
}