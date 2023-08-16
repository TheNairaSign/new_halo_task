import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMMMd();

class NoteModel {
  final String title, bodyText;
  final DateTime date;
  final Color noteColor;

  NoteModel({
    required this.title,
    required this.bodyText,
    required this.date,
    required this.noteColor,
  });

  String get formattedDate {
    return formatter.format(date);
  }
}