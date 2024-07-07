import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_halo_task/models/task_models/task.dart';
import 'package:new_halo_task/models/task_models/task_list.dart';
import 'package:new_halo_task/pages/sub_pages/add_tasks_page.dart';
import 'package:new_halo_task/provider/task_provider.dart';
import 'package:provider/provider.dart';

class TaskBuilder extends StatefulWidget {
  const TaskBuilder({super.key});

  @override
  State<TaskBuilder> createState() => _TaskBuilderState();
}

class _TaskBuilderState extends State<TaskBuilder> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _loadTasksFromHive();
    }
  }

  void signOut() {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint('Sign out error: $e');
    }
  }

  void _openTaskPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddTasksPage(
          onAddTask: (task) {
            final adder = context.read<TaskProvider>();
            adder.addTask(task);
            _saveTaskToHive(task);
          },
        ),
      ),
    );
  }

  Future<void> _loadTasksFromHive() async {
    if (_user == null) return;

    final provider = context.read<TaskProvider>();

    // Open the Hive box for the specific user
    final taskBox = await Hive.openBox<Task>('tasks_${_user!.uid}');
    provider.updateTasks(taskBox.values.toList());
  }

  Future<void> _saveTaskToHive(Task task) async {
    if (_user == null) return;

    final taskBox = await Hive.openBox<Task>('tasks_${_user!.uid}');
    taskBox.add(task);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                provider.enteredTasks.length == 1
                    ? "You have ${provider.enteredTasks.length} task"
                    : "You have ${provider.enteredTasks.length} tasks",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: TasksList(
                      tasks: provider.enteredTasks,
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
      ),
    );
  }
}
