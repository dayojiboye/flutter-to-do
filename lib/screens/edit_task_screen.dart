import 'package:flutter/material.dart';

import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/tasks_provider.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/app_text_field.dart';
import 'package:to_do/widgets/touchable_opacity.dart';
import "package:flutter_svg/flutter_svg.dart";

class EditTaskScreen extends ConsumerStatefulWidget {
  const EditTaskScreen({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => EditTaskScreenState();
}

class EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  final TextEditingController _editTaskController = TextEditingController();

  @override
  void dispose() {
    _editTaskController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editTaskController.text = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    final List<Task> taskList = ref.watch(taskProvider);

    // final Task exactTask =
    //     taskList.where((task) => task.id == widget.task.id).toList()[0];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 7,
        leading: TouchableOpacity(
          backgroundColor: Colors.transparent,
          width: 56.0,
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.chevron_left_sharp,
            size: 50,
          ),
        ),
        actions: [
          TouchableOpacity(
            onTap: () {
              ref.read(taskProvider.notifier).toggleStarredTask(widget.task.id);
            },
            backgroundColor: Colors.transparent,
            width: 30,
            child: Icon(
              widget.task.isStarred ? Icons.star_outlined : Icons.star_outline,
              size: 30,
              color:
                  widget.task.isStarred ? kPrimaryColor : kSecondaryTextColor,
            ),
          ),
          const SizedBox(width: 38),
          TouchableOpacity(
            backgroundColor: Colors.transparent,
            width: 30,
            child: SvgPicture.asset(
              "assets/icons/trash.svg",
              semanticsLabel: 'Acme Logo',
              width: 25,
              colorFilter: const ColorFilter.mode(
                kSecondaryTextColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 25),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                clipBehavior: Clip.none,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 25,
                  top: 20,
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.minHeight),
                  child: Column(
                    children: [
                      AppTextField(
                        autoFocus: false,
                        controller: _editTaskController,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                        hintText: "Enter title",
                        hintStyle: const TextStyle(
                          color: kMuted,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
