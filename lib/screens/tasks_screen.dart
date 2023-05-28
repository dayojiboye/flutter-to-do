import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/tasks_provider.dart';
import 'package:to_do/widgets/app_empty_view.dart';
import 'package:to_do/widgets/task_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Task> tasksList = ref.watch(taskProvider);

    final GlobalKey<AnimatedListState> listKey =
        ref.watch(taskProvider.notifier).getTaskListKey;

    return tasksList.isEmpty
        ? const AppEmptyView(
            imagePath: "assets/images/task.png",
            title: "No task added",
          )
        : AnimatedList(
            key: listKey,
            initialItemCount: tasksList.length,
            itemBuilder: (context, index, animation) {
              return TaskTile(
                animation: animation,
                task: tasksList[index],
                taskIndex: index,
              );
            },
          );
  }
}
