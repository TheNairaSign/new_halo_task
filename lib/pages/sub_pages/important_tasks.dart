import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_halo_task/models/task_models/task.dart';
import 'package:provider/provider.dart';

import 'package:new_halo_task/dashboard/appbar.dart';
import 'package:new_halo_task/provider/task_provider.dart';
import 'package:new_halo_task/widgets/drawer.dart';
import 'package:new_halo_task/widgets/task_widgets/list_item.dart';

class ImportantTasks extends StatefulWidget {
  const ImportantTasks({super.key});

  @override
  State<ImportantTasks> createState() => _ImportantTasksState();
}

class _ImportantTasksState extends State<ImportantTasks> {
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
    final importantTasks = taskProvider.enteredTasks.where((task) => task.isImportant).toList();

    return Consumer(
      builder: (context, tasProv, child) => Scaffold(
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Text(
                  importantTasks.length == 1
                      ? "You have ${importantTasks.length} important task"
                      : "You have ${importantTasks.length} important tasks",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: importantTasks.length,
                  itemBuilder: (context, index) {
                    return TasksItem(
                      importantTasks,
                      index: index,
                      removeNote: () {},
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
