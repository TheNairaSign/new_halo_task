import 'package:flutter/material.dart';

class CheckedBox extends StatefulWidget {
  const CheckedBox({super.key, required this.text});
  final String text;
  @override
  State<CheckedBox> createState() => CheckedBoxState();
}
class CheckedBoxState extends State<CheckedBox> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
        return CheckboxListTile(
      splashRadius: 0,
      visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.only(left: 70, right: 0),
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
          widget.text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:Colors.black),
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