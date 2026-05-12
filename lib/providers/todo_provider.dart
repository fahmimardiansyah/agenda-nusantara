import 'package:flutter/material.dart';

import '../data/database/database_helper.dart';
import '../data/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  String quickCategory = 'regular';

void setQuickCategory(String category) {
  quickCategory = category;
  notifyListeners();
}

  List<TodoModel> _todos = [];

  // =========================
  // GETTER
  // =========================
  List<TodoModel> get todos => _todos;

  // =========================
  // LOAD TODOS
  // =========================
  Future<void> loadTodos() async {
    _todos = await _databaseHelper.getTodos();

    notifyListeners();
  }

  // =========================
  // ADD TODO
  // =========================
  Future<void> addTodo(TodoModel todo) async {
    await _databaseHelper.insertTodo(todo);

    await loadTodos();
  }

  // =========================
  // UPDATE STATUS
  // =========================
  Future<void> updateTodoStatus(int id, int isDone) async {
    await _databaseHelper.updateTodoStatus(id, isDone);

    await loadTodos();
  }

  // =========================
  // UPDATE TODO
  // =========================
  Future<void> updateTodo(TodoModel todo) async {
    await _databaseHelper.updateTodo(todo);

    await loadTodos();
  }

  // =========================
  // DELETE TODO
  // =========================
  Future<void> deleteTodo(int id) async {
    await _databaseHelper.deleteTodo(id);

    await loadTodos();
  }

  // =========================
  // TOTAL DONE
  // =========================
  int get totalDone => _todos.where((todo) => todo.isDone == 1).length;

  // =========================
  // TOTAL UNDONE
  // =========================
  int get totalUndone => _todos.where((todo) => todo.isDone == 0).length;

  // =========================
  // IMPORTANT TASK COUNT
  // =========================
  int get importantCount =>
      _todos.where((todo) => todo.category == 'important').length;

  // =========================
  // REGULAR TASK COUNT
  // =========================
  int get regularCount =>
      _todos.where((todo) => todo.category == 'regular').length;
}
