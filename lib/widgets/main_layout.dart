import 'dart:ui'; // REQUIRED for the frosted glass blur effect
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String activePage;

  const MainLayout({super.key, required this.child, this.activePage = 'Home'});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool _isScrolled = false;

  static const Map<String, String> _routes = {
    'Home': '/',
    'About': '/about',
    'Speakers': '/speakers',
    'Schedule': '/schedule',
    'Organizers': '/organizers',
    'Contact': '/contact',
  };

  Future<void> _launchRegistrationForm() async {
    final Uri url = Uri.parse('https://forms.gle/JGSNx1k6qg2APABa7');
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 850;
    final bool isCompactDesktop = width > 850 && width < 1150;

    final double headerHeight = width <= 375 ? 60.0 : 80.0;

    return Scaffold(
      // CRITICAL: This allows content to scroll UNDER the appbar, enabling the blur effect!
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.white,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(headerHeight),
        child: ClipRRect(
          // Contains the blur
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _isScrolled ? 15.0 : 0.0,
              sigmaY: _isScrolled ? 15.0 : 0.0,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                // Starts mostly solid white to hide the image cutoff, turns translucent glassy on scroll
                color: _isScrolled
                    ? AppTheme.white.withOpacity(0.85)
                    : AppTheme.white.withOpacity(0.98),
                border: Border(
                  bottom: BorderSide(
                    color: _isScrolled
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                boxShadow: _isScrolled
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryPurple.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              // FIXED: Using AppBar inside the AnimatedContainer prevents the 99754px overflow crash!
              child: AppBar(
                backgroundColor: Colors
                    .transparent, // Let the AnimatedContainer show through
                elevation: 0,
                titleSpacing: 0,
                toolbarHeight: headerHeight,
                title: Padding(
                  padding: EdgeInsets.only(left: width <= 375 ? 16 : 32),
                  child: _buildAnimatedLogo(isCompactDesktop, width),
                ),
                actions: isDesktop
                    ? [
                        ..._routes.keys.map(
                          (title) => _navLink(
                            title,
                            context,
                            isActive: widget.activePage == _activeKey(title),
                            isCompact: isCompactDesktop,
                          ),
                        ),
                        SizedBox(width: isCompactDesktop ? 8 : 16),
                        // Center prevents the button from stretching vertically
                        Center(
                          child: _buildRegisterButton(
                            isCompactDesktop,
                            context,
                          ),
                        ),
                        SizedBox(width: isCompactDesktop ? 12 : 24),
                      ]
                    : [
                        Builder(
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: IconButton(
                              icon: const Icon(
                                Icons.menu_rounded,
                                color: AppTheme.primaryPurple,
                                size: 30,
                              ),
                              onPressed: () =>
                                  Scaffold.of(context).openEndDrawer(),
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ),
        ),
      ),

      endDrawer: !isDesktop ? _buildDrawer(context, width) : null,

      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis == Axis.vertical) {
            if (notification.metrics.pixels > 10 && !_isScrolled) {
              setState(() => _isScrolled = true);
            } else if (notification.metrics.pixels <= 10 && _isScrolled) {
              setState(() => _isScrolled = false);
            }
          }
          return false;
        },
        // We add top padding to non-Home pages so their content doesn't get permanently stuck under the AppBar
        child: widget.activePage == 'Home'
            ? widget.child
            : Padding(
                padding: EdgeInsets.only(top: headerHeight),
                child: widget.child,
              ),
      ),
    );
  }

  // --- NAV LINK ---
  // ===================================================
  // PRO ANIMATED NAV LINKS (FIXED)
  // ===================================================
  Widget _navLink(
    String title,
    BuildContext context, {
    required bool isActive,
    required bool isCompact,
  }) {
    final path = _routes[title]!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isCompact ? 8.0 : 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => context.go(path),
            style: TextButton.styleFrom(
              overlayColor:
                  Colors.transparent, // Removes standard ugly hover ripple
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            ),
            // Smoothly transitions font weight and color
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                color: isActive ? AppTheme.primaryPurple : Colors.grey.shade700,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                fontSize: isCompact ? 13 : 15,
                fontFamily: 'Montserrat', // Ensures font consistency
              ),
              child: Text(title),
            ),
          ),
          // FIXED: Swapped to easeOutCubic to prevent negative width crashing
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic, // Safe, smooth premium sliding effect
            margin: const EdgeInsets.only(top: 2),
            height: 3,
            width: isActive ? 24.0 : 0.0, // Safely animates to exactly 0.0
            decoration: BoxDecoration(
              color: AppTheme.accentMagenta,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  // --- LOGO ---
  Widget _buildAnimatedLogo(bool isCompact, double width) {
    final logoSize = width <= 375 ? 33.0 : (isCompact ? 53.0 : 60.0);

    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: _isScrolled ? 0.95 : 1.0, // Subtly shrinks on scroll
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/acm_logo.png',
            height: logoSize,
            errorBuilder: (_, _, _) => Icon(
              Icons.computer,
              color: AppTheme.primaryPurple,
              size: logoSize,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ACM-W RCET",
                style: TextStyle(
                  color: AppTheme.primaryPurple,
                  fontWeight: FontWeight.w800,
                  fontSize: width <= 425 ? 16 : 20,
                ),
              ),
              Text(
                "Celebration",
                style: TextStyle(
                  color: AppTheme.accentMagenta,
                  fontWeight: FontWeight.w600,
                  fontSize: width <= 425 ? 12 : 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- REGISTER BUTTON ---
  Widget _buildRegisterButton(bool isCompact, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: AppTheme.accentMagenta.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: _launchRegistrationForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accentMagenta,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 16 : 24,
            vertical: isCompact ? 14 : 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          "Register Now",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isCompact ? 13 : 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // --- DRAWER ---
  Widget _buildDrawer(BuildContext context, double width) {
    return Drawer(
      backgroundColor: AppTheme.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildAnimatedLogo(false, width)),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade200),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: _routes.entries.map((entry) {
                  final isActive = widget.activePage == _activeKey(entry.key);
                  return _drawerItem(entry.key, entry.value, context, isActive);
                }).toList(),
              ),
            ),
            // NEW: Register Now Button for Mobile Menu
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the drawer
                    _launchRegistrationForm(); // Open the form
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentMagenta,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Register Now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    String title,
    String path,
    BuildContext context,
    bool isActive,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.lightLavender : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            color: isActive ? AppTheme.primaryPurple : Colors.black87,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          context.go(path);
        },
      ),
    );
  }

  String _activeKey(String title) {
    if (title == 'Speakers & Panels') return 'Speakers';
    return title;
  }
}
