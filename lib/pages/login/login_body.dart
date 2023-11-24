// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_halo_task/pages/signup_page.dart';
import 'package:new_halo_task/widgets/text_fields/email_text_field.dart';
import 'package:new_halo_task/widgets/text_fields/password_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:new_halo_task/themes/themes.dart';
import 'package:new_halo_task/widgets/check_box.dart';
import 'package:new_halo_task/widgets/pink_text_button.dart';
import 'package:new_halo_task/provider/auth_providers/login_provider.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, loginProvider, child) {
      return SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                Text(
                  "Log in to your account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 45,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: SvgPicture.asset("assets/svg/user-image.svg"),
                ),
                const SizedBox(
                  height: 30,
                ),
                EmailTextField(emailController: loginProvider.loginEmailController),
                const SizedBox(height: 10,),
                PasswordTextField(passwordController: loginProvider.loginPasswordController),
                const SizedBox(
                  height: 20,
                ),
                CheckedBox(
                  text: "Remember Me",
                  onChecked: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                PinkTextButton(
                  buttonContent: "Log in",
                  onPressed: () {
                    loginProvider.logIn(context);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage())),
                      child: Text(
                        "Sign up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
