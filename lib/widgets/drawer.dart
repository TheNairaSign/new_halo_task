// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:new_halo_task/dashboard/dashboard.dart';
import 'package:new_halo_task/models/task_models/task_category.dart';
import 'package:new_halo_task/notes/notes.dart';
import 'package:new_halo_task/pages/sub_pages/completed_tasks.dart';
import 'package:new_halo_task/pages/sub_pages/favorites_page.dart';
import 'package:new_halo_task/pages/sub_pages/important_tasks.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, bottom: 50),
                child: Text(
                  "Halo Task",
                  style: GoogleFonts.poppins(
                    color: Colors.teal,
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          taskColumn(
            context,
            Colors.teal,
            "Tasks",
            () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
              );
            },
            Icons.format_list_bulleted,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TaskCategory(
                icon: Icons.notifications_none_outlined,
                text: "Important",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const ImportantTasks()),
                    ),
                  );
                },
              ),
              TaskCategory(
                icon: Icons.access_time_outlined,
                text: "Pending",
                onTap: () {
                  // print("Pending");
                },
              ),
              TaskCategory(
                icon: Icons.check,
                text: "Completed",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CompletedTasks(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          taskColumn(
            context,
            Colors.teal,
            "Notes",
            () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Notes(),
                ),
              );
            },
            Icons.sticky_note_2_outlined,
          ),
          TaskCategory(
            icon: Icons.star_border,
            text: "Starred Notes",
            onTap: () {
              debugPrint("StarredNotes");
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StarredNotes()));
            },
          ),
        ],
      ),
    );
  }
}

GestureDetector taskColumn(
  BuildContext context,
  Color? orange,
  String text,
  void Function() onTap,
  IconData icon,
) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 5),
                child: Icon(
                  icon,
                  color: orange,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 0.2,
          ),
        ],
      ),
    ),
  );
}
