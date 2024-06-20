// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:new_halo_task/pages/user_login.dart';

class SignUpProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;

  final _globalKey = GlobalKey<FormBuilderState>();
  GlobalKey get globalKey => _globalKey;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get userName => usernameController.text.trim();
  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> storeUserDataInFirestore(String userId) async {
    debugPrint("Storing Data in DB...");
    try {
      Map<String, String> userData = {
        'email': email,
        'displayName': userName,
      };
      await _firestore.collection("users").doc(userId).set(userData);
      debugPrint('DocumentSnapshot added with ID: $userId');
    } catch (e) {
      debugPrint('Error storing user data in Firestore: $e');
    }
  }

  Future<void> signUp(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(userName);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        await storeUserDataInFirestore(user!.uid);
      }

      usernameController.clear();
      emailController.clear();
      passwordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserLoginPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('Error: ${e.code}');
    }
    notifyListeners();
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    }
    if (value.length < 3) {
      return "$value cannot be less than 3 characters";
    }
    if (value.contains(RegExp(r"[0-9]"))) {
      return "Username must contain only alphabets";
    }
    if (value.contains(RegExp(r"[`~!@#$%^&*()_+=.,/?.,]"))) {
      return "Username must not contain special characters";
    }
    return null;
  }
}
