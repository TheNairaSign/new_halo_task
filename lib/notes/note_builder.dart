import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:new_halo_task/models/note_model.dart';
import 'package:new_halo_task/models/starred_notes_model.dart';
import 'package:new_halo_task/notes/notes_container.dart';
import 'package:new_halo_task/themes/themes.dart';
import 'package:new_halo_task/widgets/note_widgets/notesitem.dart';

class NoteBuilder extends StatefulWidget {
  const NoteBuilder({super.key});
  @override
  State<NoteBuilder> createState() => _NoteBuilderState();
}

class _NoteBuilderState extends State<NoteBuilder> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  final List<NoteModel> _notes = [];
  final List<StarredNotesModel> _starredNotes = [];
  bool tapped = false;

  @override
  void initState() {
    titleController;
    bodyController;
    _notes;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void addNotes(NoteModel note) {
    setState(() {
      _notes.add(note);
    });
  }

  void _undoDelete(NoteModel noteModel, int index) {
    setState(() {
      _notes.insert(index, noteModel);
    });
  }

  void _deleteNote(NoteModel noteModel, int index) {
    ScaffoldMessenger.of(context).clearSnackBars;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: Row(
        children: [
          Text(
            "Note deleted",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar;
              _undoDelete(noteModel, index);
            },
            child: Text(
              "Undo",
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          )
        ],
      ),
    ));
    setState(() {
      _notes.remove(noteModel);
    });
  }

  final formatter = DateFormat.yMMMd();
  DateTime date = DateTime.now();

  String get formattedDate {
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(_notes);
        return false;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Text(
              _notes.length == 1
                  ? "You have ${_notes.length} note"
                  : "You have ${_notes.length} notes",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                NotesContainer(
                  onAddNote: addNotes,
                  titleController: titleController,
                  bodyController: bodyController,
                  notes: _notes,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        NotesItem(
                          notes: _notes,
                          index: index,
                          deleteNote: (NoteModel note) {
                            _deleteNote(note, index);
                          },
                          onFaveTap: () {
                            setState(() {
                              _starredNotes.add(
                                StarredNotesModel(
                                  title: _notes[index].title,
                                  body: _notes[index].bodyText,
                                  // Add other properties as needed
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
