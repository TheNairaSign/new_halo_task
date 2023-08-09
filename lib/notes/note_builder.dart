import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:new_halo_task/notes/colored_container.dart';
import 'package:new_halo_task/notes/note_models/note_model.dart';
import 'package:new_halo_task/themes/themes.dart';

class NoteBuilder extends StatefulWidget {
  const NoteBuilder({super.key, required this.notes});
   final List<NoteModel> notes;
  @override
  State<NoteBuilder> createState() => _NoteBuilderState();
}

class _NoteBuilderState extends State<NoteBuilder> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final List<NoteModel> _notes = [];
  bool tapped = false;

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
    return SingleChildScrollView(
      child: Column(
        children: [
          notesContainer(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _notes.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _addedNotes(index),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Container _addedNotes(int index) {
    return Container(
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _notes[index].noteColor, // Use the stored color for each note
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
                  _notes[index].title,
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
                  setState(() {
                    _notes.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete_forever, size: 25),
              ),
            ],
          ),
          const Divider(),
          Text(
            _notes[index].bodyText,
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
                    color: _notes[index].noteColor == colorList[0]
                        ? Colors.black
                        : Colors.white),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    tapped = !tapped;
                  });
                },
                child: Icon(
                  tapped == false ? Icons.star_border : Icons.star,
                  color: _notes[index].noteColor == colorList[0]
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Color containerColor = Colors.white; // Set an initial color
  List<Color> colorList = const [
    Colors.white,
    Color.fromARGB(255, 243, 229, 107),
    Color.fromARGB(190, 32, 176, 162),
    Color.fromARGB(162, 239, 88, 139),
    Color.fromARGB(255, 104, 141, 204),
  ];
  void updateContainerColor(Color color) {
    setState(() {
      containerColor = color;
    });
  }

  Container notesContainer() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
        border: _border,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLines: 2,
            controller: _titleController,
            cursorColor: primaryColor,
            cursorHeight: 25,
            style: const TextStyle(
              color: Color.fromARGB(255, 9, 25, 50),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(4),
              fillColor: Colors.transparent,
              border: InputBorder.none,
              filled: true,
              hintText: "Title",
              enabled: true,
              hintStyle: TextStyle(
                color: Colors.grey[900]!.withOpacity(0.5),
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const Divider(
            thickness: 1.2,
            color: Colors.black,
          ),
          _bodyTextField(),
          const Spacer(),
          colorRow(),
        ],
      ),
    );
  }

  Expanded _bodyTextField() {
    return Expanded(
      flex: 50,
      child: TextField(
        controller: _bodyController,
        enableIMEPersonalizedLearning: true,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(
          fontSize: 20,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.normal,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5),
          // hintTextDirection: TextDirection.ltr.ltr,
          hintText: "Hello",
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
          enabled: true,
          isDense: true,
        ),
      ),
    );
  }

  Row colorRow() {
    return Row(
      children: [
        ColoredContainer(
          onTap: () => updateContainerColor(colorList[0]),
          containerColor: colorList[0],
        ),
        ColoredContainer(
          onTap: () => updateContainerColor(colorList[1]),
          containerColor: colorList[1],
        ),
        ColoredContainer(
          onTap: () => updateContainerColor(colorList[2]),
          containerColor: colorList[2],
        ),
        ColoredContainer(
          onTap: () => updateContainerColor(colorList[3]),
          containerColor: colorList[3],
        ),
        ColoredContainer(
          onTap: () => updateContainerColor(colorList[4]),
          containerColor: colorList[4],
        ),
        const Spacer(),
        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              final NoteModel newNote = NoteModel(
                bodyText: _bodyController.text,
                title: _titleController.text,
                date: DateTime.now(),
                noteColor:
                    containerColor, // Store the selected color for the note
              );
              _notes.add(newNote);
              _titleController.clear();
              _bodyController.clear();
              containerColor = Colors.white; // Reset the container color to white after adding the note
            });
          },
          icon: Icon(
            Icons.add,
            size: 25,
            color: primaryColor,
          ),
          label: Text(
            "Note",
            style: GoogleFonts.poppins(
              color: primaryColor,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
