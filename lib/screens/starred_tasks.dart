import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/starred_provider.dart';
import 'package:to_do/utils/colors.dart';
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
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 16,
                        right: 16,
                      ),
                      child: const Text(
                        "Starred recently",
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TaskTile(
                      task: starredTasks[index],
                      isStarredScreen: true,
                    ),
                  ],
                );
              }
              return TaskTile(
                task: starredTasks[index],
                isStarredScreen: true,
              );
            },
          );
  }
}
