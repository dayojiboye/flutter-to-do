import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/tasks_provider.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/app_empty_view.dart';
import 'package:to_do/widgets/touchable_opacity.dart';
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
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                leading: TouchableOpacity(
                  backgroundColor: Colors.transparent,
                  width: 30,
                  height: 30,
                  onTap: () {},
                  child: const Icon(
                    Icons.circle_outlined,
                    size: 30,
                  ),
                ),
                title: Text(
                  tasksList[index].description,
                  style: const TextStyle(
                    color: kPrimaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                trailing: TouchableOpacity(
                  backgroundColor: Colors.transparent,
                  width: 30,
                  height: 30,
                  onTap: () {},
                  child: Icon(
                    tasksList[index].isStarred
                        ? Icons.star_outlined
                        : Icons.star_outline,
                    size: 30,
                  ),
                ),
              );
            },
          );
  }
}
