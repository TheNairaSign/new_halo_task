// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
    required this.onStarTap,
  }) : super(key: key);
  final void Function() onStarTap;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool tapped = false;
  void _starButton() {
    setState(() {
      tapped = !tapped;
      print("Starred");
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: Row(
            children: [
              Text(
                tapped
                    ? "Note added to favorites"
                    : "Note removed from favorites",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    tapped = !tapped;
                  });
                  widget.onStarTap();
                },
                child: const Text(
                  "undo",
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    tapped = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _starButton,
      child: Icon(
        tapped == false ? Icons.star_border : Icons.star,
      ),
    );
  }
}
