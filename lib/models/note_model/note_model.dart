import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMMMd();

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final Color noteColor;

  @HiveField(4)
  final  String bodyText;

  @HiveField(5)
  bool isFavorite;

  NoteModel({
    required this.title,
    required this.bodyText,
    required this.date,
    required this.noteColor,
    this.isFavorite = false
  }): id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}