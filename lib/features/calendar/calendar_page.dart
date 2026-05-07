import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

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
  DateTime focusedDay = DateTime.now();

  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<TodoProvider>();

    final filteredTasks =
        provider.todos.where((todo) {
      return todo.dueDate ==
          _formatDate(selectedDay);
    }).toList();

    return Scaffold(
            appBar: AppBar(
        title: const Text('Calendar'),
      ),
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
              const Text(
                'Schedule Calendar',

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: AppSizes.sm,
              ),

              const Text(
                'Manage your upcoming tasks',

                style: TextStyle(
                  color: AppColors.grey,
                ),
              ),

              const SizedBox(
                height: AppSizes.xxl,
              ),

              // =========================
              // CALENDAR
              // =========================
              Container(
                padding: const EdgeInsets.all(
                  AppSizes.lg,
                ),

                decoration: BoxDecoration(
                  color: AppColors.card,

                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),

                child: TableCalendar(
                  focusedDay: focusedDay,

                  firstDay:
                      DateTime(2020),

                  lastDay:
                      DateTime(2035),

                  selectedDayPredicate:
                      (day) {
                    return isSameDay(
                      selectedDay,
                      day,
                    );
                  },

                  onDaySelected:
                      (selected, focused) {
                    setState(() {
                      selectedDay =
                          selected;

                      focusedDay =
                          focused;
                    });
                  },

                  calendarStyle:
                      CalendarStyle(
                    todayDecoration:
                        BoxDecoration(
                      color: AppColors
                          .primary
                          .withOpacity(0.4),

                      shape:
                          BoxShape.circle,
                    ),

                    selectedDecoration:
                        const BoxDecoration(
                      color:
                          AppColors.primary,

                      shape:
                          BoxShape.circle,
                    ),

                    defaultTextStyle:
                        const TextStyle(
                      color:
                          AppColors.white,
                    ),

                    weekendTextStyle:
                        const TextStyle(
                      color:
                          AppColors.white,
                    ),

                    outsideTextStyle:
                        TextStyle(
                      color: AppColors
                          .grey
                          .withOpacity(0.5),
                    ),
                  ),

                  headerStyle:
                      const HeaderStyle(
                    formatButtonVisible:
                        false,

                    titleTextStyle:
                        TextStyle(
                      color:
                          AppColors.white,

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,
                    ),

                    leftChevronIcon:
                        Icon(
                      Icons
                          .chevron_left_rounded,
                      color:
                          AppColors.white,
                    ),

                    rightChevronIcon:
                        Icon(
                      Icons
                          .chevron_right_rounded,
                      color:
                          AppColors.white,
                    ),
                  ),

                  daysOfWeekStyle:
                      const DaysOfWeekStyle(
                    weekdayStyle:
                        TextStyle(
                      color:
                          AppColors.grey,
                    ),

                    weekendStyle:
                        TextStyle(
                      color:
                          AppColors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: AppSizes.xxl,
              ),

              // =========================
              // TASK SECTION
              // =========================
              Text(
                'Tasks on ${_formatDate(selectedDay)}',

                style: const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: AppSizes.lg,
              ),

              // EMPTY
              if (filteredTasks.isEmpty)
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
                    'No tasks on this date',

                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                ),

              // TASK LIST
              ...filteredTasks.map(
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
                                todo.description,

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
  // FORMAT DATE
  // =========================
  String _formatDate(
    DateTime date,
  ) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}