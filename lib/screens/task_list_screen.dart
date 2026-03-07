import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/widgets/task_card.dart';
import 'package:task_manager/screens/add_task_screen.dart';
import 'package:task_manager/screens/profile_screen.dart';
import 'package:task_manager/providers/auth_provider.dart' as CustomAuthProvider;

class TaskListScreen extends StatefulWidget {
  static const routeName = '/task-list';
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  void _showSortOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort By'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Due Date'),
                onTap: () {
                  Provider.of<TaskProvider>(context, listen: false).setSortOption(SortOption.dueDate);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Priority'),
                onTap: () {
                  Provider.of<TaskProvider>(context, listen: false).setSortOption(SortOption.priority);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('None'),
                onTap: () {
                  Provider.of<TaskProvider>(context, listen: false).setSortOption(SortOption.none);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter By'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('All'),
                onTap: () {
                  Provider.of<TaskProvider>(context, listen: false).setFilterOption(FilterOption.all);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Completed'),
                onTap: () {
                  Provider.of<TaskProvider>(context, listen: false).setFilterOption(FilterOption.completed);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Incomplete'),
                onTap: () {
                  Provider.of<TaskProvider>(context, listen: false).setFilterOption(FilterOption.incomplete);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortOptions(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(context),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<CustomAuthProvider.AuthProvider>(context, listen: false).signOut();
              // The StreamBuilder in main.dart will automatically navigate to the LoginScreen.
            },
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (taskProvider.errorMessage != null) {
            return Center(child: Text('Error: ${taskProvider.errorMessage}'));
          }
          if (taskProvider.tasks.isEmpty) {
            return const Center(
              child: Text('No tasks found. Add a new task to get started!'),
            );
          }
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return TaskCard(task: task);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
