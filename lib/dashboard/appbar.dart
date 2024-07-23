// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_halo_task/provider/auth_providers/login_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_alert_dialog.dart.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final _ = context.read<LoginProvider>();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: AppBar(
        toolbarHeight: 100,
        title: Text(
          "Hello ${FirebaseAuth.instance.currentUser!.displayName}",
          maxLines: 2,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 20,
                color: Theme.of(context).textTheme.bodyLarge!.color
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  return CustomAlertDialog(
                    content: "Are you sure you wan to sign out?",
                    onConsent: () => _.signUserOut(context),
                  );
                });
              },
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
