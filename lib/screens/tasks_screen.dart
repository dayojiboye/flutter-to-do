import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/completed_provider.dart';
import 'package:to_do/providers/tasks_provider.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/app_empty_view.dart';
import 'package:to_do/widgets/task_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  bool _isExpanded = false;
  final GlobalKey expansionTileKey = GlobalKey();

  void _scrollToSelectedContent({GlobalKey? expansionTileKey}) {
    final keyContext = expansionTileKey!.currentContext;
    if (keyContext != null) {
      Future.delayed(
        const Duration(milliseconds: 200),
      ).then(
        (value) {
          Scrollable.ensureVisible(
            keyContext,
            duration: const Duration(milliseconds: 200),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Task> tasksList = ref.watch(taskProvider);

    final List<Task> completedTasksList = ref.watch(completedProvider);

    final GlobalKey<AnimatedListState> listKey =
        ref.watch(taskProvider.notifier).getTaskListKey;

    final GlobalKey<AnimatedListState> completedListKey =
        ref.watch(taskProvider.notifier).getCompletedListKey;

    return tasksList.isEmpty
        ? const AppEmptyView(
            imagePath: "assets/images/task.png",
            title: "No task added",
          )
        : SingleChildScrollView(
            key: ValueKey(tasksList.length),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !tasksList.any((task) => !task.isCompleted)
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            bottom: 12.0,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.celebration_sharp,
                                size: 30,
                                color: Color.fromARGB(255, 252, 166, 8),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Hurray! You have no uncompleted task",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : AnimatedList(
                        key: listKey,
                        primary: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        initialItemCount: tasksList.length,
                        itemBuilder: (context, index, animation) {
                          if (tasksList[index].isCompleted) {
                            return const SizedBox();
                          }
                          return TaskTile(
                            animation: animation,
                            task: tasksList[index],
                            taskIndex: index,
                          );
                        },
                      ),
                const Divider(
                  color: kBorder,
                  thickness: 1.0,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    key: expansionTileKey,
                    initiallyExpanded: true,
                    childrenPadding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                    ),
                    title: Text(
                      "Completed",
                      style: GoogleFonts.interTight(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryTextColor,
                      ),
                    ),
                    trailing: AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 50),
                      child: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 35,
                        color: kMuted,
                      ),
                    ),
                    onExpansionChanged: (value) {
                      setState(() {
                        _isExpanded = value;
                      });
                      if (value) {
                        _scrollToSelectedContent(
                          expansionTileKey: expansionTileKey,
                        );
                      }
                    },
                    children: [
                      AnimatedList(
                        key: completedListKey,
                        primary: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        initialItemCount: completedTasksList.length,
                        itemBuilder: (context, index, animation) {
                          return TaskTile(
                            task: completedTasksList[index],
                            taskIndex: index,
                            animation: animation,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
