// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:new_halo_task/models/note_model/note_model.dart';
import 'package:new_halo_task/provider/note_provider.dart';

class NotesItem extends StatefulWidget {
  const NotesItem({
    Key? key,
    required this.notes,
    required this.index,
    required this.removeNote,
  }) : super(key: key);
  final List<NoteModel> notes;
  final int index;
  final void Function() removeNote;

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
    return Container(
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
                  widget.removeNote();
                },
                child: Icon(
                  Icons.close,
                  size: 25,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[700],
          ),
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

              // This button should add notes to the favorite screen when tapped
              IconButton(
                icon: Icon(
                  widget.notes[widget.index].isFavorite
                      ? Icons.star
                      : Icons.star_outline,
                ),
                onPressed: () {
                  final noteProvider = context.read<NoteProvider>();
                  noteProvider.toggleStar(widget.notes[widget.index]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
