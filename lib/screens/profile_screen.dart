import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pdf_service.dart';
import 'ai_screen.dart';
import 'full_one_page_cv.dart'; // ✅ IMPORT ZAROORI HAI

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // URL Launcher Helper
  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Theme data for dynamic styling
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1. HEADER SECTION (Photo + Name)
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Background Gradient Container
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [Colors.teal.shade900, const Color(0xFF121212)]
                          : [Colors.teal, Colors.teal.shade200],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),

                // Profile Image
                const Positioned(
                  bottom: -60,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white, // Border effect
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 70), // Image ke liye space

            /// 2. NAME & TITLE
            Text(
              "Talha",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Flutter Developer & AI Enthusiast",
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.teal,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            /// 3. SOCIAL LINKS (Modern Row)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialButton(
                    icon: Icons.code,
                    color: Colors.black,
                    onTap: () => _launchUrl("https://github.com/talha-ml/")
                ),
                _SocialButton(
                    icon: Icons.work,
                    color: Colors.blue.shade700,
                    onTap: () => _launchUrl("https://www.linkedin.com/in/muhammad-talha-2543522a6")
                ),
                _SocialButton(
                    icon: Icons.email,
                    color: Colors.redAccent,
                    onTap: () => _launchUrl("mailto:talhakharabhullair119@gmail.com")
                ),
                _SocialButton(
                    icon: Icons.call,
                    color: Colors.green,
                    onTap: () => _launchUrl("tel:+923225304725")
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// 4. AI ASSISTANT CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.teal.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.amber.shade400),
                        const SizedBox(width: 10),
                        Text(
                          "Ask My AI Assistant",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Want to know more? Chat with my AI to ask about my projects, skills, and experience instantly.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AiScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: const Text("Start Chat"),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// 5. ACTION BUTTONS (Download & View Full)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // Button 1: Download PDF
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        PdfService.generateCvPdf();
                      },
                      icon: const Icon(Icons.download_rounded),
                      label: const Text("Download Resume (PDF)"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(color: isDark ? Colors.grey : Colors.black),
                        foregroundColor: isDark ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15), // Gap

                  // Button 2: View Full Resume (NEW) 🔥
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FullOnePageCV()),
                        );
                      },
                      icon: const Icon(Icons.visibility),
                      label: const Text("View Full Resume"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// Custom Widget for Social Buttons
class _SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5), width: 1.5),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
      ),
    );
  }
}