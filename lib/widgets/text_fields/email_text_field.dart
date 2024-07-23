// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_halo_task/provider/auth_providers/sign_up_provider.dart';
import 'package:provider/provider.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.emailController,
  });
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      enabled: true,
      onChanged: (value) => debugPrint("Email Input"),
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
          Icons.mail,
          color: Colors.grey[600],
        ),
        hintText: "Email",
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
      validator: (value) {
        final signUpProv = context.read<SignUpProvider>();
        if (value == null || value.isEmpty) {
            return 'Please enter an email';
          } else if (!signUpProv.isValidEmail(value)) {
            return 'Please enter a valid email';
          }
          return null;
      },
      onSaved: (newValue) {
        newValue = "";
      },
    );
  }
}
