import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMMMd();

enum Category {
  important,
  pending,
  completed,
}

const categoryIcons = {
  Category.important: Icons.notifications_none_rounded,
};

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String taskName;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  bool isImportant;

  Task({
    required this.taskName,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.isImportant = false,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}
