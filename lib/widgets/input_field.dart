import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.fillColor,
    required this.hintText,
    required this.hintTextColor,
    required this.prefixIcon,
    required this.iconColor,
    required this.textColor,
    required this.obscureText,
    required this.controller,
  });

  final Color? fillColor, hintTextColor, textColor, iconColor;
  final IconData prefixIcon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool tapped = false;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: widget.controller,
        enabled: true,
        obscureText: tapped == true ? tapped = true : tapped = false,
        style: TextStyle(
          color: widget.textColor,
          decoration: TextDecoration.none,
        ),
        cursorColor: Theme.of(context).iconTheme.color,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.40),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: widget.iconColor,
          ),
          suffixIcon: widget.obscureText == false
              ? null
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      print("Show password");
                      tapped = !tapped;
                    });
                  },
                  child: tapped
                      ? Icon(
                        Icons.remove_red_eye,
                          color: Colors.grey[600],
                        )
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.grey[600],
                        ),
                ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.hintTextColor,
          ),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.pink,),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey,),
          ),
        ),
      ),
    );
  }
}
