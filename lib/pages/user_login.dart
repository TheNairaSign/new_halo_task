import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_halo_task/auth/login_auth_page.dart';

import 'package:new_halo_task/components/alert_dialog.dart';
import 'package:new_halo_task/dashboard/dashboard.dart';
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
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  @override
  void dispose() {
    _loginEmailController;
    _loginPasswordController;
    // TODO: implement dispose
    super.dispose();
  }

  void logIn() async {
    checkEntry(context);
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmailController.text,
        password: _loginPasswordController.text,
      );
    } on FirebaseAuthException catch (e) {
      // print(e);
      if (e.code == "user-not-found") {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: ((context) {
              return const MyAlertDialog(contentText: "Username not found");
            }));
      } else {
        print(e);
        print("Password not found");
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: ((context) {
              return const MyAlertDialog(contentText: "Password not found");
            }));
      }
    }
    Navigator.of(context).push(MaterialPageRoute(builder:(context) => const LoginAuth()));
    Navigator.of(context).pop();
  }

  void checkEntry(BuildContext context) {
    if (_loginEmailController.text.isEmpty ||
        _loginPasswordController.text.isEmpty) {
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
      logIn();
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
              firstInput(context),
              const SizedBox(
                height: 20,
              ),
              secondInput(context),
              const CheckedBox(text: "Remember Me",),
              PinkTextButton(
                buttonContent: "Log in",
                onPressed: () {
                  // checkEntry(context);
                  logIn();
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginAuth()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputField secondInput(BuildContext context) {
    return InputField(
      fillColor: const Color.fromARGB(116, 158, 158, 158),
      hintText: "Password",
      hintTextColor: Colors.grey[600],
      prefixIcon: Icons.lock,
      iconColor: Colors.grey[600],
      textColor: Theme.of(context).iconTheme.color,
      obscureText: true,
      controller: _loginPasswordController,
    );
  }

  InputField firstInput(BuildContext context) {
    return InputField(
      fillColor: const Color.fromARGB(116, 158, 158, 158),
      hintText: "Email",
      hintTextColor: Colors.grey[600],
      prefixIcon: Icons.mail_rounded,
      iconColor: Colors.grey[600],
      textColor: Theme.of(context).iconTheme.color,
      obscureText: false,
      controller: _loginEmailController,
    );
  }
}
