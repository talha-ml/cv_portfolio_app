import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // Add this package!

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Chat History Store karne ke liye List
  final List<Map<String, String>> _messages = [];

  bool isLoading = false;


  final String apiKey = "PASTE_YOUR_GEMINI_API_KEY_HERE";

  // Suggested Questions
  final List<String> _suggestions = [
    "Tell me about Talha's Skills",
    "Does he know Flutter?",
    "Show me his Projects",
    "What is his Education?",
  ];

  Future<void> askGemini(String question) async {
    if (question.trim().isEmpty) return;

    // 1. User ka message add karein
    setState(() {
      _messages.add({"role": "user", "text": question});
      isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      // 2. Model Initialize
      final model = GenerativeModel(
        model: 'gemini-3-flash-preview', // Ya 'gemini-2.0-flash'
        apiKey: apiKey,
      );

      // 3. Context Data (Prompt)
      final promptData = """
You are an AI Assistant for Talha's CV App.
Answer politely and professionally.
Only answer based on the following data.

DATA:
- Name: Talha (Flutter Developer, AI App Developer)
- Education: BS CS from COMSATS, FSC Pre-Medical from KIPS.
- Skills: Flutter, Dart, AI Agents, Python, MERN Stack, Web Scraping, Selenium.
- Projects: AI CV App, Chatbot Mobile App, Web Scraping System, Airbnb Business System.
- Experience: Flutter Freelancer, Airbnb Host, Perfume Business Owner.
- Contact: talhakharabhullair119@gmail.com, +92 322 5304725.

USER QUESTION: $question
""";

      final response = await model.generateContent([
        Content.text(promptData),
      ]);

      // 4. AI ka jawab add karein
      setState(() {
        _messages.add({
          "role": "ai",
          "text": response.text ?? "Sorry, I couldn't understand that."
        });
        isLoading = false;
      });
      _scrollToBottom();

    } catch (e) {
      setState(() {
        _messages.add({"role": "ai", "text": "Error: Internet or API issue."});
        isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.amber),
            const SizedBox(width: 10),
            const Text("AI Assistant"),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. Chat Area
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState(isDark) // Agar chat khali hai
                : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return _buildChatBubble(msg['text']!, isUser, isDark);
              },
            ),
          ),

          // 2. Loading Indicator
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(minHeight: 2, color: Colors.teal),
            ),

          // 3. Input Area
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      hintText: "Ask about Talha...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onSubmitted: askGemini,
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.teal,
                  child: const Icon(Icons.send, color: Colors.white),
                  onPressed: () => askGemini(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS ---

  // Jab koi message na ho tab kya dikhana hai
  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 60, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              "Ask me anything regarding Talha!",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: _suggestions.map((suggestion) {
                return ActionChip(
                  label: Text(suggestion),
                  backgroundColor: isDark ? Colors.teal.withOpacity(0.2) : Colors.teal[50],
                  labelStyle: TextStyle(color: Colors.teal),
                  onPressed: () => askGemini(suggestion),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  // Chat Bubble Design (User vs AI)
  Widget _buildChatBubble(String text, bool isUser, bool isDark) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 300), // Max width control
        decoration: BoxDecoration(
          color: isUser
              ? Colors.teal
              : (isDark ? const Color(0xFF2C2C2C) : Colors.grey[300]),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isUser ? const Radius.circular(15) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(15),
          ),
        ),
        child: isUser
            ? Text(
          text,
          style: const TextStyle(color: Colors.white),
        )
            : MarkdownBody( // ✅ Markdown for AI Response
          data: text,
          styleSheet: MarkdownStyleSheet(
            p: TextStyle(color: isDark ? Colors.white : Colors.black87),
            strong: const TextStyle(fontWeight: FontWeight.bold, color: Colors.tealAccent),
          ),
        ),
      ),
    );
  }
}