import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../widgets/global_footer.dart';
import '../widgets/shared_components.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  Future<void> _launchRegistrationForm() async {
    final Uri url = Uri.parse('https://forms.gle/JGSNx1k6qg2APABa7');
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  // NOTE: Replace this with your actual Summer School link!
  Future<void> _launchSummerSchoolForm() async {
    final Uri url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLScuQrn8-nz0ZkYjgiVRvb3Y_oC7FnZ7ZpjeZD23eypSHm7RTg/viewform?usp=publish-editor');
    if (!await launchUrl(url)) {
      debugPrint('Could not launch summer school link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth <= 800;
    final double horizontalPadding = screenWidth > 800 ? 80 : (isTablet ? 40 : 20);

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
                const SectionHeader(
                  title: "Registration",
                  subtitle: "Secure your spot for the RCETCWIC 2026 Celebration.",
                ),
                const SizedBox(height: 30),

                // --- 1. REGISTRATION INFO BOX ---
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    padding: EdgeInsets.all(isMobile ? 24 : 40),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: isMobile ? 15 : 16,
                              height: 1.8,
                              color: AppTheme.textDark.withOpacity(0.85),
                            ),
                            children: const [
                              TextSpan(text: "Registration for "),
                              TextSpan(
                                text: "RCETCWIC 2026 ",
                                style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPurple),
                              ),
                              // FIX: Changed "will be open" to "is open"
                              TextSpan(
                                  text: "is open from "
                              ),
                              TextSpan(
                                text: "1st March to 10th April 2026. ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: "Early registration rates will be available for all participants, with discounted prices for those who register before the early deadline. Late registration fees will apply after "
                              ),
                              TextSpan(
                                text: "10th April.\n\n",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // FIX: Removed the word "daily"
                              TextSpan(
                                  text: "Registration fees include access to all scheduled sessions, hands-on workshops, keynote talks, coffee and lunch breaks, and networking events."
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),

                        SizedBox(height: isMobile? 25 :32),

                        ElevatedButton.icon(
                          onPressed: _launchRegistrationForm,
                          icon: const Icon(Icons.how_to_reg, color: Colors.white),
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
                            "Register Now",
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

                const SizedBox(height: 60),

                // --- 2. REGISTRATION FEES TABLE ---
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Registration Fees",
                          style: TextStyle(
                            fontSize: isMobile ? 22 : 26,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryPurple,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // FIX: Highly responsive table to prevent mobile overflow
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: LayoutBuilder(
                              builder: (context, constraints) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                                    child: DataTable(
                                      // Tighter spacing on mobile so it fits naturally
                                      horizontalMargin: isMobile ? 12 : 24,
                                      columnSpacing: isMobile ? 12 : 40,
                                      headingRowColor: WidgetStateProperty.resolveWith(
                                            (states) => AppTheme.lightLavender.withOpacity(0.3),
                                      ),
                                      dataRowMinHeight: isMobile ? 50 : 60,
                                      dataRowMaxHeight: isMobile ? 65 : 60,
                                      headingTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryPurple,
                                        fontSize: isMobile ? 13 : 15, // Smaller font for mobile header
                                      ),
                                      dataTextStyle: TextStyle(
                                        color: AppTheme.textDark.withOpacity(0.85),
                                        fontSize: isMobile ? 12 : 14, // Smaller font for mobile data
                                        fontWeight: FontWeight.w500,
                                      ),
                                      columns: [
                                        const DataColumn(label: Text('Person Type')),
                                        // Smart labels: Use \n to break text on mobile instead of taking up width
                                        DataColumn(label: Text(isMobile ? 'Early Bird\n(Before 10th)' : 'Early Bird (Before 10th April)')),
                                        DataColumn(label: Text(isMobile ? 'Late\n(After 10th)' : 'After 10th April')),
                                      ],
                                      rows: [
                                        const DataRow(cells: [
                                          DataCell(Text('Student')),
                                          DataCell(Text('2,000 PKR')),
                                          DataCell(Text('2,500 PKR')),
                                        ]),
                                        const DataRow(cells: [
                                          DataCell(Text('Professional')),
                                          DataCell(Text('4,000 PKR')),
                                          DataCell(Text('4,500 PKR')),
                                        ]),
                                        DataRow(cells: [
                                          // Smart labels: Shorten the long text on mobile
                                          DataCell(Text(isMobile ? 'Int. ACM Member' : 'International – ACM Member')),
                                          const DataCell(Text('100 USD')),
                                          const DataCell(Text('150 USD')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text(isMobile ? 'Int. Non-Member' : 'International – Non-ACM Member')),
                                          const DataCell(Text('150 USD')),
                                          const DataCell(Text('200 USD')),
                                        ]),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),

                         SizedBox(height: isMobile? 25 :40),

                        // --- 3. SUMMER SCHOOL BUNDLE DISCOUNT ---
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isMobile ? 24 : 32),
                          decoration: BoxDecoration(
                            color: AppTheme.accentMagenta.withOpacity(0.05), // Soft magenta tint
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.accentMagenta.withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.local_offer_rounded, color: AppTheme.accentMagenta, size: isMobile ? 24 : 28),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: Text(
                                      "Scholarship!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: isMobile ? 18 : 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryPurple,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Register for BOTH the ACM-W Celebrations and our upcoming Summer School to avail a massive 40% scholarship on your total registration fee!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isMobile ? 14 : 16,
                                  color: AppTheme.textDark.withOpacity(0.85),
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: _launchSummerSchoolForm,
                                icon: const Icon(Icons.school_rounded, color: Colors.white, size: 18),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryPurple,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 24 : 32,
                                    vertical: isMobile ? 12 : 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                label: Text(
                                  "Summer School Details",
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )                      ],
                    ),
                  ),
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
}