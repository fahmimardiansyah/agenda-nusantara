import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import '../calendar/calendar_page.dart';
import '../home/home_page.dart';
import '../settings/settings_page.dart';
import '../task/add_task_page.dart';
import '../task/task_list_page.dart';
import '../../core/utils/app_page_transition.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  late final List<Widget> pages = [
    HomePage(onTabChange: changeTab),

    const TaskListPage(),

    const CalendarPage(),

    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: pages[selectedIndex],

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // FAB
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context, AppPageTransition(page: const AddTaskPage()));
        },

        child: Container(
          width: 68,
          height: 68,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,

              colors: [Color(0xFFB066FF), Color(0xFF7C3AED), Color(0xFF2563EB)],
            ),

            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.35),

                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),

          child: const Icon(Icons.add_rounded, color: Colors.white, size: 34),
        ),
      ),

      // NAVIGATION
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 20),

        padding: const EdgeInsets.symmetric(horizontal: 20),

        height: 74,

        decoration: BoxDecoration(
          color: AppColors.card,

          borderRadius: BorderRadius.circular(30),

          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            _buildNavItem(icon: Icons.home_rounded, index: 0),

            _buildNavItem(icon: Icons.list_alt_rounded, index: 1),

            const SizedBox(width: 40),

            _buildNavItem(icon: Icons.calendar_month_rounded, index: 2),

            _buildNavItem(icon: Icons.settings_rounded, index: 3),
          ],
        ),
      ),
    );
  }

  // NAV ITEM
  Widget _buildNavItem({required IconData icon, required int index}) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        changeTab(index);
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.15)
              : Colors.transparent,

          shape: BoxShape.circle,
        ),

        child: Icon(
          icon,

          size: 26,

          color: isSelected ? AppColors.primary : AppColors.grey,
        ),
      ),
    );
  }
}
