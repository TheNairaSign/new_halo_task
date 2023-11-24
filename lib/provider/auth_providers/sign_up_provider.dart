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
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    usernameController.dispose();
  }

  Future<void> storeUserDataInFirestore(String userData) async {
    debugPrint("Storing Data in DB...");
    try {
      Map<String, String> userData = {
        'email': email,
        'displayName': userName,
      };
      _firestore.collection("User").add(userData).then(
          (DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'));
      // debugPrint("User added");
    } catch (e) {
      debugPrint('Error storing user data in Firestore: $e');
    }
    notifyListeners();
    // Create a new user with a first and last name
    await _firestore.collection("Users").get().then((event) {
      for (var doc in event.docs) {
        print("j${doc.id} => ${doc.data()}");
      }
    });
    notifyListeners();
  }

  Future signUp(BuildContext context) async {
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
      }

      storeUserDataInFirestore(user!.uid);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    } finally {
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const UserLoginPage(),
      ),
    );
    notifyListeners();
  }

  String? usernameValidator(String? value) {
    if (value!.length < 3) {
      return "$value cannot be less than 3";
    }
    if (value.contains(RegExp(r"[0-9]"))) {
      return "Username must contain only alphabets";
    }
    if (value.contains(r"[`~!@#$%^&*()_+=.,/?.,]")) {
      return "Username must not contain special characters";
    }
    notifyListeners();
    return value.toLowerCase().trim();
  }
}
