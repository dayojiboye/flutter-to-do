import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/tasks_provider.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/app_text_button.dart';
import 'package:to_do/widgets/app_text_field.dart';
import 'package:to_do/widgets/touchable_opacity.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({
    super.key,
    required this.onSuccess,
  });

  final void Function() onSuccess;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AddTaskState();
}

class AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController _newTaskController = TextEditingController();
  bool _isButtonDisabled = true;
  bool _isStarred = false;

  void _onSaveTask() {
    if (_newTaskController.text.trim().isEmpty) return;

    ref.read(taskProvider.notifier).addTask(
          Task(
            description: _newTaskController.text.trim(),
            isStarred: _isStarred,
            date: DateTime.now(),
            isCompleted: false,
          ),
        );

    Navigator.of(context).pop();
    widget.onSuccess();
  }

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 0),
        curve: Curves.decelerate,
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            left: 25,
            right: 25,
            bottom: 30,
          ),
          child: Column(
            children: [
              AppTextField(
                controller: _newTaskController,
                style: const TextStyle(
                  fontSize: 18,
                ),
                hintText: "New task",
                hintStyle: const TextStyle(
                  color: kMuted,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                onChanged: (value) {
                  setState(() {
                    _isButtonDisabled = value!.trim().isEmpty;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TouchableOpacity(
                    width: 30,
                    height: 30,
                    backgroundColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _isStarred = !_isStarred;
                      });
                    },
                    child: Icon(
                      _isStarred ? Icons.star : Icons.star_outline,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                  ),
                  AppTextButton(
                    text: "Save",
                    disabled: _isButtonDisabled,
                    onTap: _onSaveTask,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
