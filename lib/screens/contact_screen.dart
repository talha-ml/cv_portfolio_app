import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Clipboard ke liye
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$label copied to clipboard!"),
        backgroundColor: Colors.teal,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get in Touch"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Text
            Text(
              "Let's Connect",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Feel free to reach out for collaborations or just a friendly hello!",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 25),

            // 1. Phone
            _ContactTile(
              icon: Icons.call,
              title: "Phone",
              subtitle: "+92 322 5304725",
              color: Colors.green,
              onTap: () => _launchUrl("tel:+923225304725"),
              onLongPress: () => _copyToClipboard(context, "+923225304725", "Phone number"),
            ),

            // 2. Email
            _ContactTile(
              icon: Icons.email,
              title: "Email",
              subtitle: "talhakharabhullair119@gmail.com",
              color: Colors.redAccent,
              onTap: () => _launchUrl("mailto:talhakharabhullair119@gmail.com"),
              onLongPress: () => _copyToClipboard(context, "talhakharabhullair119@gmail.com", "Email"),
            ),

            // 3. LinkedIn
            _ContactTile(
              icon: Icons.work,
              title: "LinkedIn",
              subtitle: "linkedin.com/in/muhammad-talha",
              color: Colors.blue.shade700,
              onTap: () => _launchUrl("https://www.linkedin.com/in/muhammad-talha-2543522a6"),
            ),

            // 4. GitHub
            _ContactTile(
              icon: Icons.code,
              title: "GitHub",
              subtitle: "github.com/talha-ml",
              color: Colors.black, // Dark mode mein adjust hojayega
              onTap: () => _launchUrl("https://github.com/talha-ml/"),
            ),

            const SizedBox(height: 30),

            // Footer Message
            Center(
              child: Text(
                "Looking forward to hearing from you!",
                style: TextStyle(
                  color: Colors.teal.withOpacity(0.7),
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

// ---------------------------------------------------------
// CUSTOM CONTACT TILE WIDGET
// ---------------------------------------------------------

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // GitHub icon black dark mode mein nazar nahi aati, isliye white kar rahe hain
    final displayColor = (title == "GitHub" && isDark) ? Colors.white : color;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: displayColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: displayColor, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            fontSize: 13,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}