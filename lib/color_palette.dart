import 'package:flutter/material.dart';

class ColorContainerApp extends StatefulWidget {
  const ColorContainerApp({super.key});
  @override
  _ColorContainerAppState createState() => _ColorContainerAppState();
}

class _ColorContainerAppState extends State<ColorContainerApp> {
  Color containerColor = Colors.blue; // Set an initial color

  void updateContainerColor(Color color) {
    setState(() {
      containerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Color Container'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              // Show the color palette as a bottom sheet
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ColorPalette(
                    onColorTap: updateContainerColor,
                  );
                },
              );
            },
            child: Container(
              width: 200,
              height: 200,
              color: containerColor,
              child: const Center(
                child: Text(
                  'Tap to Change Color',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ColorPalette extends StatelessWidget {
  final Function(Color) onColorTap;

  ColorPalette({required this.onColorTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ColorTile(Colors.red, onColorTap),
          ColorTile(Colors.blue, onColorTap),
          ColorTile(Colors.green, onColorTap),
          // Add more colors here as needed
        ],
      ),
    );
  }
}

class ColorTile extends StatelessWidget {
  final Color color;
  final Function(Color) onColorTap;

  ColorTile(this.color, this.onColorTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onColorTap(color),
      child: Container(
        width: 50,
        height: 50,
        color: color,
      ),
    );
  }
}

void main() {
  runApp(ColorContainerApp());
}
