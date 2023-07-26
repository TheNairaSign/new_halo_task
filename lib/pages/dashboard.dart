import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_halo_task/pages/signup_page.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: widget.signUserOut,
            ),
          )
        ],
      ),
      body: Center(child: Text("Logged In as ${currentUser.email}"),),
    );
  }
}