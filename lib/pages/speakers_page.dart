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
              vertical: isMobile ? 20 : 40,
            ),
            child: Column(
              children: [
                const SectionHeader(
                  title: "Meet Our Speakers & Experts",
                  subtitle: "Learn from industry leaders, panel experts, and hands-on workshop instructors.",
                ),
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
                    // KEYNOTE 2 - DR. SHAZIA WITH TWO TAGS
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: keynoteCardWidth,
                      card: const UniversalProfileCard(
                        name: "Prof. Dr. Shazia Bashir",
                        role: "Worthy Vice Chancellor, Government College Women University, Sialkot, Pakistan",
                        imageUrl: "assets/images/persons/shazia.jpeg",
                        profileUrl: "https://gcwus.edu.pk/message-of-vice-chancellor/",
                        topic: "From Bias to Breakthrough: Dismantling Barriers for Women in Computing",
                        // Primary Tag - NOW GREEN
                        tagText: "Distinguished Guest Speaker",
                        tagColor: Colors.teal, // Changed to a nice green!
                        // Secondary Tag
                        secondaryTagText: "Keynote Speaker",
                        secondaryTagColor: AppTheme.accentMagenta,
                        size: CardSize.large,
                      ),
                    ),
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

                    // KEYNOTE 2 - DR. SHAZIA WITH TWO TAGS

                  ],
                ),

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

                SizedBox(height: isMobile ? 30 : 80),

                // --- 3. PANELISTS SECTION ---
                Text(
                  "Panelists",
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    // Slightly smaller margins on mobile to give text more room
                    margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 32,
                      vertical: isMobile ? 20 : 28,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.lightLavender.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Thinner Vertical Bar for Mobile
                          Container(
                            width: isMobile ? 3 : 5,
                            decoration: BoxDecoration(
                              color: AppTheme.accentMagenta,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          // Tighter gap on mobile
                          SizedBox(width: isMobile ? 12 : 24),

                          // 2. Content Block
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "PANEL DISCUSSION",
                                  style: TextStyle(
                                    color: AppTheme.accentMagenta,
                                    fontSize: isMobile ? 8 : 12,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: isMobile ? 13 : 22,
                                      height: 1.4,
                                      color: AppTheme.primaryPurple,
                                      fontFamily: 'Montserrat',
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: "Women in Technology: ",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "Stories, Struggles & the Road to Diversity, Equity & Inclusion",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.textDark.withOpacity(0.8),
                                        ),
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
                ),
                const SizedBox(height: 32), // Space before speaker cards
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
                        role: "Asst. Professor, FAST NUCES, Lahore, Pakistan",
                        imageUrl: "assets/images/persons/ahmad.jpeg",
                        profileUrl: "https://www.linkedin.com/in/muhammad-ahmad-raza-phd-b0949310",
                        tagText: "Panelist",
                        tagColor: AppTheme.primaryPurple,
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
                        tagText: "Panelist",
                        tagColor: AppTheme.primaryPurple,
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
                        tagText: "Panelist",
                        tagColor: AppTheme.primaryPurple,
                        size: CardSize.small,
                      ),
                    ),
                    // PANELIST 4 - TO BE ANNOUNCED
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Rabia Arshad",
                        role: "System Analyst Designation, BISE Lahore",
                        imageUrl: "assets/images/persons/rabia.jpeg",
                        tagText: "Panelist",
                        tagColor: AppTheme.primaryPurple,
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

    if (isMobile) return scaled;
    return IntrinsicHeight(child: scaled);
  }
}