// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.emailController,
  }) : super(key: key);
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: "email-input",
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
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.email(),
        ],
      ),
    );
  }
}
