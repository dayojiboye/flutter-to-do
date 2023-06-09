import 'package:to_do/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/providers/tasks_provider.dart';

final completedProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskProvider);
  return tasks.where((task) => task.isCompleted).toList();
});
