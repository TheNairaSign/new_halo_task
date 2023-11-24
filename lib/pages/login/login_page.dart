// import 'package:flutter/material.dart';

// import 'package:new_halo_task/pages/user_login.dart';
// import 'package:new_halo_task/widgets/auth_card.dart';
// import 'package:new_halo_task/widgets/pink_text_button.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key, required this.showRegisterPage});
//   final VoidCallback showRegisterPage;

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: bodyPadding(context),
//     );
//   }

//   Padding bodyPadding(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(top: 70, bottom: 50, left: 20, right: 20),
//             child: Text(
//               "Let's let you in",
//               style: Theme.of(context).textTheme.headlineLarge!.copyWith(
//                     fontWeight: FontWeight.w500,
//                   ),
//             ),
//           ),
//           const AuthCards(),
//           Padding(
//             padding:
//                 const EdgeInsets.only(bottom: 60, top: 50, right: 20, left: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Divider(
//                   indent: 150,
//                   endIndent: 10,
//                   color: Colors.white,
//                   thickness: 2,
//                 ),
//                 Text(
//                   "Or",
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
//                 ),
//                 const Divider(
//                   indent: 150,
//                   endIndent: 10,
//                   thickness: 2,
//                   color: Colors.amber,
//                 ),
//               ],
//             ),
//           ),
//           // const Spacer(),
//           PinkTextButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => const UserLoginPage(),
//                 ),
//               );
//             },
//             buttonContent: "Sign In with password",
//           ),
//           const Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Don't have an account?",
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                       fontWeight: FontWeight.normal,
//                     ),
//               ),
//               TextButton(
//                 style: ButtonStyle(
//                   overlayColor: MaterialStateProperty.all(
//                     Colors.transparent,
//                   ),
//                 ),
//                 onPressed: () {
//                   debugPrint("Sign up");
//                   widget.showRegisterPage();
//                 },
//                 child: const Text(
//                   "Sign up",
//                   style: TextStyle(color: Colors.pink),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
