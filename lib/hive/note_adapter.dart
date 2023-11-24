import 'package:hive/hive.dart';
import 'package:flutter/material.dart'; 
import 'package:new_halo_task/models/note_model/note_model.dart';

class NoteAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 1;

  @override
  NoteModel read(BinaryReader reader) {
    final title = reader.readString();
    final bodyText = reader.readString();
    final dateMillis = reader.readInt();
    final noteColorValue = reader.readInt();

    final date = DateTime.fromMillisecondsSinceEpoch(dateMillis);
    final noteColor = Color(noteColorValue);

    return NoteModel(
      title: title,
      bodyText: bodyText,
      date: date,
      noteColor: noteColor,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.bodyText);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeInt(obj.noteColor.value);
  }
}
