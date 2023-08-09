import 'package:flutter/material.dart';

import 'package:new_halo_task/dashboard/appbar.dart';
import 'package:new_halo_task/notes/note_builder.dart';
import 'package:new_halo_task/notes/note_models/note_model.dart';
import 'package:new_halo_task/widgets/drawer.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
  final List<NoteModel> notes = [];

    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: NoteBuilder(notes: notes),
    );
  }
}
