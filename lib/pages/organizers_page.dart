import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../widgets/global_footer.dart';
import '../widgets/shared_components.dart';

class OrganizersPage extends StatelessWidget {
  const OrganizersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth <= 800;

    final double horizontalPadding = screenWidth > 800 ? 80 : (isTablet ? 40 : 20);
    final double mobileSpacing = 16;

    final double cardWidth = isMobile
        ? (screenWidth - (horizontalPadding * 2) - mobileSpacing) / 2
        : 280;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 30 : 50,
            ),
            child: Column(
              children: [
                const SectionHeader(
                  title: "The Team Behind the Celebration",
                  subtitle: "Meet the dedicated individuals working hard to make ACM-W Celebrations (RCETCWIC) 2026 a success.",
                ),
                SizedBox(height: isMobile ? 30 : 50),

                // ==========================================
                // 1. CHAIRS SECTION
                // ==========================================
                Text(
                  "Program Committee",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 24),

                Wrap(
                  spacing: isMobile ? mobileSpacing : 32,
                  runSpacing: isMobile ? mobileSpacing : 32,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. Natasha Nigar",
                        role: "Celebration Chair",
                        profileUrl: "https://staff.uet.edu.pk/profile/973",
                        linkedinUrl: "https://www.linkedin.com/in/dr-natasha-nigar-a4a5b113",
                        imageUrl: "assets/images/persons/natasha.png",
                        tagText: "Profile",
                        tagColor: AppTheme.accentMagenta,
                        size: CardSize.small,
                      ),
                    ),
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Mr. Shahid Islam",
                        role: "Program Chair",
                        profileUrl: "https://staff.uet.edu.pk/profile/765",
                        linkedinUrl: "https://staff.uet.edu.pk/profile/765",
                        imageUrl: "assets/images/persons/shahid.png",
                        tagText: "Profile",
                        tagColor: AppTheme.accentMagenta,
                        size: CardSize.small,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: isMobile ? 50 : 80),

                // ==========================================
                // 2. ENGAGEMENT LEADS SECTION
                // ==========================================
                Text(
                  "Students Engagement Leads",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 32),

                Wrap(
                  spacing: isMobile ? 16 : 40,
                  runSpacing: isMobile ? 24 : 40,
                  alignment: WrapAlignment.center,
                  children: const [
                    _VolunteerAvatar(
                      name: "Haleema Sadia",
                      imageUrl: "assets/images/volunteers/haleema.jpeg",
                      linkedinUrl: "https://www.linkedin.com/in/haleema-ghumman",
                    ),
                    _VolunteerAvatar(
                      name: "Asma Fatima",
                      imageUrl: "assets/images/volunteers/asma.jpeg",
                      linkedinUrl: "https://www.linkedin.com/in/asma-fatima254/",
                    ),
                  ],
                ),

                SizedBox(height: isMobile ? 50 : 80),

                // ==========================================
                // 3. TEAM MEMBERS SECTION
                // ==========================================
                Text(
                  "Team Members",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 32),

                Wrap(
                  spacing: isMobile ? 16 : 40,
                  runSpacing: isMobile ? 24 : 40,
                  alignment: WrapAlignment.center,
                  children: const [
                    _VolunteerAvatar(
                      name: "Abdullah Gondal",
                      imageUrl: "assets/images/volunteers/abdullah.jpeg",
                      linkedinUrl: "https://www.linkedin.com/in/abdullah-gondal-58b7582b2",
                    ),
                    _VolunteerAvatar(
                      name: "Ahsan Zaman",
                      imageUrl: "assets/images/volunteers/ahsan.jpeg",
                      linkedinUrl: "https://www.linkedin.com/in/ahxanzaman/",
                    ),
                    _VolunteerAvatar(
                      name: "Wafa Abbas",
                      imageUrl: "assets/images/volunteers/wafa.jpeg",
                      linkedinUrl: "https://www.linkedin.com/in/m-wafa-abbas-9abba1281",
                    ),

                    // _VolunteerAvatar(
                    //   name: "M. Mudasser",
                    //   imageUrl: "assets/images/volunteers/mudassir.jpeg",
                    //   linkedinUrl: "https://www.linkedin.com/in/muhammad-mudasser-b85a602b5?utm_source=share_via&utm_content=profile&utm_medium=member_android",
                    // ),
                    _VolunteerAvatar(
                      name: "Abdul Rehman",
                      imageUrl: "assets/images/volunteers/rehman.jpeg",
                      linkedinUrl: "https://www.linkedin.com/in/abdulrehman90",
                    ),
                    _VolunteerAvatar(
                      name: "M. Zaman",
                      imageUrl: "assets/images/volunteers/zaman.jpeg",
                      linkedinUrl: "https://www.linkedin.com/in/sheikhzaman-younis-652165311",
                    ),
                    // _VolunteerAvatar(
                    //   name: "Aden Butt",
                    //   imageUrl: "assets/images/volunteers/aden.jpeg",
                    //   linkedinUrl: "https://www.linkedin.com/in/aden-butt-7b1251252",
                    // ),
                    _VolunteerAvatar(
                      name: "Rejab Zahra",
                      imageUrl: "assets/images/volunteers/rejab.jpeg",
                      linkedinUrl: "https://www.linkedin.com/in/rejab-zahra-19377b320",
                    ),
                    // _VolunteerAvatar(
                    //   name: "M. Aqib Ali",
                    //   imageUrl: "assets/images/volunteers/aqib.jpeg",
                    //   linkedinUrl: "https://www.linkedin.com/in/muhammad-aqib-ali-0b95222b9",
                    // ),

                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          const GlobalFooter(),
        ],
      ),
    );
  }

  // Prevents giant white gaps on mobile layouts by disabling IntrinsicHeight
  Widget _buildAdaptiveCard({required bool isMobile, required double width, required Widget card}) {
    Widget scaled = SizedBox(
      width: width,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.topCenter,
        child: card,
      ),
    );
    if (isMobile) return scaled;
    return IntrinsicHeight(child: scaled);
  }
}

