import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:new_halo_task/models/task_models/task.dart';
import 'package:new_halo_task/provider/task_provider.dart';
import 'package:new_halo_task/widgets/task_widgets/list_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final _ = context.read<TaskProvider>();
    Widget content = tasks.isEmpty == true
        ? Center(
            child: Text(
              "Tap the button below to add a new task",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: ((context, index) {
              return TasksItem(
                tasks,
                index: index,
                removeNote: () => _.deleteAction(context, tasks[index], index),
              );
            }),
          );
    return content;
  }
}
