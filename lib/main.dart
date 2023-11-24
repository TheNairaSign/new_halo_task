import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_halo_task/auth/login_auth_page.dart';
import 'package:new_halo_task/models/note_model/note_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:new_halo_task/provider/google_sign_in_provider.dart';
import 'package:new_halo_task/provider/note_provider.dart';
import 'package:new_halo_task/provider/task_provider.dart';
import 'package:new_halo_task/provider/toggle_screen_provider.dart';
import 'package:new_halo_task/themes/themes.dart';
import 'package:new_halo_task/hive/note_adapter.dart';
import 'package:new_halo_task/hive/type_adapter.dart';
import 'package:new_halo_task/models/task_models/task.dart';
import 'package:new_halo_task/provider/auth_providers/login_provider.dart';
import 'package:new_halo_task/provider/auth_providers/sign_up_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<Task>(TaskAdapter(), );
  Hive.registerAdapter<NoteModel>(NoteAdapter());

  await Hive.openBox<Task>('tasks');
  await Hive.openBox<NoteModel>('notes');


  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => ToggleScreenProvider()),
      ],
    child: const NewHaloTask(),
    )
  );
  
}

class NewHaloTask extends StatelessWidget {
  const NewHaloTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child:  LoginAuth()),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
