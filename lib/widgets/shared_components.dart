import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // ADDED FOR ICONS
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';

// ==========================================
// SMART IMAGE HANDLER (INTERNAL)
// ==========================================
class _ProfileImageFallback extends StatelessWidget {
  final String imageUrl;
  final double size;

  const _ProfileImageFallback({required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    final errorWidget = Container(
      width: size,
      height: size,
      color: AppTheme.lightLavender,
      child: Center(
        child: Icon(
          Icons.person_rounded,
          size: size * 0.5,
          color: AppTheme.primaryPurple.withOpacity(0.4),
        ),
      ),
    );

    if (imageUrl.isEmpty) return errorWidget;

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => errorWidget,
      );
    } else {
      return Image.asset(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => errorWidget,
      );
    }
  }
}

// ==========================================
// 1. SECTION HEADER WIDGET
// ==========================================
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleSize = screenWidth < 600 ? 24 : (screenWidth < 900 ? 28 : 32);
    final double subtitleSize = screenWidth < 600 ? 14 : 16;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.primaryPurple,
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textDark.withOpacity(0.7),
              fontSize: subtitleSize,
            ),
          ),
        ],
        const SizedBox(height: 16),
        Container(
          height: 4,
          width: 60,
          decoration: BoxDecoration(
            color: AppTheme.accentMagenta,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

// ==========================================
// 2. UNIVERSAL PROFILE CARD (WITH LINKEDIN BADGE)
// ==========================================
enum CardSize { large, regular, small }

class UniversalProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String? topic;
  final String imageUrl;
  final String? tagText;
  final Color? tagColor;
  final String? profileUrl; // Opens when the whole card is clicked
  final String? linkedinUrl; // ADDED: Opens when the small icon is clicked
  final CardSize size;

  const UniversalProfileCard({
    super.key,
    required this.name,
    required this.role,
    this.topic,
    required this.imageUrl,
    this.tagText,
    this.tagColor,
    this.profileUrl,
    this.linkedinUrl, // ADDED
    this.size = CardSize.regular,
  });

  Future<void> _launchURL(String? link) async {
    if (link != null && link.isNotEmpty) {
      final Uri url = Uri.parse(link);
      try {
        if (!await launchUrl(url)) debugPrint('Could not launch $url');
      } catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final double cardWidth = size == CardSize.large
        ? (isMobile ? 260 : 300)
        : size == CardSize.small
        ? (isMobile ? 220 : 250)
        : (isMobile ? 240 : 260);

    final double imageSize = size == CardSize.large
        ? (isMobile ? 90 : 120)
        : (isMobile ? 70 : 100);

    final double titleFontSize = size == CardSize.large
        ? (isMobile ? 15 : 20)
        : (isMobile ? 14 : 18);

    final double roleFontSize = isMobile ? 11 : 14;
    final double cardPadding = isMobile ? 16 : 24;

    double exactMobileHeight = 0;
    if (isMobile) {
      if (size == CardSize.large) exactMobileHeight = 342;
      else if (size == CardSize.small) exactMobileHeight = 222;
      else exactMobileHeight = 292;
    }

    Widget cardBody = Container(
      width: cardWidth,
      height: isMobile ? exactMobileHeight : null,
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: profileUrl != null ? AppTheme.primaryPurple.withOpacity(0.1) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPurple.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- IMAGE WITH OPTIONAL BADGE ---
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.lightLavender, width: 3),
                    ),
                    child: ClipOval(
                      child: _ProfileImageFallback(imageUrl: imageUrl, size: imageSize),
                    ),
                  ),

                  // NEW: Badge Icon logic
                  if (linkedinUrl != null && linkedinUrl!.isNotEmpty)
                    GestureDetector(
                      onTap: () => _launchURL(linkedinUrl),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: EdgeInsets.all(isMobile ? 4 : 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
                            ],
                          ),
                          // Smart Icon: Shows LinkedIn if URL contains 'linkedin', else shows a web icon (for Staff Links)
                          child: linkedinUrl!.contains('linkedin')
                              ? FaIcon(FontAwesomeIcons.linkedin, size: isMobile ? 14 : 16, color: const Color(0xFF0077B5))
                              : Icon(Icons.public_rounded, size: isMobile ? 14 : 16, color: AppTheme.primaryPurple),
                        ),
                      ),
                    ),
                ],
              ),
              // --------------------------------

              const SizedBox(height: 12),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.primaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                role,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textDark.withOpacity(0.7),
                  fontSize: roleFontSize,
                  height: 1.2,
                ),
              ),
              if (topic != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.lightLavender.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: const Border(
                      left: BorderSide(color: AppTheme.accentMagenta, width: 3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "TOPIC",
                        style: TextStyle(
                          color: AppTheme.accentMagenta,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        topic!,
                        style: TextStyle(
                          color: AppTheme.textDark.withOpacity(0.9),
                          fontSize: isMobile ? 10 : 13,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          if (tagText != null && tagColor != null)
            Padding(
              // ADDED SPACE BEFORE THE TAG
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: tagColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tagText!,
                  style: TextStyle(
                    color: AppTheme.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 8 : 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );

    // Card background click logic
    if (profileUrl != null && profileUrl!.isNotEmpty) {
      return GestureDetector(
        onTap: () => _launchURL(profileUrl),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: cardBody,
        ),
      );
    }

    return cardBody;
  }
}

// ==========================================
// 3. ORGANIZER AVATAR WIDGET
// ==========================================
class OrganizerAvatar extends StatelessWidget {
  final String name;
  final String teamRole;
  final String imageUrl;

  const OrganizerAvatar({
    super.key,
    required this.name,
    required this.teamRole,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const double radius = 40;
    const double size = radius * 2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.lightLavender,
          ),
          child: ClipOval(
            child: _ProfileImageFallback(imageUrl: imageUrl, size: size),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppTheme.primaryPurple,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          teamRole,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.textDark.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}