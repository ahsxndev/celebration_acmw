import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/global_footer.dart';
import '../widgets/shared_components.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 800;
    final bool isTablet = screenWidth >= 600 && screenWidth <= 800;
    final bool isMobile = screenWidth < 600;

    final double horizontalPadding = isDesktop ? 80 : (isTablet ? 40 : 20);
    final double mobileSpacing = 16;
    final double mobileCardWidth =
        (screenWidth - (horizontalPadding * 2) - mobileSpacing) / 2;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SectionHeader(title: "About ACM-W RCET"),
                const SizedBox(height: 20),

                // --- 1. OUR MISSION SECTION ---
                Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: isDesktop
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: isDesktop ? 1 : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Our Mission",
                            style: TextStyle(
                              fontSize: isMobile ? 22 : (isTablet ? 24 : 28),
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryPurple,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "RCET UET ACM-W Student Chapter supports, celebrates, and advocates internationally for the full engagement of women in all aspects of the computing field. We aim to provide a wide range of programs and services to ACM members and work in the larger community to advance the contributions of technical women.",
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              height: 1.6,
                              color: AppTheme.textDark.withOpacity(0.8),
                            ),
                          ),

                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: _isExpanded
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(
                                        "Through the ACM-W RCET Chapter, we are creating a localized, empowering environment where students can network, learn from industry experts, and build the confidence to lead the future of technology.",
                                        style: TextStyle(
                                          fontSize: isMobile ? 14 : 16,
                                          height: 1.6,
                                          color: AppTheme.textDark.withOpacity(
                                            0.8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),

                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.accentMagenta,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                            ),
                            child: Text(
                              _isExpanded ? "Show Less" : "Show More",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isDesktop)
                      const SizedBox(width: 60)
                    else
                      const SizedBox(height: 40),

                    Expanded(
                      flex: isDesktop ? 1 : 0,
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: AppTheme.lightLavender,
                          borderRadius: BorderRadius.circular(24),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/about_mission.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 80),

                // --- 2. OUR HISTORY TIMELINE (FIXED ALIGNMENT) ---
                Text(
                  "Our History",
                  style: TextStyle(
                    fontSize: isMobile ? 22 : (isTablet ? 24 : 28),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "The journey of empowering women in tech.",
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: AppTheme.textDark.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // PERFECT ALIGNMENT LOGIC
                if (isDesktop)
                  // Desktop: Forces all cards in the row to be the exact same height
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _buildHistoryNode(
                            "2025",
                            "Chapter Founded",
                            "ACM-W RCET Student Chapter was officially established.",
                            isMobile,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildHistoryNode(
                            "2025",
                            "Launching Ceremony",
                            "Hosted the grand Launching ceremony for all student females with over 100 participants.",
                            isMobile,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildHistoryNode(
                            "2026",
                            "Celebration",
                            "Hosting our largest 2-day tech celebration event yet!",
                            isMobile,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  // Mobile: Stacks them vertically at 100% width so they don't look awkwardly wrapped
                  Column(
                    children: [
                      _buildHistoryNode(
                        "2025",
                        "Chapter Founded",
                        "ACM-W RCET Student Chapter was officially established.",
                        isMobile,
                        fullWidth: true,
                      ),
                      const SizedBox(height: 16),
                      _buildHistoryNode(
                        "2025",
                        "Launching Ceremony",
                        "Hosted the grand Launching ceremony for all student females with over 100 participants.",
                        isMobile,
                        fullWidth: true,
                      ),
                      const SizedBox(height: 16),
                      _buildHistoryNode(
                        "2026",
                        "Celebration",
                        "Hosting our largest 2-day tech celebration event yet!",
                        isMobile,
                        fullWidth: true,
                      ),
                    ],
                  ),

                const SizedBox(height: 80),

                // --- 3. WHY ATTEND SECTION ---
                Text(
                  "Why Attend",
                  style: TextStyle(
                    fontSize: isMobile ? 22 : (isTablet ? 24 : 28),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                const SizedBox(height: 40),

                Wrap(
                  spacing: isMobile ? mobileSpacing : 24,
                  runSpacing: isMobile ? 16 : 24,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildWhyAttendCard(
                      icon: Icons.people_alt_outlined,
                      title: "Networking",
                      description:
                          "Connect with like-minded peers and industry professionals.",
                      isMobile: isMobile,
                      mobileCardWidth: mobileCardWidth,
                    ),
                    _buildWhyAttendCard(
                      icon: Icons.lightbulb_outline,
                      title: "Learning",
                      description:
                          "Gain hands-on experience through technical workshops.",
                      isMobile: isMobile,
                      mobileCardWidth: mobileCardWidth,
                    ),
                    _buildWhyAttendCard(
                      icon: Icons.rocket_launch_outlined,
                      title: "Empowerment",
                      description:
                          "Build confidence and join a community that supports your growth.",
                      isMobile: isMobile,
                      mobileCardWidth: mobileCardWidth,
                    ),
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

  // UPDATED HISTORY NODE
  Widget _buildHistoryNode(
    String year,
    String title,
    String description,
    bool isMobile, {
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth
          ? double.infinity
          : null, // Takes full width on mobile, fills Expanded on desktop
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.lightLavender, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPurple.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            year,
            style: TextStyle(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.w900,
              color: AppTheme.accentMagenta,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryPurple,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 14 : 15,
              height: 1.5,
              color: AppTheme.textDark.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyAttendCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
    required double mobileCardWidth,
  }) {
    return Container(
      width: isMobile ? mobileCardWidth : 280,
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPurple.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            decoration: const BoxDecoration(
              color: AppTheme.lightLavender,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: isMobile ? 24 : 36,
              color: AppTheme.primaryPurple,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 20),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryPurple,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              height: 1.4,
              color: AppTheme.textDark.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
