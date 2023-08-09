import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:new_halo_task/components/alert_dialog.dart';
import 'package:new_halo_task/models/task_models/task.dart';
import 'package:new_halo_task/themes/themes.dart';
import 'package:new_halo_task/widgets/check_box.dart';
import 'package:new_halo_task/widgets/text_button.dart';

class AddTasksPage extends StatefulWidget {
  const AddTasksPage({super.key, required this.onAddTask});

  final void Function(Task task) onAddTask;

  @override
  State<AddTasksPage> createState() => _AddTasksPageState();
}

class _AddTasksPageState extends State<AddTasksPage> {
  final taskNameController = TextEditingController();

  final taskDescController = TextEditingController();

  DateTime? _selectedDate;

  void _submitTaskData() {
    if (taskNameController.text.trim().isEmpty ||
        taskDescController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => const MyAlertDialog(contentText: "TextFields must not be empty",),
      );
      return;
    }
    widget.onAddTask(
      Task(
        taskName: taskNameController.text,
        description: taskDescController.text,
        date: _selectedDate!,
        category: Category.important,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _addTaskModalOverlay(context),
    );
  }

  SingleChildScrollView _addTaskModalOverlay(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 30, 15, 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 35,
        ),
        height: 650,
        width: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Task",
              style: GoogleFonts.poppins(
                fontSize: 50,
                color: Colors.grey[900],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 40),
              child: textEditingColumn(
                taskNameController,
                "Task Name",
                "Task Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: textEditingColumn(
                taskDescController,
                "Task Description",
                "Task Description",
              ),
            ),
            text("Due Date"),
            const SizedBox(
              height: 10,
            ),
            dueDate(),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CheckedBox(text: "Important",),
                ),
              ],
            ),
            PinkTextButton(
              onPressed: () {
                _submitTaskData();
              },
              buttonContent: "Add Task",
            )
          ],
        ),
      ),
    );
  }

  SizedBox dueDate() {
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: _datePicker,
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: "Add Date here",
            hintStyle: TextStyle(
              color: Colors.grey[600]
            ),
            contentPadding: const EdgeInsets.all(10),
            fillColor: Colors.white,
            filled: true,
            suffixIcon: Row(
              children: [
                Text(
                  _selectedDate == null
                      ? "  No Date Selected"
                      : "  ${formatter.format(_selectedDate!)}",
                      style: const TextStyle(color: Colors.black,),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ],
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column textEditingColumn(
    TextEditingController controller,
    String tagName,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(tagName),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: TextField(
            style: const TextStyle(
              color: Colors.black,
            ),
            // onChanged: _saveInput,
            controller: controller,
            cursorColor: primaryColor,
            showCursor: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              fillColor: Colors.white,
              filled: true,
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Colors.grey[600],
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Text text(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 17,
      color: primaryColor
    ),
  );
}
