class TodoObj {
  final int id;
  final String title;
  final String detail;

  TodoObj({
    required this.id,
    required this.title,
    required this.detail,
  });

  TodoObj copyWith({
    int? id,
    String? title,
    String? detail,
  }) {
    return TodoObj(
        id: id ?? this.id,
        title: title ?? this.title,
        detail: detail ?? this.detail);
  }
}
