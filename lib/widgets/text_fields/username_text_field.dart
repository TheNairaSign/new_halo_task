// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_halo_task/provider/auth_providers/sign_up_provider.dart';
import 'package:provider/provider.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    super.key,
    required this.usernameController,
  });
  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: usernameController,
      enabled: true,
      onChanged: (value) => debugPrint("Username Input"),
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
          Icons.person,
          color: Colors.grey[600],
        ),
        hintText: "Username",
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
        final snp = context.read<SignUpProvider>();
        return snp.usernameValidator(value);
      },
      onSaved: (value) {
        value = "";
        }
    );
  }
}
