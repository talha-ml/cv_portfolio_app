import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/skills_screen.dart';
import 'screens/experience_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/education_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // By default Dark Mode on rakha hai (Developers ke liye cool lagta hai)
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talha Portfolio',

      // --- LIGHT THEME SETTINGS ---
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
        ),
      ),

      // --- DARK THEME SETTINGS (Yehi use hoga mostly) ---
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Colors.tealAccent,
        scaffoldBackgroundColor: const Color(0xFF121212), // Deep Dark Grey
        cardColor: const Color(0xFF1E1E1E), // Slightly Lighter for Cards
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: Colors.tealAccent,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),

      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home: HomeScreen(
        isDark: isDark,
        onToggle: () {
          setState(() {
            isDark = !isDark;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const HomeScreen({super.key, required this.isDark, required this.onToggle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  // Tabs ki list (Yahan Education Screen bhi add kar sakte hain agar jagah ho)
  final List<Widget> screens = const [
    ProfileScreen(),      // 0: Home/Profile
    SkillsScreen(),       // 1: Skills
    ExperienceScreen(),   // 2: Experience
    ProjectsScreen(),     // 3: Projects
    EducationScreen(),    // 4: Education (Optional: Agar Bottom bar mein 5 items fit hojayein)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar: Sirf Theme Toggle ke liye rakha hai
      appBar: AppBar(
        title: const Text("Talha's Portfolio"),
        centerTitle: false, // Title left side par professional lagta hai
        actions: [
          IconButton(
            tooltip: "Toggle Theme",
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => RotationTransition(turns: anim, child: child),
              child: Icon(
                widget.isDark ? Icons.light_mode : Icons.dark_mode,
                key: ValueKey(widget.isDark),
              ),
            ),
            onPressed: widget.onToggle,
          ),
          const SizedBox(width: 10),
        ],
      ),

      // IndexedStack state ko maintain rakhta hai (Scroll position lost nahi hoti)
      body: IndexedStack(
        index: currentIndex,
        children: screens.length > 4 ? screens : screens.sublist(0, 4), // Safety check
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed, // 4 se zyada items ke liye zaroori hai
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart),
              label: "Skills",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              activeIcon: Icon(Icons.work),
              label: "Exp.",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.code),
              activeIcon: Icon(Icons.terminal),
              label: "Projects",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined),
              activeIcon: Icon(Icons.school),
              label: "Edu.",
            ),
          ],
        ),
      ),
    );
  }
}