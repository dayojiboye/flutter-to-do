import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/enums/enums.dart';
import 'package:to_do/models/task.dart';
// import 'package:to_do/providers/starred_provider.dart';
import 'package:to_do/providers/tasks_provider.dart';
import 'package:to_do/screens/edit_task_screen.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/app_snackbar.dart';
import 'package:to_do/widgets/touchable_opacity.dart';

class TaskTile extends ConsumerWidget {
  const TaskTile({
    super.key,
    this.isStarredScreen = false,
    required this.task,
  });

  final bool isStarredScreen;
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final List<Task> starredTasksList = ref.watch(starredProvider);

    void showSnackbar() {
      if (isStarredScreen && task.isStarred) {
        AppSnackbar(
          context: context,
          variant: SnackbarVariant.SUCCESS,
          text: "Task removed from Starred",
          // action: SnackBarAction(
          //   label: "Undo",
          //   onPressed: () {
          //     int taskIndex =
          //         starredTasksList.indexWhere((t) => t.id == task.id);
          //     starredTasksList.insert(
          //       taskIndex,
          //       task.copyWith(isStarred: true),
          //     );
          //   },
          //   textColor: kPrimaryColor,
          // ),
        ).showFeedback();
      }
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditTaskScreen(),
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
          HapticFeedback.mediumImpact();
          ref.read(taskProvider.notifier).toggleStarredTask(task.id);
          ScaffoldMessenger.of(context).clearSnackBars();
          showSnackbar();
        },
        child: Icon(
          task.isStarred ? Icons.star_outlined : Icons.star_outline,
          size: 30,
          color: task.isStarred ? kPrimaryColor : kMuted,
        ),
      ),
    );
  }
}
