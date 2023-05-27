import 'package:flutter/material.dart';
import 'package:to_do/enums/enums.dart';
import 'package:to_do/models/task.dart';

import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:to_do/widgets/app_snackbar.dart';
import 'package:to_do/widgets/task_tile.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  final GlobalKey<AnimatedListState> taskListKey = GlobalKey();
  final GlobalKey<AnimatedListState> starredListKey = GlobalKey();

  GlobalKey<AnimatedListState> get getTaskListKey {
    return taskListKey;
  }

  GlobalKey<AnimatedListState> get getStarredListKey {
    return starredListKey;
  }

  void addTask(Task task, [int? taskIndex]) {
    if (taskIndex != null) {
      final tempState = state.toList();
      tempState.insert(taskIndex, task);
      state = tempState;
      taskListKey.currentState?.insertItem(
        taskIndex,
        duration: const Duration(milliseconds: 100),
      );
      return;
    }

    state = [
      task,
      ...state,
    ];

    taskListKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 100),
    );
  }

  void deleteTask(
    String taskId,
    BuildContext context,
    Task task,
    int taskIndex,
  ) {
    state = state.where((task) => task.id != taskId).toList();
    ScaffoldMessenger.of(context).clearSnackBars();
    AppSnackbar(
      context: context,
      variant: SnackbarVariant.SUCCESS,
      text: "Task deleted",
      action: SnackBarAction(
        label: "Undo",
        textColor: const Color(0xff6ba5ed),
        onPressed: () {
          addTask(
            task,
            taskIndex,
          );
        },
      ),
    ).showFeedback();

    builder(context, animation) {
      return TaskTile(
        animation: animation,
        task: task,
        taskIndex: taskIndex,
      );
    }

    taskListKey.currentState?.removeItem(
      taskIndex,
      builder,
      duration: const Duration(milliseconds: 200),
    );
  }

  void toggleStarredTask(
    String taskId, [
    int? taskIndex,
    bool? isTaskStarred,
    Task? task,
  ]) {
    state = state
        .map((task) => task.id == taskId
            ? task.copyWith(isStarred: !task.isStarred)
            : task)
        .toList();

    if (isTaskStarred != null && isTaskStarred) {
      builder(context, animation) {
        return TaskTile(
          animation: animation,
          task: task!,
          taskIndex: taskIndex!,
        );
      }

      starredListKey.currentState?.removeItem(
        taskIndex!,
        builder,
        duration: const Duration(milliseconds: 200),
      );
    }
  }

  void editTask(String taskId, String desc) {
    state = state
        .map((task) =>
            task.id == taskId ? task.copyWith(description: desc) : task)
        .toList();
  }

  // To-Do: Implement complete task toggle
}

final taskProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
