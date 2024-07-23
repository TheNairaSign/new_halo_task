import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_providers/sign_up_provider.dart';
import '../themes/themes.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.validator,
    this.includeSuffix = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.name
  });
  final String hint;
  final TextEditingController controller;
  bool obscureText;
  final TextInputType keyboardType;
  final bool includeSuffix;
  final String? Function(String?) validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldConsumerState();
}

class _CustomTextFieldConsumerState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final formKey = context.read<SignUpProvider>();

    return TextFormField(
      cursorColor: primaryColor,
      validator: widget.validator,
      enabled: true,
      obscureText: widget.obscureText,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        suffixIcon: widget.includeSuffix == true
            ? GestureDetector(
              onTap: () {
                setState(() {
                  widget.obscureText = !widget.obscureText;
                });
              },
              child: Icon(
                widget.obscureText == true ?
                  Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                  color: Colors.grey.withOpacity(0.7),
                ),
            ) : null,
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.7),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red)
        ),
      ),
      onSaved: (newValue) {
        newValue = widget.controller.text.trim();
        setState(() {
        // ref.read(validatorNotifier.notifier).saveForm(ref);
        // formKey.currentState!.validate();
        });
        debugPrint("newValue: $newValue");
        }
    );
  }
}