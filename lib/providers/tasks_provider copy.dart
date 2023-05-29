import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/enums/enums.dart';
import 'package:to_do/models/task.dart';

import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:to_do/widgets/app_snackbar.dart';
import 'package:to_do/widgets/task_tile.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  final GlobalKey<AnimatedListState> taskListKey = GlobalKey();
  final GlobalKey<AnimatedListState> starredListKey = GlobalKey();
  final GlobalKey<AnimatedListState> completedListKey = GlobalKey();

  GlobalKey<AnimatedListState> get getTaskListKey {
    return taskListKey;
  }

  GlobalKey<AnimatedListState> get getStarredListKey {
    return starredListKey;
  }

  GlobalKey<AnimatedListState> get getCompletedListKey {
    return completedListKey;
  }

  void _insertTask(int taskIndex, Task task) {
    taskListKey.currentState?.insertItem(
      taskIndex,
      duration: const Duration(milliseconds: 100),
    );
  }

  void _insertStarredTask(int taskIndex) {
    starredListKey.currentState?.insertItem(
      taskIndex,
      duration: const Duration(milliseconds: 100),
    );
  }

  void _insertCompletedTask(int taskIndex) {
    completedListKey.currentState?.insertItem(
      taskIndex,
      duration: const Duration(milliseconds: 100),
    );
  }

  void _removeTask(
    int taskIndex,
    TaskTile Function(dynamic context, dynamic animation) builder,
    Task task,
  ) {
    if (task.isCompleted) return;
    taskListKey.currentState?.removeItem(
      taskIndex,
      builder,
      duration: const Duration(milliseconds: 200),
    );
  }

  void _removeStarredTask(
    int taskIndex,
    TaskTile Function(dynamic context, dynamic animation) builder,
  ) {
    starredListKey.currentState?.removeItem(
      taskIndex,
      builder,
      duration: const Duration(milliseconds: 200),
    );
  }

  void _removeCompletedTask(
    int taskIndex,
    TaskTile Function(dynamic context, dynamic animation) builder,
  ) {
    completedListKey.currentState?.removeItem(
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
      if (task.isCompleted) return;
      _insertTask(taskIndex, task);
      return;
    }

    state = [
      task,
      ...state,
    ];

    _insertTask(0, task);
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
          HapticFeedback.lightImpact();
          addTask(
            task,
            taskIndex,
          );

          if (isStarred == null) return;

          if (isStarred) {
            _insertStarredTask(taskIndex);
          }
        },
      ),
    ).showFeedback();

    if (isStarred != null && isStarred) {
      _removeStarredTask(taskIndex, builder);
    }

    _removeTask(taskIndex, builder, task);
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
      _insertStarredTask(taskIndex!);
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
              HapticFeedback.lightImpact();
              state = state.map((task) {
                return task.id == taskId
                    ? task.copyWith(isStarred: true)
                    : task;
              }).toList();

              _insertStarredTask(taskIndex!);
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

      _removeStarredTask(taskIndex!, builder);
    }
  }

  void editTask(String taskId, String desc) {
    state = state
        .map((task) =>
            task.id == taskId ? task.copyWith(description: desc) : task)
        .toList();
  }

  // Also add snackbar and undo action for completed toggle
  void toggleCompletedTask(
    String taskId,
    int taskIndex,
    Task task, [
    BuildContext? ctx,
    bool? isTaskCompleted,
    bool isStarredScreen = false,
  ]) {
    state = state
        .map((task) => task.id == taskId
            ? task.copyWith(isCompleted: !task.isCompleted)
            : task)
        .toList();

    builder(context, animation) {
      return TaskTile(
        animation: animation,
        task: task,
        taskIndex: taskIndex,
      );
    }

    if (isTaskCompleted == null) return;

    if (!isTaskCompleted) {
      _insertCompletedTask(taskIndex);
      _removeTask(taskIndex, builder, task);
    } else if (isTaskCompleted) {
      _insertTask(taskIndex, task);
      _removeCompletedTask(taskIndex, builder);
    }
  }
}

final taskProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
