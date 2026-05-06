import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../../providers/todo_provider.dart';

import 'add_task_page.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() =>
      _TaskListPageState();
}

class _TaskListPageState
    extends State<TaskListPage> {
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

    final todos = provider.todos;

    return Scaffold(
      body: SafeArea(
        child: todos.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.lg,
                  AppSizes.lg,
                  AppSizes.lg,
                  140,
                ),

                itemCount: todos.length,

                itemBuilder:
                    (context, index) {
                  final todo = todos[index];

                  final isImportant =
                      todo.category ==
                          'important';

                  return Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom: AppSizes.lg,
                    ),

                    child: Dismissible(
                      key: Key(
                        todo.id.toString(),
                      ),

                      direction:
                          DismissDirection
                              .endToStart,

                      background: Container(
                        alignment:
                            Alignment.centerRight,

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),

                        decoration: BoxDecoration(
                          color:
                              AppColors.danger,

                          borderRadius:
                              BorderRadius.circular(
                            28,
                          ),
                        ),

                        child: const Icon(
                          Icons
                              .delete_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),

                      onDismissed: (_) async {
                        await provider
                            .deleteTodo(
                          todo.id!,
                        );

                        if (!mounted) return;

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Task deleted',
                            ),
                          ),
                        );
                      },

                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (_) => AddTaskPage(
                                    todo: todo,
                                  ),
                            ),
                          );
                        },

                        child: AnimatedContainer(
                          duration:
                              const Duration(
                            milliseconds: 250,
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
                              30,
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: isImportant
                                    ? AppColors
                                        .danger
                                        .withOpacity(
                                          0.08,
                                        )
                                    : AppColors
                                        .primary
                                        .withOpacity(
                                          0.08,
                                        ),

                                blurRadius: 18,
                                spreadRadius: 1,
                              ),
                            ],
                          ),

                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [
                              // CHECKBOX
                              GestureDetector(
                                onTap: () async {
                                  await provider
                                      .updateTodoStatus(
                                    todo.id!,
                                    todo.isDone ==
                                            1
                                        ? 0
                                        : 1,
                                  );
                                },

                                child:
                                    AnimatedContainer(
                                  duration:
                                      const Duration(
                                    milliseconds:
                                        200,
                                  ),

                                  width: 30,
                                  height: 30,

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        todo.isDone ==
                                                1
                                            ? AppColors
                                                .success
                                            : Colors
                                                .transparent,

                                    border:
                                        Border.all(
                                      color:
                                          todo.isDone ==
                                                  1
                                              ? AppColors
                                                  .success
                                              : AppColors
                                                  .grey,

                                      width: 2,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),

                                  child:
                                      todo.isDone ==
                                              1
                                          ? const Icon(
                                              Icons
                                                  .check_rounded,
                                              color:
                                                  Colors
                                                      .white,
                                              size:
                                                  18,
                                            )
                                          : null,
                                ),
                              ),

                              const SizedBox(
                                width:
                                    AppSizes.md,
                              ),

                              // CONTENT
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [
                                    // TOP ROW
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            todo
                                                .title,

                                            style:
                                                TextStyle(
                                              fontSize:
                                                  17,

                                              fontWeight:
                                                  FontWeight
                                                      .bold,

                                              decoration:
                                                  todo.isDone ==
                                                          1
                                                      ? TextDecoration.lineThrough
                                                      : null,

                                              color:
                                                  todo.isDone ==
                                                          1
                                                      ? AppColors.grey
                                                      : AppColors.white,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal:
                                                14,

                                            vertical:
                                                8,
                                          ),

                                          decoration:
                                              BoxDecoration(
                                            color: isImportant
                                                ? AppColors.danger.withOpacity(
                                                    0.15,
                                                  )
                                                : AppColors.primary.withOpacity(
                                                    0.15,
                                                  ),

                                            borderRadius:
                                                BorderRadius.circular(
                                              14,
                                            ),
                                          ),

                                          child:
                                              Text(
                                            isImportant
                                                ? 'Important'
                                                : 'Regular',

                                            style:
                                                TextStyle(
                                              color: isImportant
                                                  ? AppColors.danger
                                                  : AppColors.primary,

                                              fontSize:
                                                  12,

                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height:
                                          AppSizes.md,
                                    ),

                                    // DESCRIPTION
                                    Text(
                                      todo
                                          .description,

                                      style:
                                          const TextStyle(
                                        color:
                                            AppColors
                                                .grey,

                                        height: 1.5,
                                      ),
                                    ),

                                    const SizedBox(
                                      height:
                                          AppSizes.lg,
                                    ),

                                    // FOOTER
                                    Row(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal:
                                                12,

                                            vertical:
                                                8,
                                          ),

                                          decoration:
                                              BoxDecoration(
                                            color: Colors
                                                .white
                                                .withOpacity(
                                                  0.04,
                                                ),

                                            borderRadius:
                                                BorderRadius.circular(
                                              14,
                                            ),
                                          ),

                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .calendar_month_rounded,

                                                size:
                                                    16,

                                                color:
                                                    AppColors
                                                        .grey,
                                              ),

                                              const SizedBox(
                                                width:
                                                    8,
                                              ),

                                              Text(
                                                todo
                                                    .dueDate,

                                                style:
                                                    const TextStyle(
                                                  color:
                                                      AppColors.grey,

                                                  fontSize:
                                                      12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const Spacer(),

                                        Icon(
                                          todo.isDone ==
                                                  1
                                              ? Icons
                                                  .task_alt_rounded
                                              : Icons
                                                  .hourglass_bottom_rounded,

                                          color:
                                              todo.isDone ==
                                                      1
                                                  ? AppColors.success
                                                  : AppColors.secondary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  // =========================
  // EMPTY STATE
  // =========================
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSizes.xl,
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              width: 120,
              height: 120,

              decoration: BoxDecoration(
                color: AppColors.card,

                borderRadius:
                    BorderRadius.circular(
                  32,
                ),
              ),

              child: const Icon(
                Icons.task_alt_rounded,
                size: 60,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(
              height: AppSizes.xl,
            ),

            const Text(
              'No Tasks Yet',

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: AppSizes.sm,
            ),

            const Text(
              'Tap the + button to create your first productivity task.',

              textAlign: TextAlign.center,

              style: TextStyle(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}