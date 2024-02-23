// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_halo_task/models/welcome_pages_model.dart';
import 'package:new_halo_task/pages/user_login.dart';

import 'package:new_halo_task/widgets/pink_text_button.dart';

class NextPageButton extends StatefulWidget {
  const NextPageButton({
    Key? key,
    required this.controller,
    required this.currentIndex,
    required this.welcomeModel,
  }) : super(key: key);

  final PageController controller;
  final List<WelcomePageModel> welcomeModel;
  final int currentIndex;

  @override
  State<NextPageButton> createState() => NextPageButtonState();
}

class NextPageButtonState extends State<NextPageButton> {
  void onPressed() async {
    if (widget.currentIndex == widget.welcomeModel.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => const UserLoginPage(),
        ),
      );

      // Set 'hasSeenWelcomePage' to true in the user's profile
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        await FirebaseFirestore.instance.collection('users').doc(userId).set(
          {
            'hasSeenWelcomePage': true,
          },
          SetOptions(merge: true),
        );
      }
    }
    widget.controller.nextPage(
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: PinkTextButton(
        onPressed: onPressed,
        buttonContent: widget.currentIndex == widget.welcomeModel.length - 1
            ? "Continue"
            : "Next",
      ),
    );
  }
}
