import 'package:flutter/material.dart';

import "package:flutter_riverpod/flutter_riverpod.dart";

class EditTaskScreen extends ConsumerStatefulWidget {
  const EditTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => EditTaskScreenState();
}

class EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Screen"),
      ),
    );
  }
}
