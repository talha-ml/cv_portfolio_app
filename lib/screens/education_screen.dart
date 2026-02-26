import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          "Academic Background",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 15),

        // 1. University
        _EducationCard(
          degree: "BS Computer Science",
          institute: "COMSATS University Islamabad",
          year: "2022 – Present",
          description: "Major in Computer Science. Focusing on Mobile App Development (Flutter), Artificial Intelligence, and Modern Web Technologies.",
          icon: Icons.school_rounded,
        ),

        // 2. College
        _EducationCard(
          degree: "FSc Pre-Medical",
          institute: "KIPS College Multan",
          year: "2020 – 2022",
          description: "Studied Biology, Chemistry, and Physics. Developed a strong foundation in analytical thinking and scientific principles.",
          icon: Icons.science_rounded,
        ),

        const SizedBox(height: 80), // Bottom space
      ],
    );
  }
}

// ---------------------------------------------------------
// CUSTOM EDUCATION CARD WIDGET
// ---------------------------------------------------------

class _EducationCard extends StatelessWidget {
  final String degree;
  final String institute;
  final String year;
  final String description;
  final IconData icon;

  const _EducationCard({
    required this.degree,
    required this.institute,
    required this.year,
    required this.description,
    required this.icon,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.teal.withOpacity(0.2) : Colors.teal[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.teal, size: 30),
            ),
            const SizedBox(width: 15),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Degree Name
                  Text(
                    degree,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Institute Name
                  Text(
                    institute,
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Year Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      year,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}