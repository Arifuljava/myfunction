import 'package:flutter/material.dart';
import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';


import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

var contentData = "";
var positionx = "";
var positiony = "";
var widget_w = "";
var widget_h = "";

class container2 extends StatefulWidget {
  const container2({Key? key});

  @override
  State<container2> createState() => _Container2State();
}

class _Container2State extends State<container2> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String documentName = "qr"; // Specify the document name you want to check
  String collectionName = "ElementList"; // Specify the name of your collection
  bool documentExists = false;

  @override
  void initState() {
    super.initState();
    checkDocumentExists();
  }

  void checkDocumentExists() {
    firebaseFirestore
        .collection(collectionName)
        .doc(documentName)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        setState(() {
          documentExists = true;
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          // Access the individual fields from the retrieved data
          contentData = data['contentdata'];
          positionx = data['positionx'];
          positiony = data['positiony'];
          widget_w = data['widget_w'];
          widget_h = data['widget_h'];
          print('Content Data: $positionx');
        });
      } else {
        setState(() {
          documentExists = false;
        });
      }
    }).catchError((error) {
      print("Error occurred while checking document: $error");
    });
  }
  final GlobalKey containerKey = GlobalKey();
  Uint8List? imageData;
  Future<ui.Image?> convertWidgetToImage() async {
    try {
      RenderRepaintBoundary boundary =
      containerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.0);
      return image;
    } catch (e) {
      print('Error capturing container convert to bitmap: $e');
      return null;
    }
  }
  Future<Uint8List?> convertImageToData(ui.Image image) async {
    try {
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      final byteBuffer = byteData?.buffer;
      final byteList = byteBuffer?.asUint8List();
      //return byteData?.buffer.asUint8List();
      return byteList;
    } catch (e) {
      print('Error converting image to data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Convert to image"),
        ),
        body: Stack(
          children: [
            Container(
              key: containerKey,
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 350,
              color: Colors.blue,
              child: Stack(
                children: [
                  Positioned(
                    left: double.tryParse(positionx) ?? 0.0, // X coordinate with error handling
                    top: double.tryParse(positiony) ?? 0.0, // Y coordinate with error handling
                    child: Container(
                      child: documentExists == true
                          ? QrImageView(
                        data: contentData,
                        version: QrVersions.auto,
                        size: double.tryParse(widget_w) ?? 100.0, // Size with error handling
                      )
                          : Container(
                        child: Text("nboy"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(onPressed: () async {
                final image = await convertWidgetToImage();
                print(image);

                if (image != null) {
                  final imageData = await convertImageToData(image);
                  if (imageData != null) {
                    setState(() {
                      this.imageData = imageData;
                    });
                    print(imageData);

                  }
                }
              }, child: Text("Convert Bitmap"),

              ),
            )
          ],
        ),
      ),
    );
  }
}
