import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/starred_provider.dart';
import 'package:to_do/widgets/app_empty_view.dart';
import 'package:to_do/widgets/task_tile.dart';

class StarredTasksScreen extends ConsumerWidget {
  const StarredTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Task> starredTasks = ref.watch(starredProvider);

    return starredTasks.isEmpty
        ? const AppEmptyView(
            imagePath: "assets/images/star.png",
            title: "No starred tasks",
            text:
                "Mark important tasks with a star so that \n you can easily find them here")
        : ListView.builder(
            itemCount: starredTasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                description: starredTasks[index].description,
                isStarred: starredTasks[index].isStarred,
              );
            },
          );
  }
}
