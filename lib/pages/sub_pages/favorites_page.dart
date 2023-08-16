import 'package:flutter/material.dart';
import 'package:new_halo_task/models/starred_notes_model.dart';

class FavoritesPage extends StatelessWidget {
  final List<StarredNotesModel> starredNotes;

  const FavoritesPage({super.key, required this.starredNotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ListView.builder(
        itemCount: starredNotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(starredNotes[index].title),
            subtitle: Text(starredNotes[index].body),
            // Display other properties as needed
          );
        },
      ),
    );
  }
}
