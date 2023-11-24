import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_halo_task/dashboard/dashboard.dart';
import 'package:new_halo_task/pages/welcome_page/welcome_page.dart';

class WelcomePageAuth extends StatelessWidget {
  const WelcomePageAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            debugPrint("Welcome Page Auth");
            debugPrint(snapshot.toString());
            return const Dashboard();
          }
          // User is not logged in
          else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}