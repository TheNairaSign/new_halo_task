import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_halo_task/models/task_models/task.dart';

import '../themes/themes.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> enteredTasks = [];
  User? user = FirebaseAuth.instance.currentUser;
  Box<Task>? taskBox;

  TaskProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user = user;
      if (user != null) {
        _initHive();
      } else {
        enteredTasks.clear();
        closeHive();
        notifyListeners();
      }
    });
  }

  Future<void> _initHive() async {
    if (user != null) {
      try {
        taskBox = await Hive.openBox<Task>("tasks_${user!.uid}");
        enteredTasks = taskBox?.values.cast<Task>().toList() ?? [];
        notifyListeners();
      } catch (e) {
        debugPrint("Error initializing Hive: $e");
      }
    }
  }

  Future<void> closeHive() async {
    if (taskBox != null) {
      await taskBox!.close();
      taskBox = null;
    }
  }

  void updateTasks(List<Task> tasks) {
    enteredTasks = tasks;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    if (user != null) {
      try {
        enteredTasks.add(task);
        await taskBox?.add(task);
        notifyListeners();
      } catch (e) {
        debugPrint("Error adding task: $e");
      }
    }
  }

  Future<void> updateTaskInHive(Task task) async {
    if (user != null && task.key != null) {
      try {
        await taskBox?.put(task.key, task);
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
        enteredTasks.remove(task);
        await taskBox?.delete(task.key);
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
                  color: primaryColor,
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
          enteredTasks.removeWhere((task) => task.isCompleted);
          notifyListeners();
        }
      } catch (e) {
        debugPrint("Error removing completed tasks: $e");
      }
    }
  }

  void undoDeleteTasks(int index, Task task) {
    enteredTasks.insert(index, task);
    taskBox?.put(index, task);
    notifyListeners();
  }
}
