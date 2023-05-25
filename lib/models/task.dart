import "package:intl/intl.dart";

final formatter = DateFormat.yMd();

class Task {
  Task({
    required this.description,
    required this.isStarred,
    required this.date,
    required this.isCompleted,
    required this.id,
  });

  final String description;
  final bool isStarred;
  final DateTime date;
  final String id;
  final bool isCompleted;

  String get formattedDate {
    return formatter.format(date);
  }

  Task copyWith({
    String? description,
    bool? isStarred,
    DateTime? date,
    bool? isCompleted,
    String? id,
  }) {
    return Task(
      description: description ?? this.description,
      isStarred: isStarred ?? this.isStarred,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
    );
  }
}
