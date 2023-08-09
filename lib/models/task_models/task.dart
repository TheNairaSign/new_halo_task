import 'package:flutter/material.dart';
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
  Category.important : Icons.notifications_none_rounded,
};

class Task {
  final String id, taskName, description;
  final DateTime date;
  final Category category;

  Task({
    required this.taskName,
    required this.description,
    required this.date,
    required this.category
  }) : id = uuid.v4();

  String get formattedDate  {
    return formatter.format(date);
  }
}
