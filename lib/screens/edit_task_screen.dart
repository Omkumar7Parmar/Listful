import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/providers/task_provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = '/edit-task';
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.task.title;
    _description = widget.task.description;
  }

  void _tryUpdateTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus(); // Dismiss keyboard

      final updatedTask = widget.task.copyWith(
        title: _title,
        description: _description,
      );

      await Provider.of<TaskProvider>(context, listen: false)
          .updateTask(updatedTask);

      if (!mounted) return;
      if (Provider.of<TaskProvider>(context, listen: false).errorMessage == null) {
        Navigator.of(context).pop(); // Go back to task list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Provider.of<TaskProvider>(context, listen: false).errorMessage!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 20),
              Consumer<TaskProvider>(
                builder: (context, taskProvider, child) => taskProvider.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _tryUpdateTask,
                        child: const Text('Update Task'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
