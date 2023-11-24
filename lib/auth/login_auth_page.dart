import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_halo_task/dashboard/dashboard.dart';
import 'package:new_halo_task/pages/welcome_page/welcome_page.dart';

class LoginAuth extends StatelessWidget {
  const LoginAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint("Something went wrong");
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint("Waiting for connection...");
            return const CircularProgressIndicator.adaptive();
          }
          // User is logged in
          if (snapshot.hasData) {
            debugPrint("User Logged in");
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