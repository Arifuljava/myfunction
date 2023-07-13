import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? draggedItem;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Drag and Drop Example'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            DraggableWidget(
              data: 'QRCode',
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: Center(
                  child: Text('QR Code'),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: DragTargetWidget(
                onAccept: (data) {
                  setState(() {
                    draggedItem = data;
                  });
                },
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: draggedItem != 'QRCode',
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Third Element',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: draggedItem != 'QRCode',
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'Fourth Element',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DraggableWidget extends StatelessWidget {
  final String data;
  final Widget child;

  DraggableWidget({required this.data, required this.child});

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: data,
      child: child,
      feedback: Material(
        child: child,
        color: Colors.transparent,
      ),
      childWhenDragging: Container(),
    );
  }
}

class DragTargetWidget extends StatefulWidget {
  final Function(String) onAccept;

  DragTargetWidget({required this.onAccept});

  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  bool isDraggedOver = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: isDraggedOver ? Colors.red : Colors.black, width: 2),
          ),
        );
      },
      onWillAccept: (data) {
        setState(() {
          isDraggedOver = true;
        });
        return true;
      },
      onAccept: (data) {
        setState(() {
          isDraggedOver = false;
        });
        widget.onAccept(data);
      },
      onLeave: (data) {
        setState(() {
          isDraggedOver = false;
        });
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyWidget(),
  ));
}
