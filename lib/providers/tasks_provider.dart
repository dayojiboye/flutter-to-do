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

  void _insertTask(int taskIndex) {
    taskListKey.currentState?.insertItem(
      taskIndex,
      duration: const Duration(milliseconds: 100),
    );
  }

  void _insertStarredItem(int taskIndex) {
    starredListKey.currentState?.insertItem(
      taskIndex,
      duration: const Duration(milliseconds: 100),
    );
  }

  void _removeTask(
    int taskIndex,
    TaskTile Function(dynamic context, dynamic animation) builder,
  ) {
    taskListKey.currentState?.removeItem(
      taskIndex,
      builder,
      duration: const Duration(milliseconds: 200),
    );
  }

  void _removeStarredItem(
    int taskIndex,
    TaskTile Function(dynamic context, dynamic animation) builder,
  ) {
    starredListKey.currentState?.removeItem(
      taskIndex,
      builder,
      duration: const Duration(milliseconds: 200),
    );
  }

  void addTask(Task task, [int? taskIndex]) {
    if (taskIndex != null) {
      final tempState = state.toList();
      tempState.insert(taskIndex, task);
      state = tempState;
      _insertTask(taskIndex);
      return;
    }

    state = [
      task,
      ...state,
    ];

    _insertTask(0);
  }

  void deleteTask(
    String taskId,
    BuildContext context,
    Task task,
    int taskIndex, [
    bool? isStarred,
  ]) {
    state = state.where((task) => task.id != taskId).toList();

    builder(context, animation) {
      return TaskTile(
        animation: animation,
        task: task,
        taskIndex: taskIndex,
      );
    }

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

          if (isStarred == null) return;

          if (isStarred) {
            print("From Undo Delete");
            _insertStarredItem(taskIndex);
          }
        },
      ),
    ).showFeedback();

    if (isStarred != null && isStarred) {
      _removeStarredItem(taskIndex, builder);
    }

    _removeTask(taskIndex, builder);
  }

  void toggleStarredTask(
    String taskId, [
    int? taskIndex,
    bool? isTaskStarred,
    Task? task,
    BuildContext? ctx,
    bool isStarredScreen = false,
  ]) {
    state = state
        .map((task) => task.id == taskId
            ? task.copyWith(isStarred: !task.isStarred)
            : task)
        .toList();

    if (isTaskStarred == null) return;

    if (!isTaskStarred) {
      _insertStarredItem(taskIndex!);
    } else if (isTaskStarred) {
      if (ctx != null && isStarredScreen) {
        ScaffoldMessenger.of(ctx).clearSnackBars();
        AppSnackbar(
          context: ctx,
          variant: SnackbarVariant.SUCCESS,
          text: "Task removed from Starred",
          action: SnackBarAction(
            label: "Undo",
            textColor: const Color(0xff6ba5ed),
            onPressed: () {
              state = state.map((task) {
                return task.id == taskId
                    ? task.copyWith(isStarred: true)
                    : task;
              }).toList();

              _insertStarredItem(taskIndex!);
            },
          ),
        ).showFeedback();
      }

      builder(context, animation) {
        return TaskTile(
          animation: animation,
          task: task!,
          taskIndex: taskIndex!,
        );
      }

      _removeStarredItem(taskIndex!, builder);
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
