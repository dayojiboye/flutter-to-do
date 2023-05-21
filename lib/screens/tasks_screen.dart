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

    return tasksList.isEmpty
        ? const AppEmptyView(
            imagePath: "assets/images/task.png",
            title: "No task added",
            text: "Add a task to get reminded",
          )
        : ListView.builder(
            itemCount: tasksList.length,
            itemBuilder: (context, index) {
              return TaskTile(
                description: tasksList[index].description,
                isStarred: tasksList[index].isStarred,
              );
            },
          );
  }
}
