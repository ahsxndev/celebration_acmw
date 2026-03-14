import 'package:flutter/material.dart';
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

    // Consistent responsive padding
    final double horizontalPadding = screenWidth > 800
        ? 80
        : (isTablet ? 40 : 20);
    final double mobileSpacing = 16;

    // Calculate exact width needed to fit 2 core committee cards per row on mobile
    final double cardWidth = isMobile
        ? (screenWidth - (horizontalPadding * 2) - mobileSpacing) / 2
        : 280; // Slightly larger for core members on desktop

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      // REMOVED PADDING FROM HERE so the footer can go full width!
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Content wrapped in padding
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 40,
            ),
            child: Column(
              children: [
                // MAIN PAGE HEADER
                const SectionHeader(
                  title: "The Team Behind the Celebration",
                  subtitle:
                  "Meet the dedicated individuals working hard to make ACM-W Celebrations (RCETWIC) 2026 a success.",
                ),
                const SizedBox(height: 40),

                // --- 1. CORE COMMITTEE SECTION ---
                Text(
                  "Organizers",
                  style: TextStyle(
                    fontSize: isMobile ? 28 : 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 24),

                // Using the scaling wrapper to force 2-in-a-row on mobile
                Wrap(
                  spacing: isMobile ? mobileSpacing : 32,
                  runSpacing: isMobile ? mobileSpacing : 32,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildScaledCard(
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. Natasha Nigar",
                        role: "Organizer",
                        imageUrl: "assets/images/persons/natasha.png",
                        tagText: "Core Lead",
                        tagColor: AppTheme.accentMagenta,
                      ),
                    ),
                    _buildScaledCard(
                      width: cardWidth,
                      card: const UniversalProfileCard(
                        name: "Mr. Shahid Islam",
                        role: "Organizer",
                        // Make sure you save his image as shahid.png in assets/images/persons/
                        imageUrl: "assets/images/persons/shahid.png",
                        tagText: "Core Lead",
                        tagColor: AppTheme.accentMagenta,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: isMobile ? 60 : 80), // Gap between sections
                // --- 2. ORGANIZING TEAM SECTION ---
                Text(
                  "Organizing Team",
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 32),

                // A dense grid of the smaller OrganizerAvatar widgets
                Wrap(
                  spacing: isMobile ? 16 : 40, // Tighter gap on mobile
                  runSpacing: isMobile ? 24 : 40,
                  alignment: WrapAlignment.center,
                  children: const [
                    OrganizerAvatar(
                      name: "Maria Rodriguez",
                      teamRole: "Marketing Lead",
                      imageUrl:
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=150&h=150",
                    ),
                    OrganizerAvatar(
                      name: "David Chen",
                      teamRole: "Logistics",
                      imageUrl:
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=150&h=150",
                    ),
                    OrganizerAvatar(
                      name: "Aisha Tariq",
                      teamRole: "Design Team",
                      imageUrl:
                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=150&h=150",
                    ),
                    OrganizerAvatar(
                      name: "John Smith",
                      teamRole: "Sponsorships",
                      imageUrl:
                      "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&q=80&w=150&h=150",
                    ),
                    OrganizerAvatar(
                      name: "Emily Davis",
                      teamRole: "Content Writer",
                      imageUrl:
                      "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=150&h=150",
                    ),
                    OrganizerAvatar(
                      name: "Michael Lee",
                      teamRole: "Web Developer",
                      imageUrl:
                      "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=150&h=150",
                    ),
                    OrganizerAvatar(
                      name: "Sophia Ali",
                      teamRole: "Social Media",
                      imageUrl:
                      "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&q=80&w=150&h=150",
                    ),
                    OrganizerAvatar(
                      name: "Omar Farooq",
                      teamRole: "Registration",
                      imageUrl:
                      "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80&w=150&h=150",
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),

          // The Global Footer attached to the absolute bottom perfectly
          const GlobalFooter(),
        ],
      ),
    );
  }

  // Helper widget to perfectly scale down the profile cards on mobile
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