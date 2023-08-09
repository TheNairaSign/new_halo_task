import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_halo_task/dashboard/dashboard.dart';

import 'package:new_halo_task/models/task_models/task.dart';
import 'package:new_halo_task/models/task_models/task_list.dart';
import 'package:new_halo_task/pages/sub_pages/add_tasks_page.dart';
import 'package:new_halo_task/pages/sub_pages/important_tasks.dart';

class TaskBuilder extends StatefulWidget {
  const TaskBuilder({super.key});

  @override
  State<TaskBuilder> createState() => _TaskBuilderState();
}

class _TaskBuilderState extends State<TaskBuilder> {
  void signOut() {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Sign out error: $e');
    }
  }
  final List<Task> _enteredTasks = [];

  void _openTaskPage() {
   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTasksPage(onAddTask: _addTasks)));
  }

  void _addTasks(Task task) {
    setState(() {
      _enteredTasks.add(task);
    });
  }

  void _removeTask(Task task) {
    setState(() {
      _enteredTasks.remove(task);
    });
  }

  void _undoDelete(Task task, int index) {
    setState(() {
      _enteredTasks.insert(index, task);
    });
  }

  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              _enteredTasks.length == 1
                  ? "You have ${_enteredTasks.length} task"
                  : "You have ${_enteredTasks.length} tasks",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: TasksList(
                    tasks: _enteredTasks,
                    onRemoveTask: _removeTask,
                    onUndoDelete: _undoDelete,
                  ),
                ),
                FloatingActionButton.extended(
                  foregroundColor:
                      Theme.of(context).drawerTheme.backgroundColor,
                  label: Text(
                    "Add Task",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  onPressed: _openTaskPage,
                  elevation: 0,
                  enableFeedback: true,
                  backgroundColor: Colors.teal, 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final List<Task> _favoriteTasks = [];

  void _addFavorite(Task task) {
    _favoriteTasks.add(task);
  }
  void _removeFavorite(Task task) {
    _favoriteTasks.remove(task);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              _favoriteTasks.length == 1
                  ? "You have ${_favoriteTasks.length} task"
                  : "You have ${_favoriteTasks.length} tasks",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: TasksList(
                    tasks: _favoriteTasks,
                    onRemoveTask: _removeFavorite,
                    onUndoDelete: (task, index) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}