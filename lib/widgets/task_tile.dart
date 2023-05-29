import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/tasks_provider.dart';
import 'package:to_do/screens/edit_task_screen.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/touchable_opacity.dart';

class TaskTile extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskTileState();
}

class _TaskTileState extends ConsumerState<TaskTile> {
  bool _showCheckmarkIcon = false;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(
                task: widget.task,
                taskIndex: widget.taskIndex,
              ),
            ),
          );
        },
        leading: TouchableOpacity(
          backgroundColor: Colors.transparent,
          width: 30,
          height: 30,
          onTap: () {
            if (!widget.task.isCompleted) {
              setState(() {
                _showCheckmarkIcon = true;
              });
            } else {
              setState(() {
                _showCheckmarkIcon = false;
              });
            }

            ref.read(taskProvider.notifier).toggleCompletedTask(
                  widget.task.id,
                  widget.taskIndex,
                  widget.task,
                  context,
                  widget.task.isCompleted,
                );
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: _showCheckmarkIcon || widget.task.isCompleted
                ? Icon(
                    key: ValueKey(_showCheckmarkIcon),
                    Icons.check_sharp,
                    size: 30,
                    color: kPrimaryColor,
                  )
                : Icon(
                    key: ValueKey(_showCheckmarkIcon),
                    Icons.circle_outlined,
                    size: 30,
                    color: kMuted,
                  ),
          ),
        ),
        title: Text(
          widget.task.description,
          style: TextStyle(
            color: kPrimaryTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.4,
            decoration: widget.task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: TouchableOpacity(
          backgroundColor: Colors.transparent,
          width: 30,
          height: 30,
          onTap: () {
            HapticFeedback.lightImpact();
            ref.read(taskProvider.notifier).toggleStarredTask(
                  widget.task.id,
                  widget.taskIndex,
                  widget.task.isStarred,
                  widget.task,
                  context,
                  widget.isStarredScreen,
                );
          },
          child: Icon(
            widget.task.isStarred ? Icons.star_outlined : Icons.star_outline,
            size: 30,
            color: widget.task.isStarred ? kPrimaryColor : kMuted,
          ),
        ),
      ),
    );
  }
}
