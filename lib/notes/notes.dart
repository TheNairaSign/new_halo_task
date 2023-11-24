import 'package:flutter/material.dart';

import 'package:new_halo_task/widgets/drawer.dart';
import 'package:new_halo_task/dashboard/appbar.dart';
import 'package:new_halo_task/notes/note_builder.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: NoteBuilder(),
    );
  }
}
