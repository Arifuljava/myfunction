


import 'package:flutter/material.dart';

class draganddrop extends StatefulWidget {
  const draganddrop({super.key});

  @override
  State<draganddrop> createState() => _draganddropState();
}

class _draganddropState extends State<draganddrop> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DraggableTextScreen(),
    );
  }
}

class DraggableTextScreen extends StatefulWidget {
  @override
  _DraggableTextScreenState createState() => _DraggableTextScreenState();
}

class _DraggableTextScreenState extends State<DraggableTextScreen> {
  double _x = 0.0; // x-position of the text
  double _y = 0.0; // y-position of the text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable Text'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: _x,
            top: _y,
            child: Draggable(
              child: Container(
                width: 100,
                height: 50,
                color: Colors.blue,
                child: Center(child: Text('Drag me')),
              ),
              feedback: Container(
                width: 100,
                height: 50,
                color: Colors.blue.withOpacity(0.5),
                child: Center(child: Text('Dragging')),
              ),
              onDraggableCanceled: (velocity, offset) {
                setState(() {
                  _x = offset.dx;
                  _y = offset.dy;
                });
              },
            ),
          ),
          Positioned(
            left: _x,
            top: _y + 60, // Offset the text position to avoid overlapping with the draggable container
            child: Text(
              'Dragged Text',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

