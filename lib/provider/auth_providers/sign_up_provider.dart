// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive/hive.dart';
import 'package:new_halo_task/pages/user_login.dart';
import 'package:provider/provider.dart';

import '../../models/note_model/note_model.dart';
import '../../models/task_models/task.dart';
import '../note_provider.dart';
import '../task_provider.dart';

class SignUpProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;

  final _globalKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> get globalKey => _globalKey;

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
    try {
      Map<String, dynamic> userData = {
        'email': email,
        'displayName': userName,
        // Add additional user data fields as needed
      };
      await _firestore.collection("users").doc(userId).set(userData);
      debugPrint('User data stored successfully for user ID: $userId');
    } catch (e) {
      debugPrint('Error storing user data in Firestore: $e');
      rethrow; // Rethrow the error for proper handling in the sign-up process
    }
  }

  Future<void> _initializeUserHiveBoxes(User? user, BuildContext ctx) async {
    if (user != null) {
      try {
        // Initialize task box
        Box<Task> taskBox = await Hive.openBox<Task>("tasks_${user.uid}");
        // You might want to initialize the task provider with the new box
        // Make sure TaskProvider is registered in your provider setup
        Provider.of<TaskProvider>(ctx, listen: false).taskBox = taskBox;

        // Initialize note box
        Box<NoteModel> noteBox = await Hive.openBox<NoteModel>("notes_${user.uid}");
        // You might want to initialize the note provider with the new box
        // Make sure NoteProvider is registered in your provider setup
        Provider.of<NoteProvider>(ctx, listen: false).noteBox = noteBox;

        // Notify listeners to update UI or any other necessary actions
        notifyListeners();
      } catch (e) {
        debugPrint("Error initializing user-specific Hive boxes: $e");
      }
    }
  }
  Future<void> signUp(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(userName);
        await user.reload();
        await storeUserDataInFirestore(user.uid);
        
        await _initializeUserHiveBoxes(user, context);
      }

      // Clear text controllers after successful sign-up
      usernameController.clear();
      emailController.clear();
      passwordController.clear();

      // Navigate to login page after successful sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserLoginPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.code}');
      rethrow; // Rethrow the error for proper handling in the sign-up process
    } on FirebaseException catch (e) {
      debugPrint('Firebase Error: $e');
      rethrow; // Rethrow the error for proper handling in the sign-up process
    } catch (e) {
      debugPrint('Error: $e');
      rethrow; // Rethrow the error for proper handling in the sign-up process
    }
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    }
    if (value.length < 3) {
      return "Username must be at least 3 characters long";
    }
    if (value.contains(RegExp(r'[0-9]'))) {
      return "Username must contain only alphabets";
    }
    if (value.contains(RegExp(r'[`~!@#$%^&*()_+=.,/?.,]'))) {
      return "Username must not contain special characters";
    }
    return null;
  }
}
