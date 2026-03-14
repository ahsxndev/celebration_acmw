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
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
            child: Column(
              children: [
                // MAIN PAGE HEADER
                const SectionHeader(
                  title: "Meet Our Speakers & Experts",
                  subtitle: "Learn from industry leaders, panel experts, and hands-on workshop instructors.",
                ),
                const SizedBox(height: 40),

                // --- 1. KEYNOTE SPEAKERS SECTION ---
                Text(
                  "Keynotes",
                  style: TextStyle(
                    fontSize: isMobile ? 22 : (isTablet ? 24 : 28),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: isMobile ? mobileSpacing : 40,
                  runSpacing: isMobile ? mobileSpacing : 40,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildScaledCard(
                      width: keynoteCardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. Kashif Shahzad",
                        role: "Board of Directors, PITC",
                        imageUrl: "assets/images/persons/kashif.png",
                        tagText: "Keynote Speaker",
                        tagColor: AppTheme.accentMagenta,
                        size: CardSize.large,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: isMobile ? 60 : 80),

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
                    _buildScaledCard(
                      width: cardWidth,
                      card: UniversalProfileCard(
                        name: "Dr. Sidra Zafar",
                        role: "Head of CS, Kinnaird College",
                        imageUrl: "assets/images/persons/sidra.jpeg",
                        tagText: "Workshop Lead",
                        tagColor: Colors.teal.shade600,
                      ),
                    ),
                    _buildScaledCard(
                      width: cardWidth,
                      card: UniversalProfileCard(
                        name: "Mr. Usman Nazir",
                        role: "Theta Solutions",
                        imageUrl: "assets/images/persons/usman.jpg",
                        tagText: "Workshop Lead",
                        tagColor: Colors.teal.shade600,
                      ),
                    ),
                    _buildScaledCard(
                      width: cardWidth,
                      card: UniversalProfileCard(
                        name: "Mr. Hamza",
                        role: "Technical Expert",
                        imageUrl: "assets/images/persons/hamza.png",
                        tagText: "Workshop Lead",
                        tagColor: Colors.teal.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 60 : 80),

                // --- 3. PANELISTS SECTION ---
                Text(
                  "Panelists",
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
                    _buildScaledCard(
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. M. Ahmad Raza",
                        role: "Asst. Professor, FAST NUCES",
                        imageUrl: "assets/images/persons/ahmad.jpeg",
                        tagText: "Panelist",
                        tagColor: AppTheme.primaryPurple,
                      ),
                    ),
                    _buildScaledCard(
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Mr. Muhammad Umer",
                        role: "Online Panelist",
                        imageUrl: "assets/images/persons/umer.jpeg",
                        tagText: "Panelist",
                        tagColor: AppTheme.primaryPurple,
                      ),
                    ),
                    _buildScaledCard(
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Ms. Shumaila Khaliq",
                        role: "Online Panelist",
                        imageUrl: "assets/images/persons/shumaila.jpeg",
                        tagText: "Panelist",
                        tagColor: AppTheme.primaryPurple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          // FOOTER
          const GlobalFooter(),
        ],
      ),
    );
  }

  Widget _buildScaledCard({required double width, required Widget card}) {
    return SizedBox(
      width: width,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.topCenter,
        child: card,
      ),
    );
  }
}