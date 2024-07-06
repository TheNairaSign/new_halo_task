import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_halo_task/models/note_model/note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> _writtenNotes = [];
  User? user;

  List<NoteModel> get writtenNotes => _writtenNotes;

  Box<NoteModel>? noteBox;

  NoteProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user = user;
      if (user != null) {
        _initHiveNotes();
      } else {
        _writtenNotes.clear();
        noteBox?.close();
        noteBox = null;
        notifyListeners();
      }
    });
  }

  Future<void> _initHiveNotes() async {
    if (user != null) {
      try {
        noteBox = await Hive.openBox<NoteModel>("notes_${user!.uid}");
        _writtenNotes = noteBox?.values.toList() ?? [];
        notifyListeners();
      } catch (e) {
        debugPrint("Error initializing Hive for notes: $e");
      }
    }
  }

  void updateNotes(List<NoteModel> notes) {
    _writtenNotes = notes;
    notifyListeners();
  }

  Future<void> addNotes(NoteModel note) async {
    if (user != null) {
      try {
        await noteBox?.add(note);
        _writtenNotes.add(note);
        notifyListeners();
      } catch (e) {
        debugPrint("Error adding note: $e");
      }
    }
  }

  Future<void> updateNoteInHive(NoteModel note) async {
    if (user != null && note.key != null) {
      try {
        await note.save();
        notifyListeners();
      } catch (e) {
        debugPrint("Error updating note: $e");
      }
    }
  }

  void toggleStar(NoteModel note) {
    note.isFavorite = !note.isFavorite;
    updateNoteInHive(note);
  }

  Future<void> removeNotes(NoteModel note) async {
    if (user != null && note.key != null) {
      try {
        _writtenNotes.remove(note);
        await note.delete();
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
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    removeNotes(note);
  }

  void undoDeleteNotes(int index, NoteModel note) async {
    if (user != null) {
      _writtenNotes.insert(index, note);
      await noteBox?.put(index, note);
      notifyListeners();
    }
  }

  void removeStarredNotes() async {
    if (user != null) {
      try {
        final keysToDelete = noteBox?.keys.where((key) {
          final note = noteBox?.get(key);
          return note != null && note.isFavorite;
        }).toList();

        if (keysToDelete != null && keysToDelete.isNotEmpty) {
          await noteBox?.deleteAll(keysToDelete);
          _writtenNotes.removeWhere((note) => note.isFavorite);
          notifyListeners();
        }
      } catch (e) {
        debugPrint("Error removing starred notes: $e");
      }
    }
  }
}
