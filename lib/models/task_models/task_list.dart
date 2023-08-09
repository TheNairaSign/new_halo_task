import 'package:flutter/material.dart';
import 'package:new_halo_task/models/task_models/task.dart';
import 'package:new_halo_task/themes/themes.dart';
import 'package:new_halo_task/widgets/task_widgets/list_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasks, required this.onRemoveTask, required this.onUndoDelete,});

  final List<Task> tasks;
  final void Function(Task task) onRemoveTask;
  final void Function(Task task, int index) onUndoDelete;

  @override
  Widget build(BuildContext context) {
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
              return _myDismissable(index, context);
            }),
          );    
    return content;
  }

  void _removedSnackbar(BuildContext context, int index, Task task) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        duration: const Duration(seconds: 3),
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
                // ScaffoldMessenger.of(context).clearSnackBars();
                onUndoDelete(task, index);
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
  }

  Dismissible _myDismissable(int index, BuildContext context) {
    return Dismissible(
      background: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.star,
            size: 50,
          ),
        ),
      ),
      key: ValueKey(tasks[index]),
      onDismissed: (direction) {
        _removedSnackbar(context, index, tasks[index]);
        onRemoveTask(tasks[index]);
      },
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.delete_forever,
            size: 50,
          ),
        ),
      ),
      child: TasksItem(tasks[index]),
    );
  }

}