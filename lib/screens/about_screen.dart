import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.grey[300] : Colors.grey[700];

    return Scaffold(
      appBar: AppBar(
        title: const Text("About Me"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. INTRO HEADER (Quick Summary)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _HighlightChip(icon: Icons.code, label: "Developer"),
                _HighlightChip(icon: Icons.business_center, label: "Entrepreneur"),
                _HighlightChip(icon: Icons.lightbulb, label: "Problem Solver"),
              ],
            ),
            const SizedBox(height: 25),

            // 2. BIOGRAPHY CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.teal.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.teal),
                      const SizedBox(width: 10),
                      Text(
                        "Who am I?",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Text(
                    "I am a motivated and multi-skilled technology enthusiast with strong experience in both business and software development. "
                        "I have worked in online business (Perfume Brand & Airbnb Hosting) and I am now focusing on becoming a professional Flutter and AI-based application developer.\n\n"
                        "I have hands-on experience in mobile app development, web development, data scraping, and automation. "
                        "I enjoy solving real-world problems using technology and building useful products.\n\n"
                        "My background in business, leadership mindset, and communication skills allows me to work confidently with people and clients.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6, // Behtar reading ke liye
                      color: textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. CAREER OBJECTIVE CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF1E1E1E), const Color(0xFF252525)]
                      : [Colors.teal.shade50, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.teal.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.track_changes, color: Colors.redAccent),
                      const SizedBox(width: 10),
                      Text(
                        "Career Objective",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "To work as a professional Flutter Developer and AI-based Application Developer where I can use my technical skills, "
                        "business experience, and creativity to build impactful digital products.",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.tealAccent.withOpacity(0.8) : Colors.teal.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Signature / Ending
            Center(
              child: Text(
                "Let's Build Something Amazing.",
                style: TextStyle(
                  fontFamily: 'Cursive', // Agar font na ho to default use hoga
                  fontSize: 18,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Chip for Top Highlights
class _HighlightChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HighlightChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: isDark ? Colors.teal.withOpacity(0.2) : Colors.teal.shade50,
          child: Icon(icon, color: Colors.teal, size: 20),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.grey[400] : Colors.grey[700],
          ),
        ),
      ],
    );
  }
}