


import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:myfunction/draganddrop.dart';
import 'package:myfunction/gettingdata.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class draganddropusingmany extends StatefulWidget {
  const draganddropusingmany({super.key});

  @override
  State<draganddropusingmany> createState() => _draganddropusingmanyState();
}

class _draganddropusingmanyState extends State<draganddropusingmany> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  double _x = 0.0; // x-position of the first draggable element
  double _y = 0.0; // y-position of the first draggable element
  double _x2 = 0.0; // x-position of the second draggable element
  double _y2 = 0.0; // y-position of the second draggable element
  GlobalKey _widgetKey = GlobalKey();
  GlobalKey _widgetKey2 = GlobalKey();
  double _widgetWidth = 0;
  double _widgetHeight = 0;
  double _widgetWidth2 = 0;
  double _widgetHeight2 = 0;
  void measureWidget() {
    final RenderBox? widgetBox =
    _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (widgetBox != null) {
      setState(() {
        _widgetWidth = widgetBox.size.width;
        _widgetHeight = widgetBox.size.height;
      });
    }
  }

  void measureWidget2() {
    final RenderBox? widgetBox2 =
    _widgetKey2.currentContext?.findRenderObject() as RenderBox?;
    if (widgetBox2 != null) {
      setState(() {
        _widgetWidth2 = widgetBox2.size.width;
        _widgetHeight2 = widgetBox2.size.height;
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
    return MaterialApp(
      home: Scaffold(
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
              left: _x2,
              top: _y2,
              child: Draggable(
                child: Container(
                  alignment: Alignment.topRight,
                  key: _widgetKey2,
                  width: 100,
                  height: 50,
                  color: Colors.red,
                  child: Center(child: Text('Drag me 2')),
                ),
                feedback: Container(
                  alignment: Alignment.topRight,
                  width: 100,
                  height: 50,
                  color: Colors.red.withOpacity(0.5),
                  child: Center(child: Text('Dragging 2')),
                ),
                onDraggableCanceled: (velocity, offset) {
                  setState(() {
                    _x2 = offset.dx;
                    _y2 = offset.dy;
                  });
                },
              ),
            ),
            Positioned(
              left: _x,
              top: _y + 60,
              child: Text(
                'Dragged Text',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Positioned(
              left: _x2,
              top: _y2 + 60,
              child: Text(
                'Dragged Text 2',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  if (flag == 1) {
                    String x = _x.toString();
                    String y = _y.toString();
                    measureWidget();
                    String widget_w = _widgetWidth.toString();
                    String widget_h = _widgetHeight.toString();
                    String x2 = _x2.toString();
                    String y2 = _y2.toString();
                    measureWidget2();
                    String widget_w2 = _widgetWidth2.toString();
                    String widget_h2 = _widgetHeight2.toString();
                    if(flag==1)
                      {
                        addData("ElementList", qrdata, "qr", x, y, widget_w,
                            widget_h);
                      }
                     if(flag1==1){
                       addData("ElementList", bardataa, "bar", x2, y2, widget_w2,
                           widget_h2);

                    }

                  }
                },
                child: Text("Save"),
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
                        builder: (context) => draganddrop(),
                      ),
                    );
                  });
                },
                child: Text("Save One element"),
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
            )
          ],
        ),
      ),
    );
  }
}

int flag = 1;
String qrdata = "123456";
int flag1=1;
String bardataa= "123456";


Future<void> addData(
    String dataToAdd,
    String databaseName,
    String documentName,
    String positionx,
    String positiony,
    String widget_w,
    String widget_h,

    ) async {
  try {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Specify the name of your collection
    firebaseFirestore.collection(dataToAdd).doc(documentName).set({
      "contentdata": databaseName,
      "positionx": positionx,
      "positiony": positiony,
      "widget_w": widget_w,
      "widget_h": widget_h
    });
    print("Added Data");
  } catch (e) {
    print("Error: $e");
  }
}