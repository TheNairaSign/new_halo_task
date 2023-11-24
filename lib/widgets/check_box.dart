import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:new_halo_task/themes/themes.dart';

class CheckedBox extends StatefulWidget {
  const CheckedBox({super.key, required this.text, required this.onChecked});
  final String text;
  final void Function(bool value) onChecked;
  @override
  State<CheckedBox> createState() => CheckedBoxState();
}
class CheckedBoxState extends State<CheckedBox> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: "",
        contentPadding: const EdgeInsets.only(left: 70, right: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          ),
        side: BorderSide(
          color: primaryColor,
          width: 2,
        ),
        activeColor: primaryColor,
        controlAffinity: ListTileControlAffinity.leading,
        checkColor: Colors.white,
        title: Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:Colors.black),
        ),
        onChanged: (value) {
          setState(() {
            tapped = value!;
            widget.onChecked(value);
          });
        });
  }
}