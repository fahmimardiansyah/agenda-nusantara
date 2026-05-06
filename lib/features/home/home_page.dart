import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../../providers/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TodoProvider>().loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<TodoProvider>();

    final totalTask =
        provider.totalDone +
        provider.totalUndone;

    final progress =
        totalTask == 0
            ? 0.0
            : provider.totalDone / totalTask;

    final recentTasks =
        provider.todos.take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(
            AppSizes.lg,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // =========================
              // HEADER
              // =========================
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      const Text(
                        'Welcome Back 👋',

                        style: TextStyle(
                          color:
                              AppColors.grey,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      const Text(
                        'Agenda Nusantara',

                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: 52,
                    height: 52,

                    decoration: BoxDecoration(
                      color: AppColors.card,

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),

                    child: const Icon(
                      Icons
                          .notifications_none_rounded,

                      color: AppColors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: AppSizes.xxl,
              ),

              // =========================
              // HERO CARD
              // =========================
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(
                  AppSizes.xl,
                ),

                decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xFF8B5CF6),
                      Color(0xFF6D28D9),
                    ],

                    begin: Alignment
                        .topLeft,

                    end:
                        Alignment.bottomRight,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    32,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary
                          .withOpacity(0.35),

                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    const Text(
                      'Keep your productivity on track 🚀',

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: AppSizes.md,
                    ),

                    Text(
                      provider.totalUndone ==
                              0
                          ? 'All tasks completed today 🎉'
                          : '${provider.totalUndone} tasks are waiting for you today.',

                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(
                      height: AppSizes.xxl,
                    ),

                    // =========================
                    // FUTURISTIC PROGRESS
                    // =========================
                    Container(
                      width: double.infinity,

                      padding:
                          const EdgeInsets.all(
                        AppSizes.lg,
                      ),

                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                          26,
                        ),

                        gradient:
                            const LinearGradient(
                          colors: [
                            Color(0xFF2563EB),
                            Color(0xFF1D4ED8),
                          ],

                          begin:
                              Alignment.topLeft,

                          end:
                              Alignment.bottomRight,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF2563EB,
                            ).withOpacity(
                              0.45,
                            ),

                            blurRadius: 28,
                            spreadRadius: 2,
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons
                                    .bolt_rounded,

                                color:
                                    Colors.white70,
                                size: 18,
                              ),

                              const SizedBox(
                                width: 6,
                              ),

                              const Text(
                                'Productivity',

                                style: TextStyle(
                                  color: Colors
                                      .white70,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: AppSizes.lg,
                          ),

                          Text(
                            '${(progress * 100).toInt()}% • ${provider.totalUndone} tasks left',

                            style:
                                const TextStyle(
                              fontSize: 26,
                              fontWeight:
                                  FontWeight
                                      .bold,

                              color:
                                  Colors.white,
                            ),
                          ),

                          const SizedBox(
                            height: AppSizes.xl,
                          ),

                          // BAR CONTAINER
                          Container(
                            height: 80,

                            padding:
                                const EdgeInsets
                                    .all(8),

                            decoration:
                                BoxDecoration(
                              color: Colors.white
                                  .withOpacity(
                                0.15,
                              ),

                              borderRadius:
                                  BorderRadius.circular(
                                24,
                              ),
                            ),

                            child: Stack(
                              children: [
                                // PROGRESS
                                FractionallySizedBox(
                                  widthFactor:
                                      progress == 0
                                          ? 0.05
                                          : progress,

                                  child: Container(
                                    decoration:
                                        BoxDecoration(
                                      color: Colors
                                          .white,

                                      borderRadius:
                                          BorderRadius.circular(
                                        20,
                                      ),
                                    ),

                                    child: Align(
                                      alignment:
                                          Alignment
                                              .centerRight,

                                      child:
                                          Padding(
                                        padding:
                                            const EdgeInsets.only(
                                          right:
                                              20,
                                        ),

                                        child:
                                            Text(
                                          '${(progress * 100).toInt()}%',

                                          style:
                                              const TextStyle(
                                            color:
                                                Color(
                                              0xFF2563EB,
                                            ),

                                            fontWeight:
                                                FontWeight.bold,

                                            fontSize:
                                                18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: AppSizes.md,
                          ),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children: const [
                              Text(
                                '0',

                                style: TextStyle(
                                  color: Colors
                                      .white70,
                                ),
                              ),

                              Text(
                                '50',

                                style: TextStyle(
                                  color: Colors
                                      .white70,
                                ),
                              ),

                              Text(
                                '100',

                                style: TextStyle(
                                  color: Colors
                                      .white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: AppSizes.xxl,
              ),

              // =========================
              // OVERVIEW
              // =========================
              const Text(
                'Task Overview',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: AppSizes.lg,
              ),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Completed',

                      value: provider
                          .totalDone
                          .toString(),

                      icon:
                          Icons.check_circle,

                      color: AppColors
                          .success,
                    ),
                  ),

                  const SizedBox(
                    width: AppSizes.md,
                  ),

                  Expanded(
                    child: _buildStatCard(
                      title: 'Pending',

                      value: provider
                          .totalUndone
                          .toString(),

                      icon:
                          Icons.access_time,

                      color: AppColors
                          .secondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: AppSizes.md,
              ),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Important',

                      value: provider
                          .importantCount
                          .toString(),

                      icon:
                          Icons.priority_high,

                      color:
                          AppColors.danger,
                    ),
                  ),

                  const SizedBox(
                    width: AppSizes.md,
                  ),

                  Expanded(
                    child: _buildStatCard(
                      title: 'Regular',

                      value: provider
                          .regularCount
                          .toString(),

                      icon: Icons.task,

                      color: AppColors
                          .primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: AppSizes.xxl,
              ),

              // =========================
              // RECENT TASKS
              // =========================
              const Text(
                'Recent Tasks',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: AppSizes.lg,
              ),

              if (recentTasks.isEmpty)
                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    AppSizes.lg,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.card,

                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),
                  ),

                  child: const Text(
                    'No recent tasks available',

                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                ),

              ...recentTasks.map(
                (todo) {
                  final isImportant =
                      todo.category ==
                          'important';

                  return Container(
                    margin:
                        const EdgeInsets.only(
                      bottom: AppSizes.md,
                    ),

                    padding:
                        const EdgeInsets.all(
                      AppSizes.lg,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.card,

                      borderRadius:
                          BorderRadius.circular(
                        24,
                      ),
                    ),

                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,

                          decoration:
                              BoxDecoration(
                            color: isImportant
                                ? AppColors
                                    .danger
                                : AppColors
                                    .primary,

                            shape:
                                BoxShape.circle,
                          ),
                        ),

                        const SizedBox(
                          width: AppSizes.md,
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [
                              Text(
                                todo.title,

                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 4,
                              ),

                              Text(
                                todo.dueDate,

                                style:
                                    const TextStyle(
                                  color:
                                      AppColors
                                          .grey,

                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Icon(
                          todo.isDone == 1
                              ? Icons
                                  .check_circle
                              : Icons
                                  .hourglass_bottom_rounded,

                          color:
                              todo.isDone == 1
                                  ? AppColors
                                      .success
                                  : AppColors
                                      .secondary,
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // STAT CARD
  // =========================
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(
        AppSizes.lg,
      ),

      decoration: BoxDecoration(
        color: AppColors.card,

        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Container(
            padding: const EdgeInsets.all(
              AppSizes.sm,
            ),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),

              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(
            height: AppSizes.lg,
          ),

          Text(
            value,

            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: AppSizes.xs,
          ),

          Text(
            title,

            style: const TextStyle(
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}