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

  void toggleStarredTask(String taskId) {
    state = state
        .map((task) => task.id == taskId
            ? task.copyWith(isStarred: !task.isStarred)
            : task)
        .toList();
  }

  // To:Do: Implement complete task toggle
}

final taskProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
