import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_halo_task/components/alert_dialog.dart';
import 'package:new_halo_task/models/note_model/note_model.dart';
import 'package:new_halo_task/notes/colored_container.dart';
import 'package:new_halo_task/themes/themes.dart';

class NotesContainer extends StatefulWidget {
  const NotesContainer(
      {super.key,
      required this.titleController,
      required this.bodyController,
      required this.notes,required this.onAddNote,
      });

  final TextEditingController titleController;
  final TextEditingController bodyController;
  final List<NoteModel> notes;
  final void Function(NoteModel note) onAddNote;

  @override
  State<NotesContainer> createState() => _NotesContainerState();
}

class _NotesContainerState extends State<NotesContainer> {
  Color containerColor = Colors.white; // Set an initial color
  List<Color> colorList = const [
    Colors.white,
    Color(0xffEEEBD3),
    Color(0xff45503B),
    Color(0xffBFD1E5),
    Color(0xffFE5F55),
  ];
  List<Color> colorList3 = const [
    Colors.white,
    Color(0xfA9E5BB3),
    Color(0xffFCF6B1),
    Color(0xffF7B32B),
    Color(0xffF72C25),
    Color(0xff2D1E2F),
  ];
  List<Color> colorList4 = const [
    Colors.white,
    Color(0xff4EFFEF),
    Color(0xff00A5CF),
    Color(0xffC1666B),
    Color(0xffD4B483),
    Color.fromARGB(255, 147, 240, 212),
  ];
  List<Color> colorList2 = const [
    Colors.white,
    Color.fromARGB(255, 243, 229, 107),
    Color.fromARGB(190, 32, 176, 162),
    Color.fromARGB(162, 239, 88, 139),
    Color.fromARGB(255, 104, 141, 204),
  ];

  void onAdd() {
    if (widget.titleController.text.isEmpty || widget.bodyController.text.isEmpty) {
      showDialog(context: context, builder: (context) {
        return const MyAlertDialog(contentText: "TextFields cannot be empty");
      });
    } else {
      widget.onAddNote(
        NoteModel(
        bodyText: widget.bodyController.text,
        title: widget.titleController.text,
        date: DateTime.now(),
        noteColor: containerColor, // Store the selected color for the note
      ),);
      widget.titleController.clear();
      widget.bodyController.clear();
      containerColor = Colors.white; // Reset the container color to white after adding the note
  }
  }
  void updateContainerColor(Color color) {
    setState(() {
      containerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
        border: const Border(
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
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.titleController,
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
        controller: widget.bodyController,
        enableIMEPersonalizedLearning: true,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(
          fontSize: 20,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.normal,
          color: Color.fromARGB(255, 9, 25, 50)
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5),
          hintTextDirection: TextDirection.ltr,
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
            onAdd();
          },
          icon: Icon(
            Icons.add,
            size: 25,
            weight: 10,
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
