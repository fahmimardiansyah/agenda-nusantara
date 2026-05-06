import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance =
      DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  // =========================
  // GET DATABASE
  // =========================
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('agenda_nusantara.db');

    return _database!;
  }

  // =========================
  // INIT DATABASE
  // =========================
  Future<Database> _initDB(
    String filePath,
  ) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // =========================
  // CREATE TABLE
  // =========================
  Future<void> _createDB(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        due_date TEXT NOT NULL,
        category TEXT NOT NULL,
        is_done INTEGER NOT NULL
      )
    ''');
  }

    // =========================
  // INSERT TODO
  // =========================
  Future<int> insertTodo(
    TodoModel todo,
  ) async {
    final db = await instance.database;

    return await db.insert(
      'todos',
      todo.toMap(),
    );
  }

  // =========================
  // GET ALL TODOS
  // =========================
  Future<List<TodoModel>> getTodos() async {
    final db = await instance.database;

    final result = await db.query(
      'todos',
      orderBy: 'id DESC',
    );

    return result
        .map((json) => TodoModel.fromMap(json))
        .toList();
  }

  // =========================
  // UPDATE TODO STATUS
  // =========================
  Future<int> updateTodoStatus(
    int id,
    int isDone,
  ) async {
    final db = await instance.database;

    return await db.update(
      'todos',
      {
        'is_done': isDone,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

    // =========================
  // UPDATE TODO
  // =========================
  Future<int> updateTodo(
    TodoModel todo,
  ) async {
    final db = await instance.database;

    return await db.update(
      'todos',
      todo.toMap(),

      where: 'id = ?',

      whereArgs: [todo.id],
    );
  }

  // =========================
  // DELETE TODO
  // =========================
  Future<int> deleteTodo(
    int id,
  ) async {
    final db = await instance.database;

    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // =========================
  // CLOSE DATABASE
  // =========================
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}