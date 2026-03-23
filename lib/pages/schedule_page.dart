import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../widgets/global_footer.dart';
import '../widgets/shared_components.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _tabController.animation?.value == _tabController.index) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // URL Launcher for clicking speaker names
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
    final bool isTablet = screenWidth >= 600 && screenWidth <= 800;
    final double horizontalPadding = screenWidth > 800
        ? 80
        : (isTablet ? 40 : 16); // Tighter padding for mobile

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 24 : 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- HEADER ---
                const SectionHeader(
                  title: "Event Schedule",
                  subtitle: "Two days of networking, learning, and empowerment.",
                ),
                SizedBox(height: isMobile ? 20 : 40),

                // --- PILL SHAPED TAB BAR ---
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.lightLavender.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppTheme.primaryPurple,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryPurple.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    labelColor: AppTheme.white,
                    unselectedLabelColor: AppTheme.primaryPurple.withOpacity(0.7),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 13 : 16, // Adjusted for mobile
                    ),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    tabs: const [
                      Tab(text: "Day 1 (April 29)"),
                      Tab(text: "Day 2 (April 30)"),
                    ],
                  ),
                ),

                SizedBox(height: isMobile ? 30 : 50),

                // --- TIMELINE CONTENT ---
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeIn,
                      child: _tabController.index == 0
                          ? _buildDay1()
                          : _buildDay2(),
                    ),
                  ),
                ),

                SizedBox(height: isMobile ? 30 : 60),
              ],
            ),
          ),
          const GlobalFooter(),
        ],
      ),
    );
  }

  // --- DAY 1 SCHEDULE ---
  Widget _buildDay1() {
    return Column(
      key: const ValueKey("Day1"),
      children: [
        _buildProTimelineCard(
          "08:00 - 08:30",
          "Registrations",
          EventType.general,
        ),
        _buildProTimelineCard(
          "09:00 - 09:30",
          "Opening Ceremony & Introduction to ACM-W",
          EventType.general,
        ),

        _buildProTimelineCard(
          "09:30 - 10:45",
          "Keynote Talk 1",
          EventType.keynote,
          topic: "From Bias to Breakthrough: Dismantling Barriers for Women in Computing",
          speakerName: "Prof. Dr. Shazia Bashir",
          speakerUrl: "https://gcwus.edu.pk/message-of-vice-chancellor/",

        ),
        _buildProTimelineCard(
          "10:45 - 11:15",
          "Tea / Coffee Break",
          EventType.breakTime,
        ),
        _buildProTimelineCard(
          "11:15 - 12:45",
          "Workshop 1",
          EventType.workshop,
          topic: "Cybersecurity Essentials: Protecting the Digital World",
          speakerName: "Mr. Usman Nazir",
          speakerUrl: "https://thetasolutions.pk/our-core-team/",
        ),
        _buildProTimelineCard(
          "12:45 - 01:45",
          "Lunch Break",
          EventType.breakTime,
        ),
        _buildProTimelineCard(
          "01:45 - 02:45",
          "Student Poster Competition Presentations",
          EventType.general,
        ),
        _buildProTimelineCard(
          "02:45 - 03:30",
          "EmpowerHer Defense: Practical Self-Defense Training",
          EventType.workshop,
        ),
        _buildProTimelineCard(
          "03:30 - 04:00",
          "Networking & Mentorship Session",
          EventType.networking,
        ),
        _buildProTimelineCard(
          "04:00 - 04:15",
          "Day-1 Wrap-Up & Announcements",
          EventType.general,
          isLast: true,
        ),
      ],
    );
  }

  // --- DAY 2 SCHEDULE ---
  Widget _buildDay2() {
    return Column(
      key: const ValueKey("Day2"),
      children: [
        _buildProTimelineCard(
          "09:00 - 09:30",
          "Welcome Back & Recap of Day 1",
          EventType.general,
        ),
        _buildProTimelineCard(
          "09:30 - 10:30",
          "Keynote Talk 2",
          EventType.keynote,
          topic: "She Leads the Future: Women Driving Innovation & Transformation in the Digital Age",
          speakerName: "Dr. Kashif Shahzad",
          speakerUrl: "https://www.pitc.com.pk/index.php/about/board-of-directors",
        ),
        _buildProTimelineCard(
          "10:30 - 11:00",
          "Tea / Coffee Break",
          EventType.breakTime,
        ),
        _buildProTimelineCard(
          "11:00 - 12:30",
          "Workshop 2",
          EventType.workshop,
          topic: "She Builds with AI: A Hands-On Workshop on Generative AI Applications",
          speakerName: "Dr. Sidra Zafar",
          speakerUrl: "https://www.linkedin.com/in/sidra-zafar",
        ),
        _buildProTimelineCard(
          "12:30 - 01:30",
          "Lunch Break",
          EventType.breakTime,
        ),
        _buildProTimelineCard(
          "01:30 - 02:30",
          "Panel Discussion",
          EventType.panel,
          topic: "Women in Technology: Stories, Struggles & the Road to Diversity, Equity & Inclusion"
        ),
        _buildProTimelineCard(
          "02:30 - 03:30",
          "ACM-W T-Shirt Design Contest",
          EventType.networking,
        ),
        _buildProTimelineCard(
          "03:30 - 04:15",
          "Closing Ceremony - Awards, Certificates & Appreciation",
          EventType.general,
        ),
        _buildProTimelineCard(
          "04:15 - 04:30",
          "Group Photo",
          EventType.general,
          isLast: true,
        ),
      ],
    );
  }

  // --- PRO TIMELINE CARD DESIGN (WITH SPEAKER INTEGRATION) ---
  Widget _buildProTimelineCard(
      String time,
      String title,
      EventType type, {
        bool isLast = false,
        String? topic,
        String? speakerName,
        String? speakerUrl,
      }) {
    // Styling based on event type
    Color primaryColor;
    Color bgColor;
    IconData icon;

    switch (type) {
      case EventType.keynote:
        primaryColor = AppTheme.accentMagenta;
        bgColor = AppTheme.accentMagenta.withOpacity(0.05);
        icon = Icons.star_rounded;
        break;
      case EventType.workshop:
        primaryColor = Colors.teal;
        bgColor = Colors.teal.withOpacity(0.05);
        icon = Icons.laptop_mac_rounded;
        break;
      case EventType.panel:
        primaryColor = Colors.indigo;
        bgColor = Colors.indigo.withOpacity(0.05);
        icon = Icons.people_alt_rounded;
        break;
      case EventType.breakTime:
        primaryColor = Colors.orange;
        bgColor = Colors.transparent;
        icon = Icons.coffee_rounded;
        break;
      case EventType.networking:
        primaryColor = Colors.pink;
        bgColor = Colors.pink.withOpacity(0.05);
        icon = Icons.handshake_rounded;
        break;
      case EventType.general:
      default:
        primaryColor = AppTheme.primaryPurple;
        bgColor = AppTheme.lightLavender.withOpacity(0.3);
        icon = Icons.event_note_rounded;
    }

    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Side: The Connecting Line
          // (Now visible on mobile but narrower to save space)
          SizedBox(
            width: isMobile ? 30 : 40,
            child: Column(
              children: [
                Container(
                  width: isMobile ? 12 : 16,
                  height: isMobile ? 12 : 16,
                  margin: EdgeInsets.only(top: isMobile ? 18 : 24),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: isMobile ? 2 : 3),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppTheme.lightLavender.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
          ),

          // Right Side: The Event Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 12 : 20), // Tighter vertical spacing
              child: Container(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                decoration: BoxDecoration(
                  color: type == EventType.breakTime ? Colors.grey.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
                  border: Border.all(
                    color: type == EventType.breakTime ? Colors.grey.shade200 : AppTheme.lightLavender.withOpacity(0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    if (type != EventType.breakTime)
                      BoxShadow(
                        color: AppTheme.primaryPurple.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // The Sleek Time Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: primaryColor.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, size: isMobile ? 14 : 16, color: primaryColor),
                          const SizedBox(width: 6),
                          Text(
                            time,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: isMobile ? 12 : 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // The Event Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isMobile ? 15 : 18,
                        fontWeight: type == EventType.breakTime ? FontWeight.w600 : FontWeight.bold,
                        color: type == EventType.breakTime ? Colors.grey.shade600 : AppTheme.primaryPurple,
                      ),
                    ),

                    // The Topic (If applicable)
                    if (topic != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        "Topic: $topic",
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 15,
                          fontStyle: FontStyle.italic,
                          color: AppTheme.textDark.withOpacity(0.8),
                          height: 1.4,
                        ),
                      ),
                    ],

                    // The Clickable Speaker Name (If applicable)
                    if (speakerName != null) ...[
                      const SizedBox(height: 12),
                      MouseRegion(
                        cursor: speakerUrl != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
                        child: GestureDetector(
                          onTap: speakerUrl != null ? () => _launchURL(speakerUrl) : null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                  Icons.person_rounded,
                                  size: isMobile ? 16 : 18,
                                  color: speakerUrl != null ? AppTheme.accentMagenta : Colors.grey.shade600
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  speakerName,
                                  style: TextStyle(
                                    fontSize: isMobile ? 13 : 15,
                                    fontWeight: FontWeight.w600,
                                    color: speakerUrl != null ? AppTheme.accentMagenta : Colors.grey.shade700,
                                    decoration: speakerUrl != null ? TextDecoration.underline : TextDecoration.none,
                                    decorationColor: AppTheme.accentMagenta.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              if (speakerUrl != null) ...[
                                const SizedBox(width: 4),
                                Icon(Icons.open_in_new_rounded, size: 12, color: AppTheme.accentMagenta.withOpacity(0.7)),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Enum to help color-code the cards easily
enum EventType { general, keynote, workshop, breakTime, panel, networking }