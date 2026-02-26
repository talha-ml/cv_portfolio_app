import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<void> generateCvPdf() async {
    final pdf = pw.Document();

    // Fonts & Styles define kar rahe hain
    final titleStyle = pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.teal);
    final sectionHeaderStyle = pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.teal);
    final bodyStyle = const pw.TextStyle(fontSize: 12);
    final subtitleStyle = pw.TextStyle(fontSize: 10, color: PdfColors.grey700);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return [
            // 1. HEADER (Name & Contact)
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text("Talha", style: titleStyle),
                  pw.Text("Flutter Developer & AI Enthusiast", style: pw.TextStyle(fontSize: 14, color: PdfColors.grey800)),
                  pw.SizedBox(height: 5),
                  pw.Text("talhakharabhullair119@gmail.com  |  +92 322 5304725", style: subtitleStyle),
                  pw.Text("github.com/talha-ml  |  linkedin.com/in/muhammad-talha", style: subtitleStyle),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 10),

            // 2. PROFESSIONAL SUMMARY
            _buildHeader("Professional Summary", sectionHeaderStyle),
            pw.Text(
              "Motivated technology enthusiast with strong experience in business and software development. "
                  "Skilled in Flutter, AI integration, and automation. Passionate about solving real-world problems using technology.",
              style: bodyStyle,
              textAlign: pw.TextAlign.justify,
            ),
            pw.SizedBox(height: 15),

            // 3. EXPERIENCE
            _buildHeader("Experience", sectionHeaderStyle),
            _buildExperienceItem("Flutter & AI App Developer", "2024 - Present", "Personal Projects",
                "Developed mobile apps with AI integration, chatbots, and automation systems."),
            _buildExperienceItem("Airbnb Business Operator", "2023 - Present", "Multan",
                "Managed bookings, pricing strategy, and customer relations."),
            _buildExperienceItem("Web & Data Automation", "2023 - Present", "Self Projects",
                "Web scraping, Google Sheets automation, and data-driven solutions."),
            pw.SizedBox(height: 15),

            // 4. SKILLS
            _buildHeader("Technical Skills", sectionHeaderStyle),
            pw.Bullet(text: "Mobile: Flutter, Dart, AI Integrated Apps"),
            pw.Bullet(text: "Web: HTML, CSS, JavaScript, MERN Stack"),
            pw.Bullet(text: "Data & AI: Python, Web Scraping, Selenium, AI Agents"),
            pw.Bullet(text: "Soft Skills: Leadership, Communication, Problem Solving"),
            pw.SizedBox(height: 15),

            // 5. PROJECTS
            _buildHeader("Key Projects", sectionHeaderStyle),
            _buildProjectItem("AI CV Portfolio App", "Flutter app with AI Chatbot and PDF generation."),
            _buildProjectItem("Chatbot Mobile App", "AI chatbot application with automation."),
            _buildProjectItem("Web Scraping System", "Automated data extraction using Python & Selenium."),
            pw.SizedBox(height: 15),

            // 6. EDUCATION
            _buildHeader("Education", sectionHeaderStyle),
            _buildExperienceItem("BS Computer Science", "2022 - Present", "COMSATS University", "Focus on AI and Mobile Dev."),
            _buildExperienceItem("FSc Pre-Medical", "2020 - 2022", "KIPS College", "Strong foundation in analytical thinking."),
          ];
        },
      ),
    );

    // Print/Share Dialog Open karega
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  // --- Helper Widgets for Cleaner Code ---

  static pw.Widget _buildHeader(String text, pw.TextStyle style) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(text.toUpperCase(), style: style),
        pw.Divider(color: PdfColors.teal, thickness: 1),
        pw.SizedBox(height: 6),
      ],
    );
  }

  static pw.Widget _buildExperienceItem(String title, String date, String company, String desc) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(date, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
            ],
          ),
          pw.Text(company, style: const pw.TextStyle(fontSize: 10, color: PdfColors.teal)),
          pw.Text(desc, style: const pw.TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  static pw.Widget _buildProjectItem(String title, String desc) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text("• ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.teal)),
          pw.Expanded(
            child: pw.RichText(
              text: pw.TextSpan(
                children: [
                  pw.TextSpan(text: "$title: ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.TextSpan(text: desc, style: const pw.TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}