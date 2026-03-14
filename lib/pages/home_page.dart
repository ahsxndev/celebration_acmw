import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../widgets/global_footer.dart';
import '../widgets/shared_components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _launchRegistrationForm() async {
    final Uri url = Uri.parse('https://forms.gle/JGSNx1k6qg2APABa7');
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 800;
    final bool isTablet = screenWidth >= 600 && screenWidth <= 800;
    final bool isMobile = screenWidth < 600;

    final double horizontalPadding = isDesktop ? 80 : (isTablet ? 40 : 20);
    final double mobileSpacing = 16;
    final double speakerCardWidth = isMobile
        ? (screenWidth - (horizontalPadding * 2) - mobileSpacing) / 2
        : 250;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ==========================================
          // 1. HERO SECTION (Perfectly Centered!)
          // ==========================================
          Container(
            width: double.infinity,
            height: isMobile ? 550 : (isTablet ? 600 : 650),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/women_tech.png"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.primaryPurple.withOpacity(0.3),
                    AppTheme.primaryPurple.withOpacity(0.85),
                    AppTheme.primaryPurple,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: 80,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "ACM-W Celebrations",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 32 : (isTablet ? 44 : 56),
                        fontWeight: FontWeight.w900,
                        color: AppTheme.white,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // UPDATED TITLE from document
                    Text(
                      "RCET Celebrations of Women in Computing (RCETWIC):\nAn ACM Celebration",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 13 : (isTablet ? 16 : 18),
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // UPDATED DATES
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 32,
                        vertical: isMobile ? 12 : 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        "April 29-30",
                        style: TextStyle(
                          color: AppTheme.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 16 : 24,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: _launchRegistrationForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentMagenta,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 32 : 48,
                          vertical: isMobile ? 16 : 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Join the Celebration",
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ==========================================
          // 2. ABOUT SNIPPET SECTION
          // ==========================================
          Container(
            color: AppTheme.primaryPurple,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 80,
            ),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About\nOur Mission",
                        style: TextStyle(
                          fontSize: isMobile ? 24 : (isTablet ? 30 : 36),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "ACM-W supports, celebrates, and advocates internationally for the full engagement of women in all aspects of the computing field. Join us for two days of inspiration, networking, and growth.",
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: AppTheme.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 24),
                      OutlinedButton(
                        onPressed: () => context.go('/about'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: AppTheme.accentMagenta,
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                        child: const Text(
                          "Read Full Mission",
                          style: TextStyle(
                            color: AppTheme.accentMagenta,
                            fontWeight: FontWeight.bold,
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
                    height: 250,
                    decoration: BoxDecoration(
                      color: AppTheme.lightLavender,
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/about_mission.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==========================================
          // 3. FEATURED SPEAKERS (UPDATED TO ACTUAL SPEAKERS)
          // ==========================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 80,
            ),
            decoration: BoxDecoration(
              color: AppTheme.lightLavender.withOpacity(0.5),
            ),
            child: Column(
              children: [
                const SectionHeader(
                  title: "Featured Speakers",
                  subtitle: "Hear from industry leaders and tech pioneers.",
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: isMobile ? mobileSpacing : 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildScaledCard(
                      width: speakerCardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. Kashif Shahzad",
                        role: "Board of Directors, PITC",
                        imageUrl: "assets/images/persons/kashif.png",
                        tagText: "Keynote",
                        tagColor: AppTheme.accentMagenta,
                      ),
                    ),
                    _buildScaledCard(
                      width: speakerCardWidth,
                      card: UniversalProfileCard(
                        name: "Dr. Sidra Zafar",
                        role: "Head of CS, Kinnaird College",
                        imageUrl: "assets/images/persons/sidra.jpeg",
                        tagText: "Workshop",
                        tagColor: Colors.teal.shade600,
                      ),
                    ),
                    _buildScaledCard(
                      width: speakerCardWidth,
                      card: const UniversalProfileCard(
                        name: "Dr. M. Ahmad Raza",
                        role: "Asst. Professor, FAST",
                        imageUrl: "assets/images/persons/ahmad.jpeg",
                        tagText: "Panelist",
                        tagColor: AppTheme.primaryPurple,
                      ),
                    ),
                    _buildScaledCard(
                      width: speakerCardWidth,
                      card: UniversalProfileCard(
                        name: "Mr. Usman Nazir",
                        role: "Theta Solutions",
                        imageUrl: "assets/images/persons/usman.jpg",
                        tagText: "Workshop",
                        tagColor: Colors.teal.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => context.go('/speakers'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryPurple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    "View All Speakers",
                    style: TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==========================================
          // 4. EVENT TIMELINE TEASER
          // ==========================================
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 0 : horizontalPadding,
              vertical: 80,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 0),
                  child: const SectionHeader(
                    title: "Event Timeline",
                    subtitle: "ACM-W RCET Celebration: Empowering the Future",
                  ),
                ),
                const SizedBox(height: 40),

                if (isMobile)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.85,
                            child: _buildDayTeaserCard(
                              context,
                              title: "Day 1 (April 29)",
                              events: [
                                _buildMiniTimelineItem(
                                  "09:00 AM",
                                  "Opening Ceremony",
                                  AppTheme.accentMagenta,
                                ),
                                _buildMiniTimelineItem(
                                  "09:30 AM",
                                  "Keynote Talk 1",
                                  AppTheme.primaryPurple,
                                ),
                                _buildMiniTimelineItem(
                                  "11:15 AM",
                                  "Hands-on Workshop",
                                  Colors.teal,
                                  isLast: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: screenWidth * 0.85,
                            child: _buildDayTeaserCard(
                              context,
                              title: "Day 2 (April 30)",
                              events: [
                                _buildMiniTimelineItem(
                                  "09:30 AM",
                                  "Keynote Talk 2",
                                  AppTheme.accentMagenta,
                                ),
                                _buildMiniTimelineItem(
                                  "11:00 AM",
                                  "Hands-on Workshop 2",
                                  Colors.teal,
                                ),
                                _buildMiniTimelineItem(
                                  "01:30 PM",
                                  "Panel Discussion",
                                  AppTheme.primaryPurple,
                                  isLast: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _buildDayTeaserCard(
                            context,
                            title: "Day 1 (April 29)",
                            events: [
                              _buildMiniTimelineItem(
                                "09:00 AM",
                                "Opening Ceremony",
                                AppTheme.accentMagenta,
                              ),
                              _buildMiniTimelineItem(
                                "09:30 AM",
                                "Keynote Talk 1",
                                AppTheme.primaryPurple,
                              ),
                              _buildMiniTimelineItem(
                                "11:15 AM",
                                "Hands-on Workshop 1",
                                Colors.teal,
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: _buildDayTeaserCard(
                            context,
                            title: "Day 2 (April 30)",
                            events: [
                              _buildMiniTimelineItem(
                                "09:30 AM",
                                "Keynote Talk 2",
                                AppTheme.accentMagenta,
                              ),
                              _buildMiniTimelineItem(
                                "11:00 AM",
                                "Hands-on Workshop 2",
                                Colors.teal,
                              ),
                              _buildMiniTimelineItem(
                                "01:30 PM",
                                "Panel Discussion",
                                AppTheme.primaryPurple,
                                isLast: true,
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

          const SizedBox(height: 60),
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

  Widget _buildDayTeaserCard(
      BuildContext context, {
        required String title,
        required List<Widget> events,
      }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.lightLavender, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPurple.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryPurple,
            ),
          ),
          const SizedBox(height: 24),
          ...events,
          const Spacer(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go('/schedule'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.accentMagenta, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Explore Schedule",
                style: TextStyle(
                  color: AppTheme.accentMagenta,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniTimelineItem(
      String time,
      String title,
      Color dotColor, {
        bool isLast = false,
      }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryPurple,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: AppTheme.lightLavender),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                title,
                style: TextStyle(
                  color: AppTheme.textDark.withOpacity(0.8),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}