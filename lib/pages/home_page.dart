import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../widgets/animated_poster.dart';
import '../widgets/global_footer.dart';
import '../widgets/shared_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _sliderImages = [
    "assets/images/hero_2.jpeg",
    "assets/images/hero_3.jpeg",
    "assets/images/hero_4.jpeg",
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _sliderImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _launchRegistrationForm() async {
    final Uri url = Uri.parse('https://forms.gle/JGSNx1k6qg2APABa7');
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  Future<void> _launchCompetitionForm() async {
    final Uri url = Uri.parse('https://forms.gle/17PfPZ2yYiud3r2X9');
    if (!await launchUrl(url)) {
      debugPrint('Could not launch competition link');
    }
  }

  // Helper method to show the poster in a popup dialog
  void _showPosterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // The zoomed-in poster
              InteractiveViewer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/competition_poster.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Close Button
              Positioned(
                top: -15,
                right: -15,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: AppTheme.accentMagenta,
                  elevation: 5,
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
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
          // 1. HERO SECTION WITH SLIDER
          // ==========================================
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: isMobile ? 650 : (isTablet ? 650 : 700),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemCount: _sliderImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_sliderImages[index]),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
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
                ),
              ),
              Positioned.fill(
                child: Padding(
                  // FIX: Increased horizontal padding heavily on mobile (55) to prevent text from touching the arrows
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 55 : horizontalPadding),
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
                      Text(
                        "RCET Celebrations of Women in Computing (RCETCWIC):\nAn ACM Celebration",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : (isTablet ? 16 : 18),
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // FIX: Simple bold text as requested
                      Text(
                        "Rachna College of Engineering & Technology (RCET),\nGujranwala, Pakistan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                          fontWeight: FontWeight.bold, // Simple Bold
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 32),
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
                          "April 29-30, 2026",
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
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          // ==========================================
          // 2. EVENT INTRODUCTION (UPDATED CONTENT)
          // ==========================================
          Container(
            width: double.infinity,
            color: AppTheme.white,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SectionHeader(
                  title: "Welcome to RCETCWIC 2026",
                ),
                const SizedBox(height: 40),

                Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // LEFT SIDE: IMAGE
                    Expanded(
                      flex: isDesktop ? 4 : 0,
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: isMobile ? 300 : 400),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryPurple.withOpacity(0.1),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/about_2.jpeg",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    if (isDesktop) const SizedBox(width: 40) else const SizedBox(height: 40),

                    // RIGHT SIDE: UPDATED TEXT
                    Expanded(
                      flex: isDesktop ? 7 : 0,
                      child: Container(
                        padding: EdgeInsets.all(isMobile ? 24 : 40),
                        decoration: BoxDecoration(
                          color: AppTheme.lightLavender.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.primaryPurple.withOpacity(0.05)),
                        ),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: isMobile ? 15 : 16,
                              height: 1.8,
                              color: AppTheme.textDark.withOpacity(0.85),
                            ),
                            children: [
                              const TextSpan(text: "The "),
                              const TextSpan(
                                text: "RCET Celebration of Women in Computing (RCETCWIC 2026) ",
                                style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPurple),
                              ),
                              const TextSpan(
                                  text: "is a flagship event for women in computing, designed to provide an empowering and immersive experience for students, professionals, and tech enthusiasts in the ever-evolving field of computing.\n\n"
                              ),
                              const TextSpan(
                                  text: "The event will feature inspiring keynote talks, hands-on technical workshops, and interactive panel discussions, covering key areas such as "
                              ),
                              const TextSpan(
                                text: "Artificial Intelligence, Cybersecurity, Smart Energy Systems, and Women in Tech Leadership",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const TextSpan(
                                  text: ".\n\n"
                              ),
                              const TextSpan(
                                text: "RCETCWIC 2026 ",
                                style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPurple),
                              ),
                              const TextSpan(
                                  text: "will also offer opportunities to network with industry experts, collaborate with peers, and explore real-world applications of emerging technologies, enabling participants to innovate and lead while fostering diversity and inclusion in computing."
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ==========================================
          // 3. ABOUT SNIPPET SECTION (IMAGE SHRUNK)
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
                // TEXT SIDE (Increased flex for more prominence)
                Expanded(
                  flex: isDesktop ? 7 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Our Mission",
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

                if (isDesktop) const SizedBox(width: 60) else const SizedBox(height: 40),

                // IMAGE SIDE (Further shrunk for mobile/small screens)
                Expanded(
                  flex: isDesktop ? 3 : 0,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: isMobile ? 20 : 0), // Adds a gap when stacked on mobile
                      child: Container(
                        // Reduced maxWidth for mobile to 220 for a much smaller look
                        constraints: BoxConstraints(
                          maxWidth: isMobile ? 220 : 380,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            "assets/images/about_mission.png",
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==========================================
          // 4. FEATURED SPEAKERS
          // ==========================================
          Padding(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80),
            child: Column(
              children: [
                const SectionHeader(
                  title: "Featured Speakers",
                  subtitle: "Hear from industry leaders and tech pioneers.",
                ),
                SizedBox(height: isMobile ? 20 : 40),

                Column(
                  children: [
                    _buildAdaptiveCard(
                      isMobile: isMobile,
                      width: isMobile ? (screenWidth * 0.75) : 320,
                      card: const UniversalProfileCard(
                        name: "Prof. Dr. Shazia Bashir",
                        role: "Worthy Vice Chancellor, Government College Women University, Sialkot, Pakistan",
                        imageUrl: "assets/images/persons/shazia.jpeg",
                        profileUrl: "https://gcwus.edu.pk/message-of-vice-chancellor/",
                        tagText: "Distinguished Guest Speaker",
                        tagColor: Colors.teal,
                        secondaryTagText: "Keynote Speaker",
                        secondaryTagColor: AppTheme.accentMagenta,
                        size: CardSize.large,
                      ),
                    ),

                    SizedBox(height: isMobile ? 24 : 40),

                    Wrap(
                      spacing: isMobile ? mobileSpacing : 24,
                      runSpacing: isMobile ? 20 : 24,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildAdaptiveCard(
                          isMobile: isMobile,
                          width: speakerCardWidth,
                          card: const UniversalProfileCard(
                            name: "Dr. Kashif Shahzad",
                            role: "CEO, Power Information Technology Company (PITC), Lahore, Pakistan",
                            imageUrl: "assets/images/persons/kashif.png",
                            profileUrl: "https://www.pitc.com.pk/index.php/about/board-of-directors",
                            tagText: "Keynote Speaker",
                            tagColor: AppTheme.accentMagenta,
                            size: CardSize.small,
                          ),
                        ),
                        _buildAdaptiveCard(
                          isMobile: isMobile,
                          width: speakerCardWidth,
                          card: UniversalProfileCard(
                            name: "Dr. Sidra Zafar",
                            role: "Head of Computer Science, Kinnaird College, Lahore, Pakistan",
                            imageUrl: "assets/images/persons/sidra.jpeg",
                            profileUrl: "https://www.linkedin.com/in/sidra-zafar?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app",
                            tagText: "Workshop Lead",
                            tagColor: Colors.teal.shade600,
                            size: CardSize.small,
                          ),
                        ),
                        _buildAdaptiveCard(
                          isMobile: isMobile,
                          width: speakerCardWidth,
                          card: const UniversalProfileCard(
                            name: "Dr. M. Ahmad Raza",
                            role: "Asst. Professor, FAST NUCES, Lahore, Pakistan",
                            imageUrl: "assets/images/persons/ahmad.jpeg",
                            profileUrl: "https://www.linkedin.com/in/muhammad-ahmad-raza-phd-b0949310?utm_source=share_via&utm_content=profile&utm_medium=member_android",
                            tagText: "Panelist",
                            tagColor: AppTheme.primaryPurple,
                            size: CardSize.small,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 30 : 40),
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
          // 5. POSTER DESIGN COMPETITION
          // ==========================================
          Container(
            color: AppTheme.lightLavender.withOpacity(0.15),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 40 : 80,
            ),
            child: Column(
              children: [
                const SectionHeader(
                  title: "Poster Design Competition",
                  subtitle: "Showcase your creativity, win exciting prizes, and explore AI topics!",
                ),
                SizedBox(height: isMobile ? 30 : 60),

                Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // LEFT SIDE: TEXT AND BUTTON
                    Expanded(
                      flex: isDesktop ? 6 : 0,
                      child: Column(
                        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Are you ready to showcase your innovative ideas?",
                            textAlign: isMobile ? TextAlign.center : TextAlign.left,
                            style: TextStyle(
                              fontSize: isMobile ? 20 : 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryPurple,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Join the RCETCWIC 2026 Poster Design Competition! This is your chance to present your research, projects, and creative concepts in Artificial Intelligence, Cybersecurity, and Smart Energy.\n\nTop submissions will be recognized with exciting prizes and featured during the main celebration event. Don't miss this opportunity to stand out!",
                            textAlign: isMobile ? TextAlign.center : TextAlign.left,
                            style: TextStyle(
                              fontSize: isMobile ? 15 : 17,
                              height: 1.6,
                              color: AppTheme.textDark.withOpacity(0.85),
                            ),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            onPressed: _launchCompetitionForm,
                            icon: const Icon(Icons.app_registration, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.accentMagenta,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 32 : 40,
                                vertical: isMobile ? 16 : 20,
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            label: Text(
                              "Register & Submit",
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

                    if (isDesktop) const SizedBox(width: 60) else const SizedBox(height: 50),

                    // RIGHT SIDE: CLICKABLE POSTER
                    Expanded(
                      flex: isDesktop ? 5 : 0,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _showPosterPopup(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: isMobile ? 280 : 380,
                                    maxHeight: isMobile ? 400 : 550,
                                  ),
                                  child: const PulsingPoster(
                                    imagePath: "assets/images/competition_poster.png",
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryPurple.withOpacity(0.95),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.zoom_in_map_rounded, color: Colors.white, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          "Tap to Enlarge",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ==========================================
          // 6. EVENT TIMELINE TEASER
          // ==========================================
          Container(
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

  Widget _buildDayTeaserCard(
      BuildContext context, {
        required String title,
        required List<Widget> events,
      }) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

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
          const Spacer(), // Pushes the button to the bottom
          const SizedBox(height: 24),

          Align(
            alignment: Alignment.center,
            child: OutlinedButton(
              onPressed: () => context.go('/schedule'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.accentMagenta, width: 2),
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 32 : 40,
                    vertical: 16
                ),
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