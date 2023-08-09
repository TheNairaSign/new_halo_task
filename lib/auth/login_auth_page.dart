import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_halo_task/dashboard/dashboard.dart';
import 'package:new_halo_task/pages/user_login.dart';

class LoginAuth extends StatelessWidget {
  const LoginAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            print("User Logged in");
            print(snapshot);
            return const Dashboard();
          }
          // User is not logged in
          else {
            return const UserLoginPage();
          }
        },
      ),
    );
  }
}