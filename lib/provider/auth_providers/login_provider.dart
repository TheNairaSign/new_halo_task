// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_halo_task/auth/login_auth_page.dart';
import 'package:new_halo_task/components/alert_dialog.dart';
import 'package:new_halo_task/themes/themes.dart';

class LoginProvider extends ChangeNotifier {
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  String get email => loginEmailController.text.trim();
  String get password => loginPasswordController.text.trim();

  @override
  void dispose() {
    super.dispose();
    loginEmailController;
    loginPasswordController;
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  void errorDialog(BuildContext context, String errorCode) {
    showDialog(
      context: context,
      builder: ((context) => MyAlertDialog(
            contentText: errorCode,
          )),
    );
    notifyListeners();
  }

  void logIn(BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const MyAlertDialog(
          contentText: "TextFields cannot be empty",
        ),
      );
    } else {
      try {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          },
        );

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

      } on FirebaseAuthException {
        Navigator.of(context).pop();
        // debugPrint(e.code);

        showAboutDialog(context: context);

      } finally {
        Navigator.of(context).pop(); // Remove the loading indicator
        loginEmailController.clear();
        loginPasswordController.clear();
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginAuth(),
        ),
      );
    }
    notifyListeners();
  }
}
