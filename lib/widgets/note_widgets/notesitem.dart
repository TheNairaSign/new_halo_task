// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:new_halo_task/models/note_model.dart';
import 'package:new_halo_task/widgets/note_widgets/favorite_button.dart';

class NotesItem extends StatefulWidget {
  const NotesItem({
    Key? key,
    required this.notes,
    required this.index,
    required this.deleteNote,
    required this.onFaveTap,
  }) : super(key: key);
   final List<NoteModel> notes;
   final int index;
   final void Function(NoteModel noteModel) deleteNote;
   final void Function() onFaveTap;


  @override
  State<NotesItem> createState() => _NotesItemState();
}

class _NotesItemState extends State<NotesItem> {
  final formatter = DateFormat.yMMMd();
  DateTime date = DateTime.now();
    String get formattedDate {
    return formatter.format(date);
  }
  
  final Border _border = const Border(
    bottom: BorderSide(
      color: Colors.grey,
    ),
    top: BorderSide(
      color: Colors.grey,
    ),
    left: BorderSide(
      color: Colors.grey,
    ),
    right: BorderSide(
      color: Colors.grey,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.notes[widget.index].noteColor, // Use the stored color for each note
        border: _border,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  maxLines: 2,
                  widget.notes[widget.index].title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // const Spacer(),
              GestureDetector(
                onTap: () {
                  widget.deleteNote(widget.notes[widget.index]);
                },
                child: const Icon(Icons.delete_forever, size: 25),
              ),
            ],
          ),
          const Divider(),
          Text(
            widget.notes[widget.index].bodyText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              const Spacer(),
              FavoriteButton(onStarTap: widget.onFaveTap,)
            ],
          ),
        ],
      ),
    );
  }
}