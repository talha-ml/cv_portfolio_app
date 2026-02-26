import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  // URL Helper
  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          "Featured Projects",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 10),

        // 1. CV App
        _ProjectCard(
          title: "AI CV Portfolio App",
          description: "My personal portfolio converted into a mobile app with AI integration, dynamic themes, and PDF generation.",
          techStack: ["Flutter", "Dart", "Gemini AI", "PDF"],
          icon: Icons.person_pin_circle_rounded,
          onTap: () => _launchUrl("https://github.com/talha-ml"),
        ),

        // 2. Chatbot
        _ProjectCard(
          title: "AI Chatbot Mobile App",
          description: "An intelligent chatbot application capable of answering queries using automation and prompt engineering.",
          techStack: ["Flutter", "Rest API", "AI Agents"],
          icon: Icons.chat_bubble_rounded,
          onTap: () => _launchUrl("https://github.com/talha-ml"),
        ),

        // 3. Web Scraping
        _ProjectCard(
          title: "Web Scraping Automation",
          description: "Automated bot to extract data from complex websites and organize it into Google Sheets and Databases.",
          techStack: ["Python", "Selenium", "Google API", "Pandas"],
          icon: Icons.bug_report_rounded,
          onTap: () => _launchUrl("https://github.com/talha-ml"),
        ),

        // 4. Airbnb System
        _ProjectCard(
          title: "Airbnb Management System",
          description: "A business tool to manage bookings, automate guest communication, and track revenue.",
          techStack: ["Flutter", "Firebase", "Cloud Functions"],
          icon: Icons.house_rounded,
          onTap: () => _launchUrl("https://github.com/talha-ml"),
        ),

        // 5. E-Commerce
        _ProjectCard(
          title: "Perfume E-Commerce",
          description: "Full-stack e-commerce website for my perfume brand with Instagram integration.",
          techStack: ["HTML", "CSS", "JavaScript", "Bootstrap"],
          icon: Icons.shopping_bag_rounded,
          onTap: () => _launchUrl("https://github.com/talha-ml"),
        ),

        const SizedBox(height: 80), // Bottom space
      ],
    );
  }
}

// ---------------------------------------------------------
// CUSTOM PROJECT CARD WIDGET
// ---------------------------------------------------------

class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> techStack;
  final IconData icon;
  final VoidCallback onTap;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.techStack,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.teal, size: 28),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              description,
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[700],
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 15),

            // Tech Chips (Tags)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: techStack.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.teal.withOpacity(0.2) : Colors.teal[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.teal.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tech,
                    style: TextStyle(
                      color: isDark ? Colors.tealAccent : Colors.teal[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 15),

            // View Code Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.code, size: 18),
                label: const Text("View Code"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isDark ? Colors.white : Colors.black,
                  side: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}