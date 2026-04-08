import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'home_screen.dart';
import 'saved_recipes_screen.dart';

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    const Scaffold(
      body: Center(child: Text("Calendar Screen/Placeholder")),
    ), // Placeholder
    const Scaffold(), // FAB slot Placeholder
    SavedRecipesScreen(),
    const Scaffold(
      body: Center(child: Text("Profile Screen/Placeholder")),
    ), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.document_scanner_outlined, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_filled, 0),
              _buildNavItem(Icons.calendar_today_outlined, 1),
              const SizedBox(width: 40), // Empty space for FAB
              _buildNavItem(Icons.bookmark_border, 3),
              _buildNavItem(Icons.person_outline, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _currentIndex == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
      ),
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
