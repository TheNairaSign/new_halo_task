import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_halo_task/models/note_model/note_model.dart';

import '../themes/themes.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> writtenNotes = [];
  User? user = FirebaseAuth.instance.currentUser;
  Box<NoteModel>? noteBox;

  NoteProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user = user;
      if (user != null) {
        _initHive();
      } else {
        writtenNotes.clear();
        closeHive();
        notifyListeners();
      }
    });
  }

  Future<void> _initHive() async {
    if (user != null) {
      try {
        noteBox = await Hive.openBox<NoteModel>('notes_${user!.uid}');
        writtenNotes = noteBox?.values.cast<NoteModel>().toList() ?? [];
        notifyListeners();
      } catch (e) {
        debugPrint("Error initializing Hive: $e");
      }
    }
  }

  Future<void> closeHive() async {
    if (noteBox != null) {
      await noteBox!.close();
      noteBox = null;
    }
  }

  void updateNotes(List<NoteModel> notes) {
    writtenNotes = notes;
    notifyListeners();
  }

  void addNotes(NoteModel note) {
    writtenNotes.add(note);
    noteBox?.add(note);
    notifyListeners();
  }

  void toggleStar(NoteModel note) {
    note.isFavorite = !note.isFavorite;
    updateTaskInHive(note);
  }

  Future<void> updateTaskInHive(NoteModel note) async {
    if (user != null && note.key != null) {
      try {
        await noteBox?.put(note.key, note);
        notifyListeners();
      } catch (e) {
        debugPrint("Error updating note: $e");
      }
    }
  }

  void removeStarredNotes() {
    writtenNotes.removeWhere((note) => note.isFavorite);
    notifyListeners();
  }

  Future<void> removeNotes(NoteModel note) async {
    if (user != null && note.key != null) {
      try {
        writtenNotes.remove(note);
        await noteBox?.delete(note.key);
        notifyListeners();
      } catch (e) {
        debugPrint("Error removing note: $e");
      }
    }
  }

  void deleteNote(BuildContext context, NoteModel note, int index) {
    ScaffoldMessenger.of(context).clearSnackBars();
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
  }

  void undoDeleteNotes(int index, NoteModel note) {
    writtenNotes.insert(index, note);
    noteBox?.put(index, note);
    notifyListeners();
  }
}
