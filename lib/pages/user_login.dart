import 'package:flutter/material.dart';

import 'package:new_halo_task/pages/login/login_body.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({
    Key? key,
  }) : super(key: key);


  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBody(),
    );
  }
}
