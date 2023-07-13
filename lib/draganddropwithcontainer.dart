


import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class draganddropwithcontainer extends StatefulWidget {
  const draganddropwithcontainer({super.key});

  @override
  State<draganddropwithcontainer> createState() => _draganddropwithcontainerState();
}

class _draganddropwithcontainerState extends State<draganddropwithcontainer> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  double _containerX = 0.0; // x-position of the container
  double _containerY = 0.0; // y-position of the container
  double _elementX = 0.0; // x-position of the draggable element inside the container
  double _elementY = 0.0; // y-position of the draggable element inside the container
  GlobalKey _containerKey = GlobalKey();
  double _containerWidth = 0;
  double _containerHeight = 0;

  void measureContainer() {
    final RenderBox? containerBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (containerBox != null) {
      setState(() {
        _containerWidth = containerBox.size.width;
        _containerHeight = containerBox.size.height;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    firebaseFirestore = FirebaseFirestore.instance;
  }

  Future<void> addData(
      String dataToAdd,
      String databaseName,
      String documentName,
      String containerX,
      String containerY,
      String elementX,
      String elementY,
      ) async {
    try {
      // Specify the name of your collection
      firebaseFirestore.collection(dataToAdd).doc(documentName).set({
        "contentdata": databaseName,
        "containerX": containerX,
        "containerY": containerY,
        "elementX": elementX,
        "elementY": elementY,
      });
      print("Added");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Draggable Text'),
        ),
        body: Stack(
          children: [
            Positioned(
              left: _containerX,
              top: _containerY,
              child: Container(
                alignment: Alignment.center,
                key: _containerKey,
                width: 300,
                height: 200,
                color: Colors.grey,
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
                      _elementX = offset.dx - _containerX;
                      _elementY = offset.dy - _containerY;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              left: _containerX + _elementX + 10,
              top: _containerY + _elementY + 10,
              child: Text(
                'Dragged Text',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  measureContainer();
                  addData(
                    "ElementList",
                    "qrdata",
                    "qr",
                    _containerX.toString(),
                    _containerY.toString(),
                    _elementX.toString(),
                    _elementY.toString(),
                  );
                },
                child: Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: draganddropwithcontainer(),
  ));
}