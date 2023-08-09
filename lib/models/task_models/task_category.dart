import 'package:flutter/material.dart';

class TaskCategory extends StatelessWidget {
  const TaskCategory({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap
  });

  final IconData icon;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          onTap;
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Icon(
                icon,
                color: Colors.teal,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
