import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../../providers/todo_provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() =>
      _CalendarPageState();
}

class _CalendarPageState
    extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<TodoProvider>();

    final todos = provider.todos;

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
              // HEADER
              const Text(
                'Schedule 📅',

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: AppSizes.sm,
              ),

              const Text(
                'Track your upcoming tasks',

                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(
                height: AppSizes.xxl,
              ),

              // CALENDAR CARD
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(
                  AppSizes.xl,
                ),

                decoration: BoxDecoration(
                  color: AppColors.card,

                  borderRadius:
                      BorderRadius.circular(
                    32,
                  ),
                ),

                child: Column(
                  children: [
                    // MONTH
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [
                        const Text(
                          'May 2026',

                          style: TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Container(
                          padding:
                              const EdgeInsets.all(
                            10,
                          ),

                          decoration:
                              BoxDecoration(
                            color: AppColors
                                .primary
                                .withOpacity(
                                  0.15,
                                ),

                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),

                          child: const Icon(
                            Icons
                                .calendar_month_rounded,

                            color:
                                AppColors
                                    .primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: AppSizes.xxl,
                    ),

                    // DAYS
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [
                        _buildDay(
                          'MON',
                          '12',
                          false,
                        ),

                        _buildDay(
                          'TUE',
                          '13',
                          false,
                        ),

                        _buildDay(
                          'WED',
                          '14',
                          true,
                        ),

                        _buildDay(
                          'THU',
                          '15',
                          false,
                        ),

                        _buildDay(
                          'FRI',
                          '16',
                          false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: AppSizes.xxl,
              ),

              // UPCOMING
              const Text(
                'Upcoming Tasks',

                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: AppSizes.lg,
              ),

              todos.isEmpty
                  ? Container(
                      width: double.infinity,

                      padding:
                          const EdgeInsets.all(
                        AppSizes.xl,
                      ),

                      decoration: BoxDecoration(
                        color: AppColors.card,

                        borderRadius:
                            BorderRadius.circular(
                          24,
                        ),
                      ),

                      child: const Column(
                        children: [
                          Icon(
                            Icons.event_busy,
                            color:
                                AppColors.grey,
                            size: 50,
                          ),

                          SizedBox(height: 16),

                          Text(
                            'No schedule available',

                            style: TextStyle(
                              color:
                                  AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children:
                          todos.map((todo) {
                        final isImportant =
                            todo.category ==
                                'important';

                        return Container(
                          margin:
                              const EdgeInsets.only(
                            bottom:
                                AppSizes.md,
                          ),

                          padding:
                              const EdgeInsets.all(
                            AppSizes.lg,
                          ),

                          decoration:
                              BoxDecoration(
                            color:
                                AppColors.card,

                            borderRadius:
                                BorderRadius.circular(
                              24,
                            ),
                          ),

                          child: Row(
                            children: [
                              Container(
                                width: 14,
                                height: 60,

                                decoration:
                                    BoxDecoration(
                                  color: isImportant
                                      ? AppColors
                                          .danger
                                      : AppColors
                                          .primary,

                                  borderRadius:
                                      BorderRadius.circular(
                                    20,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width:
                                    AppSizes.md,
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
                                        fontSize:
                                            18,

                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 6,
                                    ),

                                    Text(
                                      todo
                                          .dueDate,

                                      style:
                                          const TextStyle(
                                        color:
                                            AppColors
                                                .grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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

  // DAY WIDGET
  Widget _buildDay(
    String day,
    String date,
    bool selected,
  ) {
    return Container(
      width: 56,
      height: 90,

      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary
            : AppColors.background,

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Text(
            day,

            style: TextStyle(
              color: selected
                  ? Colors.white70
                  : AppColors.grey,

              fontSize: 12,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            date,

            style: TextStyle(
              color: selected
                  ? Colors.white
                  : AppColors.white,

              fontSize: 22,

              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}