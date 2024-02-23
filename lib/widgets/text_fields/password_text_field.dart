// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:new_halo_task/themes/themes.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);
  final TextEditingController passwordController;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool tapped = true;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: "password-textfield",
      controller: widget.passwordController,
      onChanged: (value) => debugPrint("Password Input"),
      enabled: true,
      obscureText: tapped ? true : false,
      style: TextStyle(
        color: Theme.of(context).iconTheme.color,
        decoration: TextDecoration.none,
      ),
      cursorColor: Theme.of(context).iconTheme.color,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.40),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey[600],
        ),
        suffixIcon: IconButton(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(
              primaryColor.withOpacity(0.40),
            ),
          ),
          onPressed: () {
            setState(() {
              tapped = !tapped;
            });
          },
          icon: Icon(
            tapped ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
          ),
        ),
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.grey[600],
        ),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.pink,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
