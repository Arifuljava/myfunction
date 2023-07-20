



import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:myfunction/draganddropusingmany.dart';
import 'package:myfunction/gettingdata.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class saveintolocall extends StatefulWidget {
  const saveintolocall({super.key});

  @override
  State<saveintolocall> createState() => _draganddropState();
}

class _draganddropState extends State<saveintolocall> {
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
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  double _x = 0.0; // x-position of the text
  double _y = 0.0; // y-position of the text
  double _x1= 0.0;
  double _y1=0.0;

  GlobalKey _widgetKey = GlobalKey();
  double _widgetWidth = 0;
  double _widgetHeight = 0;

  void measureWidget() {
    final RenderBox? widgetBox = _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (widgetBox != null) {
      setState(() {
        _widgetWidth = widgetBox.size.width;
        _widgetHeight = widgetBox.size.height;
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
                key: _widgetKey,
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
          Container(
            alignment: Alignment.bottomCenter,

            child: ElevatedButton(onPressed: () {
              if (flag == 1) {
                String x= _x.toString();
                String y = _y.toString();
                measureWidget();
                String widget_w=_widgetWidth.toString();
                String widget_h=_widgetHeight.toString();
                addData("ElementList", qrdata, "qr",x,y,widget_w,widget_h);
              }
            }, child: Text("Save"),

            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => gettingdata(),
                    ),
                  );
                });
              },
              child: Text("See Result"),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => draganddropusingmany(),
                    ),
                  );
                });
              },
              child: Text("Go to many"),
            ),
          )
        ],
      ),
    );
  }
}
int flag=1;
String qrdata="123456";
Future<void> addData(String dataToAdd, String databaseName, String documentName,String positionx,String positiony,String widget_w,String widget_h ) async {
  try {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Specify the name of your collection
    firebaseFirestore.collection(dataToAdd).doc(documentName).set({
      "contentdata": databaseName,
      "positionx":positionx,
      "positiony":positiony,
      "widget_w":widget_w,
      "widget_h":widget_h

    });
    print("Added");
  } catch (e) {
    print("Error: $e");
  }
}
