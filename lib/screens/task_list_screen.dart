import 'package:flutter/material.dart';

class TaskListScreen extends StatelessWidget {
  static const routeName = '/task-list';
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        centerTitle: true,
      ),
    );
  }
}
