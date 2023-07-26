import 'package:flutter/material.dart';
import 'package:new_halo_task/pages/signup_page.dart';

class CheckedBox extends StatefulWidget {
  const CheckedBox({super.key});
  @override
  State<CheckedBox> createState() => CheckedBoxState();
}
class CheckedBoxState extends State<CheckedBox> {
  @override
  Widget build(BuildContext context) {
        return CheckboxListTile(
      splashRadius: 0,
      visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.only(left: 85, right: 85),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
        side: const BorderSide(
          color: Colors.pink,
          width: 2,
        ),
        activeColor: Colors.pink,
        controlAffinity: ListTileControlAffinity.leading,
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        checkColor: Colors.white,
        title: Text(
          "Remember me",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        value: tapped,
        onChanged: (value) {
          setState(() {
            tapped = value!;
            // TODO: Create a function to accept the tap on the individual checkboxes
          });
        });
  }
}