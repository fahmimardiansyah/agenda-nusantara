import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../../providers/todo_provider.dart';
import '../../core/widgets/app_press_animation.dart';
import '../task/add_task_page.dart';

class HomePage extends StatefulWidget {
  final Function(int) onTabChange;
  const HomePage({super.key, required this.onTabChange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentCardIndex = 0;

  Timer? autoSlideTimer;

  @override
  void initState() {
    super.initState();

    autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;

      setState(() {
        currentCardIndex = currentCardIndex == 0 ? 1 : 0;
      });
    });

    Future.microtask(() {
      context.read<TodoProvider>().loadTodos();
    });
  }

  @override
  void dispose() {
    autoSlideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();

    final totalTask = provider.totalDone + provider.totalUndone;

    final progress = totalTask == 0 ? 0.0 : provider.totalDone / totalTask;

    final recentTasks = provider.todos.take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.lg),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        'Welcome Back 👋',

                        style: TextStyle(color: AppColors.grey, fontSize: 14),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        'Agenda Nusantara',

                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: 52,
                    height: 52,

                    decoration: BoxDecoration(
                      color: AppColors.card,

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: const Icon(
                      Icons.notifications_none_rounded,

                      color: AppColors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.xxl),

              // AUTO SLIDE HERO
              SizedBox(
                height: 400,

                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),

                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },

