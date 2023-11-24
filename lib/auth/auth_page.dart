// import 'package:flutter/material.dart';
// import 'package:new_halo_task/pages/signup_page.dart';
// import 'package:new_halo_task/pages/user_login.dart';
// import 'package:new_halo_task/provider/toggle_screen_provider.dart';
// import 'package:provider/provider.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
  
//   @override
//   Widget build(BuildContext context) {
//     final togScrProv = context.read<ToggleScreenProvider>();
   
//     if (togScrProv.showLoginPage) {
//       return UserLoginPage(
//         showRegisterPage: togScrProv.toggleScreens,
//       );
//     } else {
//       return SignUpPage(
//         showLoginPage: togScrProv.toggleScreens,
//       );
//     }
//   }
// }
