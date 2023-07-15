


import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class gettingdata extends StatefulWidget {
  const gettingdata({super.key});

  @override
  State<gettingdata> createState() => _gettingdataState();
}
var contentData="";
var positionx="";
var positiony="";
var widget_w="";
var widget_h="";

var contentData1="";
var positionx1="";
var positiony1="";
var widget_w1="";
var widget_h1="";
class _gettingdataState extends State<gettingdata> {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String documentName = "qr"; // Specify the document name you want to check
  String collectionName = "ElementList"; // Specify the name of your collection
  bool documentExists = false;

  @override
  void initState() {
    super.initState();
    checkDocumentExists();
    checkDocumentExists1();
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
  void checkDocumentExists1() {
    firebaseFirestore
        .collection("ElementList")
        .doc("bar")
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        setState(() {
          documentExists = true;
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          // Access the individual fields from the retrieved data
          contentData1 = data['contentdata'];
          positionx1 = data['positionx'];
          positiony1 = data['positiony'];
          widget_w1= data['widget_w'];
          widget_h1 = data['widget_h'];
          print('Content Data: $positionx1');
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firestore Check'),
        ),
        body: Stack(
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
            Positioned(
              left: double.tryParse(positionx1) ?? 0.0, // X coordinate with error handling
              top: double.tryParse(positiony1) ?? 0.0, // Y coordinate with error handling
              child: Container(
                child: documentExists == true
                    ? QrImageView(
                  data: contentData1,
                  version: QrVersions.auto,
                  size: double.tryParse(widget_w1) ?? 100.0, // Size with error handling
                )
                    : Container(
                  child: Text("nboy"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*
  child: documentExists ==true ?
                    QrImageView(data:  contentData,
                        version: QrVersions.auto,
                        size: 80.0):
                    Container(
                      child: Text("nboy"),

                    ),
 */