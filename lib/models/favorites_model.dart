// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:new_halo_task/models/note_model.dart';

class FavoriteModel {
  Widget itemWidget;
  NoteModel noteItem;
  FavoriteModel({
    required this.itemWidget,
    required this.noteItem,
  });
}
