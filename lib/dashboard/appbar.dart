import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MyAppBar({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // final  username = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: AppBar(
        toolbarHeight: 100,
        title: Text("Hello Tamunotonye Bob Manuel", maxLines: 2, style:  Theme.of(context).textTheme.bodyLarge
        ),
        
       actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: signUserOut,
            ),
          )
        ],
        elevation: 0.5,
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}