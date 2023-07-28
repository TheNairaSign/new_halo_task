import 'package:flutter/material.dart';
import 'package:new_halo_task/pages/login_page.dart';
import 'package:new_halo_task/pages/signup_page.dart';

class SignUpAuth extends StatefulWidget {
  const SignUpAuth({super.key});

  @override
  State<SignUpAuth> createState() => _SignUpAuthState();
}

class _SignUpAuthState extends State<SignUpAuth> {
  bool showLoginPage = true;

  void toggleScreens() {
    showLoginPage = !showLoginPage;
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showLoginPage: toggleScreens,);
    } else {
      return SignUpPage(showSignUpPage: toggleScreens,);
    }
  }
}