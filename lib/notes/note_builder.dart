import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_halo_task/models/note_model/note_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:new_halo_task/notes/notes_container.dart';
import 'package:new_halo_task/provider/note_provider.dart';
import 'package:new_halo_task/widgets/note_widgets/notesitem.dart';

class NoteBuilder extends StatefulWidget {
  const NoteBuilder({
    super.key,
  });

  @override
  State<NoteBuilder> createState() => _NoteBuilderState();
}

class _NoteBuilderState extends State<NoteBuilder> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool tapped = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _loadNotesFromHive();
    }
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
    if (_user == null) return;

    final provider = context.read<NoteProvider>();

    // Open the Hive box for the specific user
    final noteBox = await Hive.openBox<NoteModel>('notes_${_user!.uid}');
    provider.updateNotes(noteBox.values.toList());
  }

  Future<void> _saveNoteToHive(NoteModel note) async {
    if (_user == null) return;

    final noteBox = await Hive.openBox<NoteModel>('notes_${_user!.uid}');
    noteBox.add(note);
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
                      _saveNoteToHive(note); // Save note to Hive
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
