import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../calendar/calendar_page.dart';
import '../home/home_page.dart';
import '../settings/settings_page.dart';
import '../task/add_task_page.dart';
import '../task/task_list_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() =>
      _MainNavigationPageState();
}

class _MainNavigationPageState
    extends State<MainNavigationPage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const TaskListPage(),
    const CalendarPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: pages[selectedIndex],

      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .centerDocked,

      // FAB
      floatingActionButton:
          GestureDetector(
        onTap: () {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder:
                  (_) => const AddTaskPage(),
            ),
          );
        },

        child: Container(
          width: 68,
          height: 68,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            gradient: const LinearGradient(
              colors: [
                Color(0xFF8B5CF6),
                Color(0xFF6D28D9),
              ],
            ),

            boxShadow: [
              BoxShadow(
                color:
                    AppColors.primary.withOpacity(
                  0.35,
                ),

                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),

          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 34,
          ),
        ),
      ),

      // NAVIGATION
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 20,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),

        height: 74,

        decoration: BoxDecoration(
          color: AppColors.card,

          borderRadius: BorderRadius.circular(
            30,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.2,
              ),

              blurRadius: 20,
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,

          children: [
            _buildNavItem(
              icon: Icons.home_rounded,
              index: 0,
            ),

            _buildNavItem(
              icon: Icons.list_alt_rounded,
              index: 1,
            ),

            const SizedBox(width: 40),

            _buildNavItem(
              icon:
                  Icons.calendar_month_rounded,
              index: 2,
            ),

            _buildNavItem(
              icon: Icons.settings_rounded,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  // NAV ITEM
  Widget _buildNavItem({
    required IconData icon,
    required int index,
  }) {
    final isSelected =
        selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),

        padding: const EdgeInsets.all(
          12,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(
                  0.15,
                )
              : Colors.transparent,

          shape: BoxShape.circle,
        ),

        child: Icon(
          icon,

          size: 26,

          color: isSelected
              ? AppColors.primary
              : AppColors.grey,
        ),
      ),
    );
  }
}