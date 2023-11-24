import 'package:flutter/material.dart';
import 'package:new_halo_task/dashboard/appbar.dart';
import 'package:new_halo_task/provider/note_provider.dart';
import 'package:new_halo_task/widgets/drawer.dart';
import 'package:new_halo_task/widgets/note_widgets/notesitem.dart';
import 'package:provider/provider.dart';

class StarredNotes extends StatefulWidget {
  const StarredNotes({super.key});

  @override
  State<StarredNotes> createState() => _StarredNotesState();
}

class _StarredNotesState extends State<StarredNotes> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NoteProvider>(context);

    final starredNotes =
        notesProvider.writtenNotes.where((note) => note.isFavorite).toList();

    return Consumer<NoteProvider>(
      builder: (_, noteProvider, __) {
        return Scaffold(
          appBar: const MyAppBar(),
          drawer: const MyDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    noteProvider.writtenNotes.length == 1
                        ? "You have ${starredNotes.length} starred note"
                        : "You have ${starredNotes.length} starred notes",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: starredNotes.length,
                    itemBuilder: (context, index) {
                      return NotesItem(
                        notes: starredNotes,
                        index: index,
                        removeNote: notesProvider.removeStarredNotes,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
