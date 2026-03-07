import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/widgets/task_card.dart';
import 'package:task_manager/screens/add_task_screen.dart';
import 'package:task_manager/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/providers/auth_provider.dart' as CustomAuthProvider;

class TaskListScreen extends StatefulWidget {
  static const routeName = '/task-list';
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure the user is logged in before fetching tasks
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        Provider.of<TaskProvider>(context, listen: false).fetchTasks();
      } else {
        // If for some reason user is null, navigate to login
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        centerTitle: true,
        actions: [
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
              Navigator.of(context).pushReplacementNamed('/login');
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
              child: Text('No tasks yet! Add a new task to get started.'),
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
