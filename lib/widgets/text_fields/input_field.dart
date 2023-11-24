// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:new_halo_task/provider/auth_providers/sign_up_provider.dart';

import 'package:new_halo_task/widgets/text_fields/email_text_field.dart';
import 'package:new_halo_task/widgets/text_fields/password_text_field.dart';
import 'package:new_halo_task/widgets/text_fields/username_text_field.dart';
import 'package:provider/provider.dart';

class SignUpInputField extends StatefulWidget {
  const SignUpInputField({
    Key? key,
    required this.globalKey,
  }) : super(key: key);

  final Key? globalKey;

  @override
  State<SignUpInputField> createState() => _SignUpInputFieldState();
}

class _SignUpInputFieldState extends State<SignUpInputField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, signUpProv, child) {
        return SizedBox(
          height: 210,
          child: Form(
            key: widget.globalKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                UsernameTextField(
                  usernameController: signUpProv.usernameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                EmailTextField(
                  emailController: signUpProv.emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                PasswordTextField(
                  passwordController: signUpProv.passwordController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
