import 'package:flutter/material.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          "Professional Journey",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 15),

        // 1. Flutter Dev
        _ExperienceCard(
          title: "Flutter & AI App Developer",
          company: "Personal & Freelance Projects",
          duration: "2024 - Present",
          description: "Developing intelligent mobile applications using Flutter & AI models. Building portfolio apps, CV apps, and automation systems.",
          icon: Icons.developer_mode,
          color: Colors.blueAccent,
        ),

        // 2. Airbnb
        _ExperienceCard(
          title: "Airbnb Business Operator",
          company: "Multan Operations",
          duration: "2023 - Present",
          description: "Managing property business including bookings, guest communication, pricing strategy, and quality assurance.",
          icon: Icons.bedroom_parent_rounded, // House icon
          color: Colors.redAccent,
        ),

        // 3. Perfume Business
        _ExperienceCard(
          title: "Perfume Business Owner",
          company: "E-Commerce (Instagram/Web)",
          duration: "2022 - Present",
          description: "Running an online fragrance brand. Handling digital marketing, branding, sales funnel, and customer relations.",
          icon: Icons.storefront_rounded, // Shop icon
          color: Colors.purpleAccent,
        ),

        // 4. Automation Dev
        _ExperienceCard(
          title: "Web & Data Automation",
          company: "Self Projects",
          duration: "2023 - Present",
          description: "Creating bots for web scraping, Google Sheets automation, and data-driven business solutions.",
          icon: Icons.auto_graph_rounded, // Data icon
          color: Colors.teal,
        ),

        const SizedBox(height: 80), // Bottom space for Navbar
      ],
    );
  }
}

// ---------------------------------------------------------
// CUSTOM EXPERIENCE CARD WIDGET
// ---------------------------------------------------------

class _ExperienceCard extends StatelessWidget {
  final String title;
  final String company;
  final String duration;
  final String description;
  final IconData icon;
  final Color color;

  const _ExperienceCard({
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Timeline Indicator
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              // Line connecting to next item (visual only)
              Container(
                width: 2,
                height: 100, // Fixed height or LayoutBuilder for dynamic
                color: isDark ? Colors.grey[800] : Colors.grey[300],
              ),
            ],
          ),
          const SizedBox(width: 15),

          // Right Side: Content Card
          Expanded(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Duration Chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        duration,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Title
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    // Company
                    Text(
                      company,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
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