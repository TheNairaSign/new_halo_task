import 'package:flutter/material.dart';

import 'package:new_halo_task/themes/themes.dart';
import 'package:new_halo_task/widgets/check_box.dart';
import 'package:new_halo_task/widgets/input_field.dart';
import 'package:new_halo_task/widgets/text_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.showSignUpPage});
  final VoidCallback showSignUpPage;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool tapped = false;

  @override
  void dispose() {
    _usernameController;
    _emailController;
    _passwordController;
    // TODO: implement dispose
    super.dispose();
  }

  Future signUp() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
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
                controller: _usernameController,
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
                controller: _emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                fillColor: const Color.fromARGB(116, 158, 158, 158),
                hintText: "Password",
                hintTextColor: Colors.grey[600],
                prefixIcon: Icons.lock,
                iconColor: Colors.grey[600],
                textColor: Theme.of(context).iconTheme.color,
                obscureText: tapped == false ? true : true,
                controller: _passwordController,
              ),
              const CheckedBox(),
              PinkTextButton(
                onPressed: signUp,
                buttonContent: "Sign up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
