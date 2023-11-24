// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_halo_task/models/note_model/note_model.dart';
import 'package:new_halo_task/widgets/my_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:new_halo_task/notes/notes_container.dart';
import 'package:new_halo_task/provider/note_provider.dart';
import 'package:new_halo_task/widgets/note_widgets/notesitem.dart';

class NoteBuilder extends StatefulWidget {
  const NoteBuilder({
    Key? key,
  }) : super(key: key);
  @override
  State<NoteBuilder> createState() => _NoteBuilderState();
}

class _NoteBuilderState extends State<NoteBuilder> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool tapped = false;

  @override
  void initState() {
    super.initState();
    titleController;
    bodyController;
    _loadNotesFromHive();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  final formatter = DateFormat.yMMMd();
  DateTime date = DateTime.now();

  String get formattedDate {
    return formatter.format(date);
  }

  Future<void> _loadNotesFromHive() async {
    final provider = context.read<NoteProvider>();

    final noteBox = await Hive.openBox<NoteModel>('notes');
    provider.updateNotes(noteBox.values.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Text(
                noteProvider.writtenNotes.length == 1
                    ? "You have ${noteProvider.writtenNotes.length} note"
                    : "You have ${noteProvider.writtenNotes.length} notes",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Column(
              children: [
                NotesContainer(
                  onAddNote: (note) {
                    setState(() {
                      noteProvider.addNotes(note);
                    });
                  },
                  titleController: titleController,
                  bodyController: bodyController,
                  notes: noteProvider.writtenNotes,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: noteProvider.writtenNotes.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        NotesItem(
                          notes: noteProvider.writtenNotes,
                          index: index,
                          removeNote: () {
                            noteProvider.deleteNote(
                              context,
                              noteProvider.writtenNotes[index],
                              index,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
