import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/tasks_provider.dart';
import 'package:to_do/screens/edit_task_screen.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/touchable_opacity.dart';

class TaskTile extends ConsumerWidget {
  const TaskTile({
    super.key,
    this.isStarredScreen = false,
    required this.task,
    required this.taskIndex,
    required this.animation,
  });

  final bool isStarredScreen;
  final Task task;
  final int taskIndex;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 16,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(
                task: task,
                taskIndex: taskIndex,
              ),
            ),
          );
        },
        leading: TouchableOpacity(
          backgroundColor: Colors.transparent,
          width: 30,
          height: 30,
          onTap: () {},
          child: const Icon(
            Icons.circle_outlined,
            size: 30,
            color: kMuted,
          ),
        ),
        title: Text(
          task.description,
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
          onTap: () {
            HapticFeedback.lightImpact();
            ref.read(taskProvider.notifier).toggleStarredTask(
                  task.id,
                  taskIndex,
                  task.isStarred,
                  task,
                  context,
                  isStarredScreen,
                );
          },
          child: Icon(
            task.isStarred ? Icons.star_outlined : Icons.star_outline,
            size: 30,
            color: task.isStarred ? kPrimaryColor : kMuted,
          ),
        ),
      ),
    );
  }
}
