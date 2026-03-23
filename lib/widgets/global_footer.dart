import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
// NEW MAP IMPORTS
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../core/theme.dart';

class GlobalFooter extends StatelessWidget {
  const GlobalFooter({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 850;

    return Container(
      width: double.infinity,
      color: AppTheme.primaryPurple,
      padding: EdgeInsets.only(
        left: isMobile ? 24 : 80,
        right: isMobile ? 24 : 80,
        top: isMobile ? 40 : 60,
        bottom: 20,
      ),
      child: Column(
        children: [
          isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),

          SizedBox(height: isMobile ? 30 : 50),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 20),

          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                "© 2026 RCET UET ACM-W Student Chapter. All Rights Reserved.",
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              ),
              if (isMobile) const SizedBox(height: 8),
              Text(
                "Empowering Women in Tech",
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ==========================================
  // DESKTOP LAYOUT
  // ==========================================
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 40),
          child: Image.asset(
            'assets/images/rcet_logo.png',
            height: 100,
            width: 100,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.school, color: Colors.white, size: 60),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeading("Contact Us"),
              _footerText("RCET UET ACM-W Student Chapter"),
              const SizedBox(height: 8),

              // Icons and Text
              _footerTextWithIcon(Icons.location_on_rounded, "Rachna College of Engineering and Technology,\nGujranwala, Pakistan"),
              _footerTextWithIcon(Icons.phone_rounded, "+92 309 7072739"),
              _footerTextWithIcon(Icons.email_rounded, "acmwrcetchapter@gmail.com"),

              const SizedBox(height: 16),
              Row(
                children: [
                  _socialIcon(FontAwesomeIcons.facebookF, "https://facebook.com/acmwrcet"),
                  const SizedBox(width: 12),
                  _socialIcon(FontAwesomeIcons.instagram, "https://instagram.com/acmw_rcet"),
                  const SizedBox(width: 12),
                  _socialIcon(FontAwesomeIcons.linkedinIn, "https://linkedin.com/company/rcet-uet-acm-w-student-chapter/"),
                ],
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeading("Quick Links"),
              _footerLink(context, "» Home", "/"),
              _footerLink(context, "» About", "/about"),
              _footerLink(context, "» Speakers", "/speakers"),
              _footerLink(context, "» Schedule", "/schedule"),
              _footerLink(context, "» Registration", "/registration"),
              _footerLink(context, "» Organizers", "/organizers"),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeading("Our Location"),
              _buildMapWidget(isMobile: false),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // MOBILE LAYOUT
  // ==========================================
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/rcet_logo.png',
          height: 70,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.school, color: Colors.white, size: 50),
        ),
        const SizedBox(height: 20),
        const Text(
            "RCET UET ACM-W Student Chapter",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
        ),
        const SizedBox(height: 24),

        // FIX: Left-Aligned Contact Block, centered on the mobile screen
        Container(
          constraints: const BoxConstraints(maxWidth: 300), // Bounded width keeps it looking compact and neat
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Forces icons into a perfect straight vertical line
            children: [
              _footerTextWithIcon(Icons.location_on_rounded, "Rachna College of Engineering and Technology,\nGujranwala, Pakistan"),
              _footerTextWithIcon(Icons.email_rounded, "acmwrcetchapter@gmail.com"),
              _footerTextWithIcon(Icons.phone_rounded, "+92 309 7072739"),
            ],
          ),
        ),

        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIcon(FontAwesomeIcons.facebookF, "https://facebook.com/acmwrcet"),
            const SizedBox(width: 16),
            _socialIcon(FontAwesomeIcons.instagram, "https://instagram.com/acmw_rcet"),
            const SizedBox(width: 16),
            _socialIcon(FontAwesomeIcons.linkedinIn, "https://linkedin.com/company/rcet-uet-acm-w-student-chapter/"),
          ],
        ),

        const SizedBox(height: 40),
        _buildHeading("Quick Links", isCentered: true),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            _footerLink(context, "Home", "/"),
            _footerLink(context, "About", "/about"),
            _footerLink(context, "Speakers", "/speakers"),
            _footerLink(context, "Schedule", "/schedule"),
            _footerLink(context, "Registration", "/registration"),
            _footerLink(context, "Organizers", "/organizers"),
          ],
        ),

        const SizedBox(height: 40),
        _buildHeading("Our Location", isCentered: true),
        _buildMapWidget(isMobile: true),
      ],
    );
  }

  // ==========================================
  // REUSABLE COMPONENTS
  // ==========================================
  Widget _buildHeading(String text, {bool isCentered = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(height: 2, width: 40, color: AppTheme.accentMagenta),
        ],
      ),
    );
  }

  Widget _footerText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, height: 1.4)),
    );
  }

  // FIX: This unified widget now perfectly handles both Desktop and Mobile formatting!
  Widget _footerTextWithIcon(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns icon to the top line of text
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0), // Tiny nudge to align icon center with first text line
            child: Icon(icon, color: AppTheme.accentMagenta, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            // Expanded forces the text to wrap cleanly at the edge of the screen/container
            child: Text(
                text,
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, height: 1.4)
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(BuildContext context, String text, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: () => context.go(route),
        child: Text(text, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          color: Colors.white.withOpacity(0.05),
        ),
        child: FaIcon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  // ==========================================
  // REAL OPENSTREETMAP WIDGET
  // ==========================================
  Widget _buildMapWidget({required bool isMobile}) {
    final LatLng rcetLocation = const LatLng(32.3610958, 74.207957);

    return InkWell(
      onTap: () => _launchUrl("https://www.google.com/maps/search/?api=1&query=32.3610958,74.207957"),
      child: Container(
        height: isMobile ? 140 : 160,
        width: isMobile ? double.infinity : 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            children: [
              IgnorePointer(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: rcetLocation,
                    initialZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.acmw.rcet',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: rcetLocation,
                          width: 40,
                          height: 40,
                          child: Icon(Icons.location_on, color: Colors.red.shade700, size: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.1)),
              ),

              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Maps ", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
                      Icon(Icons.open_in_new, size: 12, color: Colors.blue),
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