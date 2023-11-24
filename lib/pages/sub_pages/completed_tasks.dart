import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_halo_task/models/task_models/task.dart';
import 'package:provider/provider.dart';

import 'package:new_halo_task/dashboard/appbar.dart';
import 'package:new_halo_task/provider/task_provider.dart';
import 'package:new_halo_task/widgets/drawer.dart';
import 'package:new_halo_task/widgets/task_widgets/list_item.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  void initState() {
    super.initState();
    _loadTasksFromHive();
  }

  Future<void> _loadTasksFromHive() async {
    final provider = context.read<TaskProvider>();

    // Open the Hive box and read tasks
    final taskBox = await Hive.openBox<Task>('tasks');
    provider.updateTasks(taskBox.values.toList()); // Use the updateTasks method
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.read<TaskProvider>();
    final completedTasks = taskProvider.enteredTasks.where((task) => task.isCompleted).toList();

    return Consumer(
      builder: (context, tasProv, child) => Scaffold(
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  completedTasks.length == 1
                      ? "You have ${completedTasks.length} completed task"
                      : "You have ${completedTasks.length} completed tasks",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    return TasksItem(
                      completedTasks, 
                      index: index,
                      removeNote: () {
                        taskProvider.removeCompletedTasks();
                      },
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