                  child: currentCardIndex == 0
                      ? _buildProgressCard(provider, progress)
                      : _buildChartCard(),
                ),
              ),
              const SizedBox(height: AppSizes.xxl),

              // =========================
              // QUICK FEATURES
              // =========================
              const Text(
                'Quick Features',

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: AppSizes.lg),

              Row(
                children: [
                  // IMPORTANT
                  Expanded(
                    child: _buildFeatureCard(
                      icon: Icons.priority_high_rounded,

                      title: 'Important',

                      color: AppColors.danger,

                      onTap: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                const AddTaskPage(initialCategory: 'important'),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: AppSizes.md),

                  // REGULAR
                  Expanded(
                    child: _buildFeatureCard(
                      icon: Icons.task_alt_rounded,

                      title: 'Regular',

                      color: AppColors.primary,

                      onTap: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                const AddTaskPage(initialCategory: 'regular'),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: AppSizes.md),

                  // TASK LIST
                  Expanded(
                    child: _buildFeatureCard(
                      icon: Icons.list_alt_rounded,

                      title: 'Task',

                      color: AppColors.secondary,

                      onTap: () {
                        widget.onTabChange(1);
                      },
                    ),
                  ),

                  const SizedBox(width: AppSizes.md),

                  // SETTINGS
                  Expanded(
                    child: _buildFeatureCard(
                      icon: Icons.settings_rounded,

                      title: 'Settings',

                      color: AppColors.warning,

                      onTap: () {
                        widget.onTabChange(3);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.xxl),

              // TASK OVERVIEW
              const Text(
                'Task Overview',

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: AppSizes.lg),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Completed',

                      value: provider.totalDone.toString(),

                      icon: Icons.check_circle,

                      color: AppColors.success,
                    ),
                  ),

                  const SizedBox(width: AppSizes.md),

                  Expanded(
                    child: _buildStatCard(
                      title: 'Pending',

                      value: provider.totalUndone.toString(),

                      icon: Icons.access_time,

                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.md),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Important',

                      value: provider.importantCount.toString(),

                      icon: Icons.priority_high,

                      color: AppColors.danger,
                    ),
                  ),

                  const SizedBox(width: AppSizes.md),

                  Expanded(
                    child: _buildStatCard(
                      title: 'Regular',

                      value: provider.regularCount.toString(),

                      icon: Icons.task,

                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.xxl),

              // RECENT TASKS
              const Text(
                'Recent Tasks',

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: AppSizes.lg),

              if (recentTasks.isEmpty)
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(AppSizes.lg),

                  decoration: BoxDecoration(
                    color: AppColors.card,

                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: const Text(
                    'No recent tasks available',

                    style: TextStyle(color: AppColors.grey),
                  ),
                ),

              ...recentTasks.map((todo) {
                final isImportant = todo.category == 'important';

                return Container(
                  margin: const EdgeInsets.only(bottom: AppSizes.md),

                  padding: const EdgeInsets.all(AppSizes.lg),

                  decoration: BoxDecoration(
                    color: AppColors.card,

                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,

                        decoration: BoxDecoration(
                          color: isImportant
                              ? AppColors.danger
                              : AppColors.primary,

                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: AppSizes.md),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              todo.title,

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              todo.dueDate,

                              style: const TextStyle(
                                color: AppColors.grey,

                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Icon(
                        todo.isDone == 1
                            ? Icons.check_circle
                            : Icons.hourglass_bottom_rounded,

                        color: todo.isDone == 1
                            ? AppColors.success
                            : AppColors.warning,
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  // PROGRESS CARD
  Widget _buildProgressCard(TodoProvider provider, double progress) {
    return Container(
      key: const ValueKey('progress'),

      width: double.infinity,

      padding: const EdgeInsets.all(AppSizes.xl),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [Color(0xFFB066FF), Color(0xFF7C3AED), Color(0xFF2563EB)],
        ),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.45),

            blurRadius: 35,
            spreadRadius: 2,
          ),
        ],

        borderRadius: BorderRadius.circular(32),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Keep your productivity on track 🚀',

            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: AppSizes.md),

          Text(
            '${(progress * 100).toInt()}% completed today',

            style: const TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: AppSizes.xxl),

          Container(
            height: 80,

            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),

              borderRadius: BorderRadius.circular(24),
            ),

            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: progress == 0 ? 0.05 : progress,

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Align(
                      alignment: Alignment.centerRight,

                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),

                        child: Text(
                          '${(progress * 100).toInt()}%',

                          style: const TextStyle(
                            color: Color(0xFF2563EB),

                            fontWeight: FontWeight.bold,

                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.xl),

          Row(
            children: [
              Expanded(
                child: _buildMiniInsight(
                  title: 'Completed',
                  value: provider.totalDone.toString(),
                  color: AppColors.success,
                ),
              ),

              const SizedBox(width: AppSizes.md),

              Expanded(
                child: _buildMiniInsight(
                  title: 'Pending',
                  value: provider.totalUndone.toString(),
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // CHART CARD
  Widget _buildChartCard() {
    return Container(
      key: const ValueKey('chart'),

      width: double.infinity,

      padding: const EdgeInsets.all(AppSizes.xl),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF1F2937)],
        ),

        borderRadius: BorderRadius.circular(32),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Tasks Completed Per Day',

            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: AppSizes.sm),

          const Text(
            'Weekly productivity analytics',

            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: AppSizes.xxl),

          SizedBox(
            height: 220,

            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),

                borderData: FlBorderData(show: false),

                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,

                      reservedSize: 32,

                      getTitlesWidget: (value, meta) {
                        final titles = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ];

                        return Padding(
                          padding: const EdgeInsets.only(top: 12),

                          child: Text(
                            titles[value.toInt()],

                            style: const TextStyle(
                              color: Colors.white70,

                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                minX: 0,
                maxX: 6,

                minY: 0,
                maxY: 10,

                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,

                    color: AppColors.primary,

                    barWidth: 5,

                    dotData: const FlDotData(show: false),

                    belowBarData: BarAreaData(
                      show: true,

                      color: AppColors.primary.withOpacity(0.2),
                    ),

                    spots: const [
                      FlSpot(0, 2),
                      FlSpot(1, 4),
                      FlSpot(2, 3),
                      FlSpot(3, 7),
                      FlSpot(4, 5),
                      FlSpot(5, 8),
                      FlSpot(6, 6),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // STAT CARD
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),

      decoration: BoxDecoration(
        color: AppColors.card,

        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.sm),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: color),
          ),

          const SizedBox(height: AppSizes.lg),

          Text(
            value,

            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: AppSizes.xs),

          Text(title, style: const TextStyle(color: AppColors.grey)),
        ],
      ),
    );
  }

  // MINI INSIGHT
  Widget _buildMiniInsight({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),

        borderRadius: BorderRadius.circular(25),
      ),

      child: Column(
        children: [
          Text(
            value,

            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,

            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // QUICK FEATURE CARD
  // QUICK FEATURE CARD
  // QUICK FEATURE CARD
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AppPressAnimation(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.lg),

        decoration: BoxDecoration(
          color: AppColors.card,

          borderRadius: BorderRadius.circular(22),

          border: Border.all(color: Colors.white.withOpacity(0.05)),

          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),

              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.sm),

              decoration: BoxDecoration(
                color: color.withOpacity(0.15),

                borderRadius: BorderRadius.circular(14),

                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),

                    blurRadius: 18,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Icon(icon, color: Colors.white, size: 22),
            ),

            const SizedBox(height: AppSizes.sm),

            Text(
              title,

              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
