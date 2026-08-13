import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/app_state.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/applications_screen.dart';
import 'screens/growth_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const JobInfoApp(),
    ),
  );
}

/// Root widget that wires app-wide theme and navigation shell.
class JobInfoApp extends StatelessWidget {
  const JobInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joblinfo',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const MainShell(),
    );
  }
}

/// Main bottom-navigation container for primary app sections.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    ExploreScreen(),
    ApplicationsScreen(),
    GrowthScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined), label: 'Applications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_outlined), label: 'Growth'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
