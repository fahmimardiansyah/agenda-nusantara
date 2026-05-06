import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';

import '../../data/models/todo_model.dart';

import '../../providers/todo_provider.dart';

class AddTaskPage extends StatefulWidget {
  final TodoModel? todo;

  const AddTaskPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTaskPage> createState() =>
      _AddTaskPageState();
}

class _AddTaskPageState
    extends State<AddTaskPage> {
  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  DateTime? selectedDate;

  String selectedCategory =
      'important';

  bool get isEditMode =>
      widget.todo != null;

  // =========================
  // INIT DATA
  // =========================
  @override
  void initState() {
    super.initState();

    if (isEditMode) {
      titleController.text =
          widget.todo!.title;

      descriptionController.text =
          widget.todo!.description;

      selectedCategory =
          widget.todo!.category;

      selectedDate = DateFormat(
        'dd MMM yyyy',
      ).parse(widget.todo!.dueDate);
    }
  }

  // =========================
  // PICK DATE
  // =========================
  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,

      initialDate:
          selectedDate ?? DateTime.now(),

      firstDate: DateTime(2024),

      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // =========================
  // SAVE / UPDATE TASK
  // =========================
  Future<void> saveTask() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'All fields are required',
          ),
        ),
      );

      return;
    }

    final todo = TodoModel(
      id:
          isEditMode
              ? widget.todo!.id
              : null,

      title: titleController.text,

      description:
          descriptionController.text,

      dueDate: DateFormat(
        'dd MMM yyyy',
      ).format(selectedDate!),

      category: selectedCategory,

      isDone:
          isEditMode
              ? widget.todo!.isDone
              : 0,
    );

    if (isEditMode) {
      await context
          .read<TodoProvider>()
          .updateTodo(todo);
    } else {
      await context
          .read<TodoProvider>()
          .addTodo(todo);
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEditMode
              ? 'Task updated successfully'
              : 'Task added successfully',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isImportant =
        selectedCategory == 'important';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode
              ? 'Edit Task'
              : 'Add Task',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // TITLE
            const Text(
              'Task Title',

              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: AppSizes.sm,
            ),

            CustomTextField(
              hintText: 'Enter task title',

              controller: titleController,

              prefixIcon:
                  Icons.edit_note_rounded,
            ),

            const SizedBox(
              height: AppSizes.lg,
            ),

            // DESCRIPTION
            const Text(
              'Description',

              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: AppSizes.sm,
            ),

            TextField(
              controller:
                  descriptionController,

              maxLines: 5,

              style: const TextStyle(
                color: AppColors.white,
              ),

              decoration: InputDecoration(
                hintText:
                    'Enter task description',

                filled: true,

                fillColor: AppColors.card,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    AppSizes.inputRadius,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.lg,
            ),

            // CATEGORY
            const Text(
              'Task Category',

              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: AppSizes.sm,
            ),

            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
              ),

              decoration: BoxDecoration(
                color: AppColors.card,

                borderRadius:
                    BorderRadius.circular(
                  AppSizes.inputRadius,
                ),
              ),

              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,

                  dropdownColor:
                      AppColors.card,

                  isExpanded: true,

                  icon: const Icon(
                    Icons
                        .keyboard_arrow_down_rounded,
                    color: AppColors.white,
                  ),

                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),

                  items: const [
                    DropdownMenuItem(
                      value: 'important',

                      child: Text(
                        'Important Task',
                      ),
                    ),

                    DropdownMenuItem(
                      value: 'regular',

                      child: Text(
                        'Regular Task',
                      ),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      selectedCategory =
                          value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.lg,
            ),

            // DATE
            const Text(
              'Due Date',

              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: AppSizes.sm,
            ),

            GestureDetector(
              onTap: pickDate,

              child: Container(
                height: 58,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal:
                      AppSizes.md,
                ),

                decoration: BoxDecoration(
                  color: AppColors.card,

                  borderRadius:
                      BorderRadius.circular(
                    AppSizes.inputRadius,
                  ),
                ),

                child: Row(
                  children: [
                    Icon(
                      Icons
                          .calendar_month_rounded,

                      color: isImportant
                          ? AppColors.danger
                          : AppColors.success,
                    ),

                    const SizedBox(
                      width: AppSizes.md,
                    ),

                    Text(
                      selectedDate == null
                          ? 'Select date'
                          : DateFormat(
                              'dd MMM yyyy',
                            ).format(
                              selectedDate!,
                            ),

                      style: TextStyle(
                        color:
                            selectedDate ==
                                    null
                                ? AppColors
                                    .grey
                                : AppColors
                                    .white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.xxl,
            ),

            // BUTTON
            CustomButton(
              text:
                  isEditMode
                      ? 'Update Task'
                      : 'Save Task',

              icon:
                  isEditMode
                      ? Icons.edit_rounded
                      : Icons.save_rounded,

              onPressed: saveTask,
            ),

            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}