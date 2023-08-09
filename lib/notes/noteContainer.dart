import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_halo_task/notes/colored_container.dart';
import 'package:new_halo_task/themes/themes.dart';

class NotesContainer extends StatefulWidget {
  const NotesContainer({super.key, required this.titleController, required this.bodyController, required this.onSubmitNotes,});

  final TextEditingController titleController;
  final TextEditingController bodyController;
  final void Function() onSubmitNotes;

  @override
  State<NotesContainer> createState() => _NotesContainerState();
}

class _NotesContainerState extends State<NotesContainer> {
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
          onPressed: widget.onSubmitNotes,
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