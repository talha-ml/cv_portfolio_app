import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FullOnePageCV extends StatelessWidget {
  const FullOnePageCV({super.key});

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sectionColor = Colors.teal;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      // AppBar hata diya taake main screen par clean lage
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// --- 1. HEADER (Photo + Name + Contact) ---
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/profile.png"),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Talha",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Flutter Developer & AI Enthusiast",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Contact Row
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 15,
                    children: [
                      _contactIcon(Icons.email, "mailto:talhakharabhullair119@gmail.com"),
                      _contactIcon(Icons.phone, "tel:+923225304725"),
                      _contactIcon(Icons.code, "https://github.com/talha-ml/"),
                      _contactIcon(Icons.work, "https://www.linkedin.com/in/muhammad-talha-2543522a6"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            /// --- 2. ABOUT ME ---
            _sectionHeader("About Me", sectionColor),
            const Text(
              "I am a motivated technology enthusiast with strong experience in business and software development. "
                  "I have hands-on experience in mobile app development, web development, and AI automation. "
                  "My goal is to build impactful digital products using Flutter and Artificial Intelligence.",
              style: TextStyle(height: 1.5, fontSize: 14),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 25),

            /// --- 3. SKILLS (Chips Style) ---
            _sectionHeader("Technical Skills", sectionColor),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _skillChip("Flutter", isDark),
                _skillChip("Dart", isDark),
                _skillChip("AI Agents", isDark),
                _skillChip("Python", isDark),
                _skillChip("Web Scraping", isDark),
                _skillChip("MERN Stack", isDark),
                _skillChip("Firebase", isDark),
                _skillChip("Git/GitHub", isDark),
              ],
            ),

            const SizedBox(height: 25),

            /// --- 4. EXPERIENCE (Timeline Style) ---
            _sectionHeader("Experience", sectionColor),
            _experienceItem(
              "Flutter & AI App Developer",
              "Personal Projects | 2024 - Present",
              "Building AI-integrated mobile apps and automation systems.",
              cardColor,
            ),
            _experienceItem(
              "Airbnb Business Operator",
              "Multan | 2023 - Present",
              "Managing bookings, pricing strategy, and guest relations.",
              cardColor,
            ),
            _experienceItem(
              "Web Automation Developer",
              "Self Projects | 2023 - Present",
              "Developed bots for scraping and Google Sheets automation.",
              cardColor,
            ),

            const SizedBox(height: 25),

            /// --- 5. PROJECTS ---
            _sectionHeader("Featured Projects", sectionColor),
            _projectItem("AI CV App", "Flutter app with Gemini AI & PDF export.", cardColor),
            _projectItem("Chatbot Mobile App", "Smart chatbot using AI Agents.", cardColor),
            _projectItem("Web Scraping Bot", "Python Selenium bot for data extraction.", cardColor),

            const SizedBox(height: 25),

            /// --- 6. EDUCATION ---
            _sectionHeader("Education", sectionColor),
            _educationItem("BS Computer Science", "COMSATS University | 2022 - Present"),
            _educationItem("FSc Pre-Medical", "KIPS College | 2020 - 2022"),

            const SizedBox(height: 50),

            Center(
              child: Text(
                "End of Resume",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _sectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(width: 4, height: 20, color: color),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactIcon(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, color: Colors.grey),
      onPressed: () => _launchUrl(url),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget _skillChip(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.teal.withOpacity(0.2) : Colors.teal[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.teal.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.tealAccent : Colors.teal[800],
        ),
      ),
    );
  }

  Widget _experienceItem(String role, String meta, String desc, Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(role, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 2),
          Text(meta, style: const TextStyle(fontSize: 12, color: Colors.teal)),
          const SizedBox(height: 5),
          Text(desc, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _projectItem(String title, String desc, Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.code, size: 18, color: Colors.teal),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _educationItem(String degree, String uni) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.school, size: 18, color: Colors.teal),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(degree, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(uni, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}