// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_halo_task/auth/login_auth_page.dart';
import 'package:new_halo_task/components/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_halo_task/themes/themes.dart';
import 'package:new_halo_task/widgets/custom_alert_dialog.dart.dart';
import 'package:provider/provider.dart';

import '../note_provider.dart';
import '../task_provider.dart';

class LoginProvider extends ChangeNotifier {
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firebase = FirebaseAuth.instance;

  String get email => loginEmailController.text.trim();
  String get password => loginPasswordController.text.trim();

  @override
  void dispose() {
    super.dispose();
    loginEmailController;
    loginPasswordController;
  }

  Future<void> signUserOut(BuildContext ctx) async {
    FirebaseAuth.instance.signOut();

    // Optional: Clear the providers' data manually
    final taskProvider = Provider.of<TaskProvider>(ctx, listen: false);
    final noteProvider = Provider.of<NoteProvider>(ctx, listen: false);
    await taskProvider.closeHive();
    await noteProvider.closeHive();

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

  void logUserActivity(String action) {
    final String userId = firebase.currentUser!.uid;
    firestore.collection('user_activity').add({
      'user_id': userId,
      'action': action,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void logIn(BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const MyAlertDialog(
          contentText: "TextFields cannot be empty",
        ),
      );
      return; // Exit the function if fields are empty
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents dismissing the dialog
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        },
      );

      // Attempt to sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Close the loading indicator
      Navigator.of(context).pop();

      // Proceed to the next screen or show success message
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginAuth())); // Example navigation
    } catch (e) {
      // Close the loading indicator if an error occurs
      Navigator.of(context).pop();

      // Handle different types of errors
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'user-disabled':
            errorMessage = 'The user has been disabled.';
            break;
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
            break;
          case 'network-request-failed':
            errorMessage = 'A network error occurred. Please check your internet connection and try again.';
            break;
          default:
            errorMessage = 'An unexpected error occurred. Please try again.';
        }
      } else {
        errorMessage = 'An unknown error occurred. Please try again.';
      }

      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          consent: "OK",
          content: errorMessage,
          onConsent: () {},
        ),
      );

      debugPrint("FirebaseException on Login: $e");
    }
  }
}
