import 'package:flutter/material.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Text
          Text(
            "Technical Proficiency",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),

          // 📱 Mobile & App Development
          _SkillCategoryCard(
            title: "Mobile & App Development",
            icon: Icons.smartphone,
            skills: [
              _SkillRow(title: "Flutter & Dart", percentage: 0.85),
              _SkillRow(title: "AI Integrated Apps", percentage: 0.70),
              _SkillRow(title: "Chatbots & Agents", percentage: 0.70),
            ],
          ),

          // 🌐 Web Development
          _SkillCategoryCard(
            title: "Web Development",
            icon: Icons.language,
            skills: [
              _SkillRow(title: "HTML / CSS", percentage: 0.80),
              _SkillRow(title: "JavaScript", percentage: 0.70),
              _SkillRow(title: "MERN Stack", percentage: 0.60),
            ],
          ),

          // 🤖 AI & Data
          _SkillCategoryCard(
            title: "AI & Data Science",
            icon: Icons.psychology,
            skills: [
              _SkillRow(title: "Python (Web Scraping)", percentage: 0.75),
              _SkillRow(title: "Google Sheets Auto.", percentage: 0.70),
              _SkillRow(title: "Machine Learning (CNN)", percentage: 0.60),
            ],
          ),

          const SizedBox(height: 20),

          // Header Text 2
          Text(
            "Core Competencies",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),

          // 🧠 Soft Skills & CS
          _SkillCategoryCard(
            title: "Computer Science & Soft Skills",
            icon: Icons.school,
            skills: [
              _SkillRow(title: "Database Systems", percentage: 0.75),
              _SkillRow(title: "Problem Solving", percentage: 0.90),
              _SkillRow(title: "Leadership", percentage: 0.80),
              _SkillRow(title: "Communication", percentage: 0.85),
            ],
          ),

          const SizedBox(height: 80), // Bottom navigation bar ke liye jagah
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// CUSTOM WIDGETS (Code ko saaf rakhne ke liye)
// ---------------------------------------------------------

class _SkillCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> skills;

  const _SkillCategoryCard({
    required this.title,
    required this.icon,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.teal),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            ...skills,
          ],
        ),
      ),
    );
  }
}

class _SkillRow extends StatelessWidget {
  final String title;
  final double percentage;

  const _SkillRow({required this.title, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "${(percentage * 100).toInt()}%",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Animated Progress Bar
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            builder: (context, value, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}