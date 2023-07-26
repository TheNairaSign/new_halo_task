import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_halo_task/pages/user_login.dart';

import 'package:new_halo_task/themes/themes.dart';
import 'package:new_halo_task/widgets/check_box.dart';
import 'package:new_halo_task/widgets/input_field.dart';
import 'package:new_halo_task/widgets/text_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  void correctText(BuildContext context) {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide.none,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Okay",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
          ],
          content: Text(
            "TextFields must not be empty",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    } 
    // else if(usernameController.text.contains(RegExp("A-Z")) ) {
    //   print("Cannot contain x, y or z");
    // }
    else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>  UserLoginPage(),
        ),
      );
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Create your Account",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.headlineLarge!.color,
                    ),
                textAlign: TextAlign.start,
                softWrap: true,
              ),
              const SizedBox(
                height: 50,
              ),
              InputField(
                fillColor: const Color.fromARGB(116, 158, 158, 158),
                hintText: "Username",
                hintTextColor: Colors.grey[600],
                prefixIcon: Icons.person,
                iconColor: Colors.grey[600],
                textColor: Theme.of(context).iconTheme.color,
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                fillColor: const Color.fromARGB(116, 158, 158, 158),
                hintText: "Email",
                hintTextColor: Colors.grey[600],
                prefixIcon: Icons.mail,
                iconColor: Colors.grey[600],
                textColor: Theme.of(context).iconTheme.color,
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                fillColor: const Color.fromARGB(116, 158, 158, 158),
                hintText: "Password",
                hintTextColor:Colors.grey[600],
                prefixIcon: Icons.lock,
                iconColor: Colors.grey[600],
                textColor: Theme.of(context).iconTheme.color,
                obscureText: tapped == false ? true : true,
                controller: passwordController,
              ),
              const CheckedBox(),
              PinkTextButton(
                onPressed: () {
                  correctText(context);
                  // signIn();
                },
                buttonContent: "Sign up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextEditingController usernameController = TextEditingController(text: "tonye");
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool tapped = false;
