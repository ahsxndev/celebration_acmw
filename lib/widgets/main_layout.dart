import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  // FIX: Added 'Registration' between Schedule and Organizers
  static const Map<String, String> _routes = {
    'Home': '/',
    'About': '/about',
    'Speakers': '/speakers',
    'Schedule': '/schedule',
    'Registration': '/registration',
    'Organizers': '/organizers',
    'Contact': '/contact',
  };

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isDesktop = width > 1000;
    final bool isCompactDesktop = width > 1000 && width < 1200;
    final double headerHeight = width <= 375 ? 60.0 : 80.0;

    final bool isHome = widget.activePage == 'Home';

    final Color navBgColor = !isHome || _isScrolled
        ? AppTheme.white.withOpacity(0.95)
        : Colors.transparent;

    final Color contentColor = !isHome || _isScrolled
        ? AppTheme.primaryPurple
        : Colors.white;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(headerHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _isScrolled ? 15.0 : 0.0,
              sigmaY: _isScrolled ? 15.0 : 0.0,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: navBgColor,
                border: Border(
                  bottom: BorderSide(
                    color: _isScrolled ? Colors.grey.withOpacity(0.2) : Colors.transparent,
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
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                titleSpacing: 0,
                toolbarHeight: headerHeight,
                title: Padding(
                  padding: EdgeInsets.only(left: width <= 375 ? 16 : 32),
                  child: _buildAnimatedLogo(isCompactDesktop, width, contentColor),
                ),
                // FIX: Removed the Register button from the desktop actions
                actions: isDesktop
                    ? [
                  ..._routes.keys.map(
                        (title) => _navLink(
                      title,
                      context,
                      isActive: widget.activePage == _activeKey(title),
                      isCompact: isCompactDesktop,
                      textColor: contentColor,
                    ),
                  ),
                  SizedBox(width: isCompactDesktop ? 12 : 24),
                ]
                    : [
                  Builder(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: IconButton(
                        icon: Icon(
                          Icons.menu_rounded,
                          color: contentColor,
                          size: 30,
                        ),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
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
            if (notification.metrics.pixels > 50 && !_isScrolled) {
              setState(() => _isScrolled = true);
            } else if (notification.metrics.pixels <= 50 && _isScrolled) {
              setState(() => _isScrolled = false);
            }
          }
          return false;
        },
        child: isHome
            ? widget.child
            : Padding(
          padding: EdgeInsets.only(top: headerHeight),
          child: widget.child,
        ),
      ),
    );
  }

  Widget _navLink(
      String title,
      BuildContext context, {
        required bool isActive,
        required bool isCompact,
        required Color textColor,
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
              overlayColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                color: isActive
                    ? AppTheme.accentMagenta
                    : (_isScrolled ? textColor : textColor.withOpacity(0.9)),
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                fontSize: isCompact ? 13 : 15,
                fontFamily: 'Montserrat',
              ),
              child: Text(title),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.only(top: 2),
            height: 3,
            width: isActive ? 24.0 : 0.0,
            decoration: BoxDecoration(
              color: AppTheme.accentMagenta,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedLogo(bool isCompact, double width, Color textColor) {
    final logoSize = width <= 375 ? 45.0 : (isCompact ? 75.0 : 85.0);

    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: _isScrolled ? 0.90 : 1.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/acm_logo.png',
            height: logoSize,
            errorBuilder: (_, _, _) => Icon(
              Icons.computer,
              color: textColor,
              size: logoSize,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "ACM-W RCET",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w900,
                  fontSize: width <= 425 ? 15 : 20,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              Text(
                "Celebration",
                style: TextStyle(
                  color: AppTheme.accentMagenta,
                  fontWeight: FontWeight.bold,
                  fontSize: width <= 425 ? 12 : 14,
                  letterSpacing: 0.5,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, double width) {
    return Drawer(
      backgroundColor: AppTheme.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 8, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildAnimatedLogo(true, width, AppTheme.primaryPurple)),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade200, height: 1),
            // FIX: Removed the bottom Register padding from the Drawer
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: _routes.entries.map((entry) {
                  final isActive = widget.activePage == _activeKey(entry.key);
                  return _drawerItem(entry.key, entry.value, context, isActive);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, String path, BuildContext context, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.lightLavender : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
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