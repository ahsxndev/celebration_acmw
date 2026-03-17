import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/global_footer.dart';
import '../widgets/shared_components.dart';

class SpeakersPage extends StatelessWidget {
  const SpeakersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth <= 800;

    final double horizontalPadding = screenWidth > 800 ? 80 : (isTablet ? 40 : 20);
    final double mobileSpacing = 16;

    final double cardWidth = isMobile
        ? (screenWidth - (horizontalPadding * 2) - mobileSpacing) / 2
        : 250;

    final double keynoteCardWidth = isMobile
        ? (screenWidth - (horizontalPadding * 2) - mobileSpacing) / 2
        : 350;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 20 : 40, // Reduced top padding on mobile
            ),
            child: Column(
              children: [
                const SectionHeader(
                  title: "Meet Our Speakers & Experts",
                  subtitle: "Learn from industry leaders, panel experts, and hands-on workshop instructors.",
                ),
                // Reduced from 40
                SizedBox(height: isMobile ? 10 : 20),

                // --- 1. KEYNOTE SPEAKERS SECTION ---
                Text(
                  "Keynote Speakers",
                  style: TextStyle(
                    fontSize: isMobile ? 22 : (isTablet ? 24 : 28),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: isMobile ? mobileSpacing : 25,
                  runSpacing: isMobile ? mobileSpacing : 30,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: keynoteCardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. Kashif Shahzad",
                        role: "CEO, Power Information Technology Company (PITC), Lahore, Pakistan",
                        topic: "She Leads the Future: Women Driving Innovation & Transformation in the Digital Age",
                        profileUrl: "https://www.pitc.com.pk/index.php/about/board-of-directors",
                        imageUrl: "assets/images/persons/kashif.png",
                        tagText: "Keynote Speaker",
                        tagColor: AppTheme.accentMagenta,
                        size: CardSize.large,
                      ),
                    ),
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: keynoteCardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. Kashif Shahzad",
                        role: "CEO, Power Information Technology Company (PITC), Lahore, Pakistan",
                        topic: "From Bias to Breakthrough: Dismantling Barriers for Women in Computing",
                        profileUrl: "https://www.pitc.com.pk/index.php/about/board-of-directors",
                        imageUrl: "assets/images/persons/",
                        tagText: "Keynote Speaker",
                        tagColor: AppTheme.accentMagenta,
                        size: CardSize.large,
                      ),
                    ),
                  ],
                ),

                // SIGNIFICANTLY REDUCED GAP (From 60 to 30)
                SizedBox(height: isMobile ? 30 : 80),

                // --- 2. WORKSHOP LEADS SECTION ---
                Text(
                  "Workshop Leads",
                  style: TextStyle(
                    fontSize: isMobile ? 22 : (isTablet ? 24 : 28),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: isMobile ? mobileSpacing : 24,
                  runSpacing: isMobile ? mobileSpacing : 32,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. Sidra Zafar",
                        role: "Head of Computer Science, Kinnaird College, Lahore, Pakistan",
                        topic: "She Builds with AI: A Hands-On Workshop on Generative AI Applications",
                        profileUrl: "https://www.linkedin.com/in/sidra-zafar",
                        imageUrl: "assets/images/persons/sidra.jpeg",
                        tagText: "Workshop Lead",
                        tagColor: Colors.teal,
                      ),
                    ),
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Mr. Usman Nazir",
                        role: "CEO, Theta Solutions, Sialkot, Pakistan",
                        topic: "Cybersecurity Essentials: Protecting the Digital World",
                        profileUrl: "https://thetasolutions.pk/our-core-team/",
                        imageUrl: "assets/images/persons/usman.jpg",
                        tagText: "Workshop Lead",
                        tagColor: Colors.teal,
                      ),
                    ),
                  ],
                ),

                // SIGNIFICANTLY REDUCED GAP (From 60 to 30)
                SizedBox(height: isMobile ? 30 : 80),

                // --- 3. PANELISTS SECTION ---
                Text(
                  "Panelist Speakers",
                  style: TextStyle(
                    fontSize: isMobile ? 22 : (isTablet ? 24 : 28),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: isMobile ? mobileSpacing : 24,
                  runSpacing: isMobile ? mobileSpacing : 32,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. M. Ahmad Raza",
                        role: "FAST NUCES, Lahore, Pakistan",
                        imageUrl: "assets/images/persons/ahmad.jpeg",
                        profileUrl: "https://www.linkedin.com/in/muhammad-ahmad-raza-phd-b0949310",
                        size: CardSize.small,
                      ),
                    ),
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Mr. Muhammad Umer",
                        role: "Sr. Software Engineer, Geopaq Logic, Irvine, Los Angeles, USA",
                        imageUrl: "assets/images/persons/umer.jpeg",
                        size: CardSize.small,
                      ),
                    ),
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Ms. Shumaila Khaliq",
                        role: "Sr. Software Engineer, CU Direct, Irvine, Los Angeles, USA",
                        imageUrl: "assets/images/persons/shumaila.jpeg",
                        size: CardSize.small,
                      ),
                    ),
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. M. Ahmad Raza",
                        role: "FAST NUCES, Lahore, Pakistan",
                        imageUrl: "assets/images/persons/",
                        profileUrl: "https://www.linkedin.com/in/muhammad-ahmad-raza-phd-b0949310",
                        size: CardSize.small,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          const GlobalFooter(),
        ],
      ),
    );
  }

  // HELPER: Only uses IntrinsicHeight on Desktop to prevent empty space on Mobile
  Widget _buildAdaptiveCard({required bool isMobile, required double width, required Widget card}) {
    Widget scaled = SizedBox(
      width: width,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.topCenter,
        child: card,
      ),
    );

    if (isMobile) return scaled; // No IntrinsicHeight on mobile
    return IntrinsicHeight(child: scaled); // Keep it for desktop alignment
  }
}