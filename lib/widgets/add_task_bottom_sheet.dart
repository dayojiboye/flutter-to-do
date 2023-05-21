import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:to_do/utils/colors.dart';

class AddTask extends ConsumerWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const TextField(
                maxLines: 2,
                minLines: 2,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Add Note",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
