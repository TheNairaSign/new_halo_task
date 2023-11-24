// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:new_halo_task/provider/auth_providers/sign_up_provider.dart';
import 'package:new_halo_task/themes/themes.dart';
import 'package:new_halo_task/widgets/check_box.dart';
import 'package:new_halo_task/widgets/pink_text_button.dart';
import 'package:new_halo_task/widgets/text_fields/input_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (ctx, signUpProv, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Create your Account",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 45,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).textTheme.headlineLarge!.color,
                        ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SignUpInputField(
                    globalKey: signUpProv.globalKey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CheckedBox(
                    text: "Remember Me",
                    onChecked: (value) {},
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PinkTextButton(
                    onPressed: () {
                      signUpProv.signUp(context);
                    },
                    buttonContent: "Sign up",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a user?",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
