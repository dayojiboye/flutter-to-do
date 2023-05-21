import 'package:to_do/models/task.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class StarredTasksNotifier extends StateNotifier<List<Task>> {
  StarredTasksNotifier() : super([]);

  void toggleStarredTask(Task task) {
    final bool isTaskStarred = state.contains(task);

    if (isTaskStarred) {
      state = state.where((item) => item.id != task.id).toList();
    } else {
      state = [
        task,
        ...state,
      ];
    }
  }
}

final starredTaskProvider =
    StateNotifierProvider<StarredTasksNotifier, List<Task>>((ref) {
  return StarredTasksNotifier();
});
