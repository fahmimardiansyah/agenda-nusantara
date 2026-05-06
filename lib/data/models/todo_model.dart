class TodoModel {
  final int? id;
  final String title;
  final String description;
  final String dueDate;
  final String category;
  final int isDone;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.isDone,
  });

  // =========================
  // Convert Map to Object
  // =========================
  factory TodoModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['due_date'],
      category: map['category'],
      isDone: map['is_done'],
    );
  }

  // =========================
  // Convert Object to Map
  // =========================
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate,
      'category': category,
      'is_done': isDone,
    };
  }
}