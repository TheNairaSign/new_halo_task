import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:new_halo_task/dashboard/dashboard.dart';
import 'package:new_halo_task/notes/note_builder.dart';
import 'package:new_halo_task/notes/note_models/new_note_model.dart';
import 'package:new_halo_task/notes/notes.dart';
import 'package:new_halo_task/themes/themes.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const NewHaloTask());
}

class NewHaloTask extends StatelessWidget {
  const NewHaloTask({super.key});

  // TODO: Finish notes page
  // TODO: Correct drawer layout
  // TODO: Implement undo

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Dashboard(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
