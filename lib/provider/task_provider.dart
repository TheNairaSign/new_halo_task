import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_halo_task/models/task_models/task.dart';
import 'package:new_halo_task/themes/themes.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _enteredTasks = [];

  List<Task> get enteredTasks => _enteredTasks;

  Box<Task>? taskBox;

  TaskProvider() {
    _initHive(_enteredTasks);
  }
 
    set enteredTasks(List<Task> tasks) {
    _enteredTasks = tasks;
    notifyListeners();
  }

  void updateTasks(List<Task> tasks) {
    _enteredTasks = tasks;
    notifyListeners();
  }

  Future<void> _initHive(List<Task> tasks) async {
    await Hive.initFlutter();
    taskBox = await Hive.openBox<Task>("tasks");
    _enteredTasks = tasks;
    _enteredTasks.addAll(taskBox!.values);
  }

  void addToImportant(Task task) {
    task.isImportant = !task.isImportant;
    notifyListeners();
  }
  void addToCompletedTask(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void addTasks(Task task) {
    _enteredTasks.add(task);
    taskBox?.add(task);
    notifyListeners();
  }

 void removeTasks(Task task) {
  _enteredTasks.remove(task);
  taskBox?.delete(task.key); 
  notifyListeners();
}

  void deleteAction(BuildContext context, Task task, int index) {
    ScaffoldMessenger.of(context).clearSnackBars;
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
    notifyListeners();
  }


 void removeCompletedTasks() {
    _enteredTasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
  }

  void undoDeleteTasks(int index, Task task) {
    _enteredTasks.insert(index, task);
    taskBox?.put(index, task);
    notifyListeners();
  }
}
