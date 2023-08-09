import 'package:flutter/material.dart';
import 'package:new_halo_task/themes/themes.dart';

class MyAlertDialog extends StatefulWidget {
  const MyAlertDialog({super.key, required this.contentText});

  final String contentText;

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide.none,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Okay",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
          ],
          content: Text(
            widget.contentText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
  }
}