import 'package:uuid/uuid.dart';
import "package:intl/intl.dart";

const uuid = Uuid();

final formatter = DateFormat.yMd();

class Task {
  Task({
    required this.description,
    required this.isStarred,
    required this.date,
    required this.isCompleted,
  }) : id = uuid.v4();

  final String description;
  final bool isStarred;
  final DateTime date;
  final String id;
  final bool isCompleted;

  String get formattedDate {
    return formatter.format(date);
  }
}
