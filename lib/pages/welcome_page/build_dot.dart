// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_halo_task/themes/themes.dart';

class BuildDot extends StatelessWidget {
  const BuildDot({
    Key? key,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);
  
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7,
      width: currentIndex == index ? 20 : 7,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: currentIndex == index ? primaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
