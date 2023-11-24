import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:new_halo_task/models/note_model/note_model.dart';
import 'package:new_halo_task/themes/themes.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> _writtenNotes = [];

  List<NoteModel> get writtenNotes => _writtenNotes;

  Box<NoteModel>? noteBox;

  NoteProvider() {
    _initHiveNotes(_writtenNotes);
  }

  set writtenNotes(List<NoteModel> note) {
    _writtenNotes = note;
    notifyListeners();
  }

  void updateNotes(List<NoteModel> note) {
    _writtenNotes = note;
    notifyListeners();
  }

  Future<void> _initHiveNotes(List<NoteModel> note) async {
    await Hive.initFlutter();
    noteBox = await Hive.openBox<NoteModel>("notes");
    _writtenNotes = note;
    _writtenNotes.addAll(noteBox!.values);
    notifyListeners();
  }

  void addNotes(NoteModel note) {
    _writtenNotes.add(note);
    noteBox?.add(note);
    notifyListeners();
  }

  void toggleStar(NoteModel note) {
    note.isFavorite = !note.isFavorite;
    notifyListeners();
  }

  void removeStarredNotes() {
    _writtenNotes.removeWhere((note) => note.isFavorite);
    notifyListeners();
  }

  void removeNotes(NoteModel note) {
    _writtenNotes.remove(note);
    noteBox?.delete(note.key);
    notifyListeners();
  }

  void deleteNote(BuildContext context, NoteModel note, int index) {
    ScaffoldMessenger.of(context).clearSnackBars;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
                undoDeleteNotes(index, note);
              },
              child: Text(
                "Undo",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    removeNotes(note);
    notifyListeners();
  }

  void undoDeleteNotes(int index, NoteModel note) {
    _writtenNotes.insert(index, note);
    noteBox?.put(index, note);
    notifyListeners();
  }
}