// ==========================================
// UPGRADED VOLUNTEER AVATAR (RESPONSIVE + ANIMATED)
// ==========================================
class _VolunteerAvatar extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String linkedinUrl;

  const _VolunteerAvatar({
    required this.name,
    required this.imageUrl,
    required this.linkedinUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    // Dynamic sizing based on screen size
    final double avatarSize = isMobile ? 80 : 100;
    final double containerWidth = isMobile ? 100 : 130;
    final double nameFontSize = isMobile ? 12 : 14;

    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse(linkedinUrl);
              try {
                if (!await launchUrl(url)) debugPrint('Could not launch $url');
              } catch (e) {
                debugPrint('Error launching URL: $e');
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              transform: Matrix4.identity()..translate(0.0, isHovered ? -5.0 : 0.0), // Lifts up on hover
              width: containerWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Circular Image with integrated badge
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomRight,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: avatarSize,
                        height: avatarSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            // Changes border color on hover
                            color: isHovered ? AppTheme.accentMagenta : AppTheme.primaryPurple.withOpacity(0.15),
                            width: isHovered ? 4 : 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryPurple.withOpacity(isHovered ? 0.2 : 0.05),
                              blurRadius: isHovered ? 20 : 10,
                              offset: Offset(0, isHovered ? 8 : 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.person,
                                size: avatarSize * 0.5,
                                color: AppTheme.primaryPurple.withOpacity(0.3)
                            ),
                          ),
                        ),
                      ),
                      // Small Integrated LinkedIn Badge
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: Container(
                          padding: EdgeInsets.all(isMobile ? 4 : 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 4, offset: const Offset(0, 2)),
                            ],
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.linkedin,
                            size: isMobile ? 14 : 16,
                            color: const Color(0xFF0077B5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 10 : 14),

                  // Name
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.primaryPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: nameFontSize,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}