import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:new_halo_task/pages/signup_page.dart';
import 'package:new_halo_task/widgets/check_box.dart';
import 'package:new_halo_task/widgets/input_field.dart';
import 'package:new_halo_task/widgets/text_button.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({
    super.key,
  });

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  // final bool pasteDetails = false;
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  void signIn() async {
    showDialog(context: context, builder: (context) {
      return const Center (
        child: CircularProgressIndicator(
          color: Colors.pink,
        ),
      );
    });
    try {

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginEmailController.text,
      password: loginPasswordController.text,
    );
    } on FirebaseAuthException catch (e) {
      // print(e);
      if (e.code == "user-not-found") {
        Navigator.of(context).pop();
      }
      else {
        print(e);
      }
    }
    Navigator.of(context).pop();
  }

  void checkEntry(BuildContext context) {
 if (loginEmailController.text.isEmpty ||
        loginPasswordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text("TextFields should not be null"),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Okay",
              ),
            ),
          ],
        ),
      );
    } else {
      signIn();
    }
      print("Login tapped");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Log in to your account",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 45,
                    ),
              ),
              const SizedBox(
                height: 50,
              ),
              InputField(
                key: ValueKey(emailController),
                fillColor: const Color.fromARGB(116, 158, 158, 158),
                hintText: "Email",
                hintTextColor: Colors.grey[600],
                prefixIcon: Icons.mail_rounded,
                iconColor: Colors.grey[600],
                textColor: Theme.of(context).iconTheme.color,
                obscureText: false,
                controller: loginEmailController
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                key: ValueKey(passwordController),
                fillColor: const Color.fromARGB(116, 158, 158, 158),
                hintText: "Password",
                hintTextColor: Colors.grey[600],
                prefixIcon: Icons.lock,
                iconColor: Colors.grey[600],
                textColor: Theme.of(context).iconTheme.color,
                obscureText: true,
                controller: loginPasswordController
              ),
              const CheckedBox(),
              PinkTextButton(
                buttonContent: "Log in",
                onPressed: signIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
