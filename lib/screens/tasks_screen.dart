import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/touchable_opacity.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // ignore: non_constant_identifier_names
  final List<Task> TasksList = [
    Task(
      description: "Just a sample task!",
      isStarred: false,
      isCompleted: false,
      date: DateTime.now(),
    ),
    Task(
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      isStarred: true,
      isCompleted: false,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () {
        return Future(() => {});
      },
      child: ListView.builder(
        itemCount: TasksList.length,
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
              TasksList[index].description,
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
                TasksList[index].isStarred
                    ? Icons.star_outlined
                    : Icons.star_outline,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}
