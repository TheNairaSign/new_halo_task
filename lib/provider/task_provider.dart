import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_halo_task/models/task_models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _enteredTasks = [];
  User? user;

  List<Task> get enteredTasks => _enteredTasks;

  Box<Task>? taskBox;

  TaskProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user = user;
      if (user != null) {
        _initHiveTasks();
      } else {
        _enteredTasks.clear();
        taskBox?.close();
        taskBox = null;
        notifyListeners();
      }
    });
  }

  Future<void> _initHiveTasks() async {
    if (user != null) {
      try {
        taskBox = await Hive.openBox<Task>("tasks_${user!.uid}");
        _enteredTasks = taskBox?.values.toList() ?? [];
        notifyListeners();
      } catch (e) {
        debugPrint("Error initializing Hive for tasks: $e");
      }
    }
  }

  void updateTasks(List<Task> tasks) {
    _enteredTasks = tasks;
    notifyListeners();
  }

  Future<void> addTasks(Task task) async {
    if (user != null) {
      try {
        await taskBox?.add(task);
        _enteredTasks.add(task);
        notifyListeners();
      } catch (e) {
        debugPrint("Error adding task: $e");
      }
    }
  }

  Future<void> updateTaskInHive(Task task) async {
    if (user != null && task.key != null) {
      try {
        await task.save();
        notifyListeners();
      } catch (e) {
        debugPrint("Error updating task: $e");
      }
    }
  }

  void addToImportant(Task task, bool isImportant) {
    task.isImportant = isImportant;
    updateTaskInHive(task);
  }

  void addToCompletedTask(Task task) {
    task.isCompleted = !task.isCompleted;
    updateTaskInHive(task);
  }

  Future<void> removeTasks(Task task) async {
    if (user != null && task.key != null) {
      try {
        _enteredTasks.remove(task);
        await task.delete();
        notifyListeners();
      } catch (e) {
        debugPrint("Error removing task: $e");
      }
    }
  }

  void deleteAction(BuildContext context, Task task, int index) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Row(
          children: [
            Text(
              "Task deleted",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                undoDeleteTasks(index, task);
              },
              child: Text(
                "Undo",
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    removeTasks(task);
  }

  void removeCompletedTasks() async {
    if (user != null) {
      try {
        final keysToDelete = taskBox?.keys.where((key) {
          final task = taskBox?.get(key);
          return task != null && task.isCompleted;
        }).toList();

        if (keysToDelete != null) {
          await taskBox?.deleteAll(keysToDelete);
          _enteredTasks.removeWhere((task) => task.isCompleted);
          notifyListeners();
        }
      } catch (e) {
        debugPrint("Error removing completed tasks: $e");
      }
    }
  }

  void undoDeleteTasks(int index, Task task) {
    _enteredTasks.insert(index, task);
    taskBox?.put(task.key, task);
    notifyListeners();
  }
}
