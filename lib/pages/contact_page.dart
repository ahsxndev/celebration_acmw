import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http; // REQUIRED FOR EMAILJS
import '../core/theme.dart';
import '../widgets/shared_components.dart';
import '../widgets/global_footer.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // Form Key for Validation
  final _formKey = GlobalKey<FormState>();

  // Text Controllers to capture input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // ==========================================
  // EMAILJS INTEGRATION LOGIC (FIXED)
  // ==========================================
  Future<void> _sendEmail() async {
    // 1. Validate Form
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // 2. EmailJS REST API URL
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          // FIXED: Removed the 'origin' header. Browsers block manual origin headers!
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': 'service_mmandoc',
          'template_id': 'template_5h73f7g',
          'user_id': 'ErI33GQefPpcF0Ncx',
          'template_params': {
            'user_name': _nameController.text,
            'user_email': _emailController.text,
            'user_subject': _subjectController.text,
            'user_message': _messageController.text,
          },
        }),
      );

      if (response.statusCode == 200) {
        // Success: Clear form and show success message
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Message sent successfully!'),
                ],
              ),
              backgroundColor: Colors.green.shade600,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        // Log the actual response from EmailJS so we know why it failed
        debugPrint('EmailJS Error: ${response.body}');
        throw Exception('Failed to send email.');
      }
    } catch (e) {
      debugPrint('HTTP Post Error: $e'); // Logs the exact error to your console
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Failed to send message. Please try again later.',
            ),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 800;
    final bool isMobile = screenWidth < 600;

    final bool isTablet = screenWidth >= 600 && screenWidth <= 800;
    final double horizontalPadding = isDesktop
        ? 80
        : (isTablet ? 40 : (screenWidth < 350 ? 12 : 20));
    const LatLng rcetLocation = LatLng(32.3610958, 74.207957);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 30 : 40,
            ),
            child: Column(
              children: [
                const SectionHeader(
                  title: "Get in Touch",
                  subtitle:
                      "ACM Women RCET Celebration. Empowering the Future.",
                ),
                SizedBox(height: isMobile ? 24 : 40),

                Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT SIDE: Contact Form
                    Expanded(
                      flex: isDesktop ? 1 : 0,
                      child: Form(
                        key: _formKey, // Attach Form Key
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(
                              label: "Name",
                              hint: "John Doe",
                              isMobile: isMobile,
                              controller: _nameController,
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Please enter your name'
                                  : null,
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            _buildTextField(
                              label: "Email",
                              hint: "example@email.com",
                              isMobile: isMobile,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.isEmpty)
                                  return 'Please enter your email';
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(val))
                                  return 'Enter a valid email';
                                return null;
                              },
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            _buildTextField(
                              label: "Subject",
                              hint: "General Inquiry",
                              isMobile: isMobile,
                              controller: _subjectController,
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Please enter a subject'
                                  : null,
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            _buildTextField(
                              label: "Message",
                              hint: "Type your message here...",
                              isMobile: isMobile,
                              controller: _messageController,
                              maxLines: isMobile ? 4 : 5,
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Please enter your message'
                                  : null,
                            ),
                            SizedBox(height: isMobile ? 20 : 24),

                            SizedBox(
                              width: isMobile ? double.infinity : null,
                              height: isMobile
                                  ? 50
                                  : 56, // Fixed height prevents jumping when loading
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _sendEmail,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.accentMagenta,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 24 : 40,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Text(
                                        "Submit",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: isMobile ? 14 : 16,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (isDesktop)
                      const SizedBox(width: 80)
                    else
                      SizedBox(height: isMobile ? 40 : 60),

                    // RIGHT SIDE: Info & FREE OPENSTREETMAP
                    Expanded(
                      flex: isDesktop ? 1 : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact us",
                            style: TextStyle(
                              fontSize: isMobile ? 20 : 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryPurple,
                            ),
                          ),
                          SizedBox(height: isMobile ? 16 : 24),
                          _buildContactInfoRow(
                            Icons.email_outlined,
                            "Email",
                            "acmwrcetchapter@gmail.com",
                            isMobile,
                          ),
                          SizedBox(height: isMobile ? 12 : 16),
                          _buildContactInfoRow(
                            Icons.phone_outlined,
                            "Phone",
                            "+92 309 7072739",
                            isMobile,
                          ),
                          SizedBox(height: isMobile ? 24 : 40),

                          Container(
                            height: isMobile ? 200 : 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppTheme.lightLavender,
                                width: 3,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Stack(
                                children: [
                                  IgnorePointer(
                                    child: FlutterMap(
                                      options: const MapOptions(
                                        initialCenter: rcetLocation,
                                        initialZoom: 15.0,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName: 'com.acmw.rcet',
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              point: rcetLocation,
                                              width: 40,
                                              height: 40,
                                              child: const Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final url = Uri.parse(
                                          'https://www.google.com/maps/search/?api=1&query=32.3610958,74.207957',
                                        );
                                        if (!await launchUrl(
                                          url,
                                          mode: LaunchMode.externalApplication,
                                        )) {
                                          debugPrint('Could not launch maps');
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Maps ",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Icon(
                                              Icons.open_in_new,
                                              size: 12,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const GlobalFooter(),
        ],
      ),
    );
  }

  // UPDATED: Now takes controller and validator
  Widget _buildTextField({
    required String label,
    required String hint,
    required bool isMobile,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryPurple,
            fontSize: isMobile ? 13 : 14,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(fontSize: isMobile ? 14 : 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: isMobile ? 13 : 14,
            ),
            filled: true,
            fillColor: AppTheme.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 20,
              vertical: isMobile ? 14 : 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppTheme.lightLavender,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppTheme.accentMagenta,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red.shade400, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red.shade600, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoRow(
    IconData icon,
    String title,
    String detail,
    bool isMobile,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 10 : 12),
          decoration: const BoxDecoration(
            color: AppTheme.lightLavender,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryPurple,
            size: isMobile ? 20 : 24,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: isMobile ? 11 : 12,
              ),
            ),
            Text(
              detail,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
                fontSize: isMobile ? 14 : 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
