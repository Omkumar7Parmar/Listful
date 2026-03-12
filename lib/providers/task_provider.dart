import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/firestore_service.dart';

enum SortOption { none, dueDate, priority }
enum FilterOption { all, completed, incomplete }

class TaskProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Task> _allTasks = [];
  List<Task> _filteredTasks = [];
  bool _isLoading = true;
  String? _errorMessage;
  StreamSubscription? _tasksStreamSubscription;
  SortOption _sortOption = SortOption.none;
  FilterOption _filterOption = FilterOption.all;
  String? _currentUserId;

  List<Task> get tasks => _filteredTasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void updateUser(String? userId) {
    _tasksStreamSubscription?.cancel();
    _currentUserId = userId;
    if (userId != null) {
      _isLoading = true;
      notifyListeners();
      _tasksStreamSubscription = _firestoreService.getTasks(userId).listen((tasks) {
        _allTasks = tasks;
        _applyFiltersAndSorting();
        _isLoading = false;
        _errorMessage = null;
      }, onError: (error) {
        _errorMessage = 'Failed to load tasks: ${error.toString()}';
        _isLoading = false;
        notifyListeners();
      });
    } else {
      _allTasks = [];
      _filteredTasks = [];
      _isLoading = false;
      _errorMessage = 'User not logged in.';
      notifyListeners();
    }
  }

  void _applyFiltersAndSorting() {
    _filteredTasks = List.from(_allTasks);

    if (_filterOption == FilterOption.completed) {
      _filteredTasks.retainWhere((task) => task.isCompleted);
    } else if (_filterOption == FilterOption.incomplete) {
      _filteredTasks.retainWhere((task) => !task.isCompleted);
    }

    if (_sortOption == SortOption.dueDate) {
      _filteredTasks.sort((a, b) {
        if (a.dueDate == null && b.dueDate == null) return 0;
        if (a.dueDate == null) return 1;
        if (b.dueDate == null) return -1;
        return a.dueDate!.compareTo(b.dueDate!);
      });
    } else if (_sortOption == SortOption.priority) {
      const priorityOrder = {'High': 0, 'Medium': 1, 'Low': 2};
      _filteredTasks.sort((a, b) {
        return priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
      });
    }
    
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    _applyFiltersAndSorting();
  }

  void setFilterOption(FilterOption option) {
    _filterOption = option;
    _applyFiltersAndSorting();
  }

  Future<void> addTask({
    required String title,
    required String description,
    required DateTime? dueDate,
    required String priority,
  }) async {
    try {
      if (_currentUserId == null) throw Exception('User not logged in.');
      
      final newTask = Task(
        id: '',
        title: title,
        description: description,
        userId: _currentUserId!,
        dueDate: dueDate,
        priority: priority,
      );
      await _firestoreService.addTask(newTask);
    } catch (e) {
      _errorMessage = 'Failed to add task: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> updateTask({
    required String taskId,
    required String title,
    required String description,
    required DateTime? dueDate,
    required String priority,
    required bool isCompleted,
  }) async {
    try {
      if (_currentUserId == null) throw Exception('User not logged in.');
      
      final updatedTask = Task(
        id: taskId,
        title: title,
        description: description,
        userId: _currentUserId!,
        dueDate: dueDate,
        priority: priority,
        isCompleted: isCompleted,
      );
      await _firestoreService.updateTask(updatedTask);
    } catch (e) {
      _errorMessage = 'Failed to update task: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestoreService.deleteTask(taskId);
    } catch (e) {
      _errorMessage = 'Failed to delete task: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    try {
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      await _firestoreService.updateTask(updatedTask);
    } catch (e) {
      _errorMessage = 'Failed to toggle task completion: ${e.toString()}';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _tasksStreamSubscription?.cancel();
    super.dispose();
  }
}



