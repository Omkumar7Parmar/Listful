import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;
  Stream<List<Task>>? _tasksStream;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  TaskProvider() {
    _initializeTasksStream();
  }

  void _initializeTasksStream() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _tasksStream = _firestoreService.getTasks(user.uid);
      _tasksStream!.listen((tasks) {
        _tasks = tasks;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      }).onError((error) {
        _errorMessage = 'Failed to load tasks: ${error.toString()}';
        _isLoading = false;
        notifyListeners();
      });
    } else {
      _errorMessage = 'User not logged in.';
      notifyListeners();
    }
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    // The tasks are already being fetched by the stream, so no need for explicit fetch here
    // The listener in _initializeTasksStream will update _tasks and notify listeners.
  }

  Future<void> addTask(String title, String description) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in.');
      }
      final newTask = Task(
        id: DateTime.now().toIso8601String(), // Temporary ID, Firestore will assign a real one
        title: title,
        description: description,
        userId: user.uid,
      );
      await _firestoreService.addTask(newTask);
      // The stream listener will update the _tasks list
    } catch (e) {
      _errorMessage = 'Failed to add task: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTask(Task task) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _firestoreService.updateTask(task);
      // The stream listener will update the _tasks list
    } catch (e) {
      _errorMessage = 'Failed to update task: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _firestoreService.deleteTask(taskId);
      // The stream listener will update the _tasks list
    } catch (e) {
      _errorMessage = 'Failed to delete task: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      await _firestoreService.updateTask(updatedTask);
      // The stream listener will update the _tasks list
    } catch (e) {
      _errorMessage = 'Failed to toggle task completion: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}