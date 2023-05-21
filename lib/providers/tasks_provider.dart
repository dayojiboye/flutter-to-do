import 'package:to_do/models/task.dart';

import "package:flutter_riverpod/flutter_riverpod.dart";

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  void addTask(Task task) {
    state = [
      task,
      ...state,
    ];
  }

  // To:Do: Implement remove task
}

final taskProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
