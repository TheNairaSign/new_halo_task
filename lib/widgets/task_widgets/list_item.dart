import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_halo_task/models/task_models/task.dart';
import 'package:new_halo_task/themes/themes.dart';

class TasksItem extends StatefulWidget {
  const TasksItem(this.task, {super.key});

  final Task task;

  @override
  State<TasksItem> createState() => _TasksItemState();
}

class _TasksItemState extends State<TasksItem> {
  final List<Task> tasks = [];

  void onDeleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void completedTasks(Task completedTasks) {
    setState(() {
      tasks.add(completedTasks);
    });
  }

  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Card(
        color: completed == true ? Colors.grey : Colors.white,
        elevation: completed ? 0 : 2,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 5,
            right: 5,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      print("Delete task");
                      onDeleteTask(widget.task);
                    } ,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                      size: 17,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    widget.task.taskName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.teal,
                        ),
                  ),
                  Icon(
                    categoryIcons[widget.task.category],
                    size: 13,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.task.description,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  // color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      widget.task.formattedDate,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: completed == true
                              ? MaterialStateProperty.all(Colors.grey[600])
                              : MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            completed = !completed;
                          });
                        },
                        child: Text(
                          completed == true ? "Completed" : "Mark as Done",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> deleteButton(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.transparent,
                ),
              ),
              child: const Text("Cancel"),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              onPressed: () {              },
              child: const Text("Okay"),
            ),
          ],
          content: Text(
            "Are you sure you want to delete this task?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
