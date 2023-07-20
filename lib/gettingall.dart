

import 'dart:ffi';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/material.dart';

class gettingall extends StatefulWidget {
  const gettingall({super.key});

  @override
  State<gettingall> createState() => _gettingallState();
}
String howmanyelement="0";

class _gettingallState extends State<gettingall> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      initializeFirebase();
     // checkDocumentExists();
      getAllQRDocuments();
      getAllBarDocuments();
    });
  }
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    firebaseFirestore = FirebaseFirestore.instance;
  }


  List<String> contentdata = [];
  List<String> positionx = [];
  List<String> positiony = [];
  List<String> widget_w = [];
  List<String> widget_h = [];
  List<String> index = [];
  List<String> qrlength = [];
  String firstNumberAsString="0";
  void getAllQRDocuments() {
    String documentName = "qrcode"; // Specify the document name you want to check
    String collectionName = "ElementList"; // Specify the name of your collection
    bool documentExists = false;
    firebaseFirestore
        .collection(collectionName)
        .doc(documentName)
    .collection("List")// Replace 'your_collection_name' with the actual collection name
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        contentdata = querySnapshot.docs.map((doc) => doc['contentdata'] as String).toList();
        positionx = querySnapshot.docs.map((doc) => doc['positionx'] as String).toList();
        positiony = querySnapshot.docs.map((doc) => doc['positiony'] as String).toList();

        //

        widget_w = querySnapshot.docs.map((doc) => doc['widget_w'] as String).toList();
        widget_h = querySnapshot.docs.map((doc) => doc['widget_h'] as String).toList();
        index = querySnapshot.docs.map((doc) => doc['index'] as String).toList();

        qrlength = querySnapshot.docs.map((doc) => doc['length'] as String).toList();

         firstNumberAsString = qrlength[0].toString();

      });
    }).catchError((error) {
      print("Error occurred while fetching documents: $error");
    });
  }
  //barcode
  List<String> barcontentdata = [];
  List<String> barpositionx = [];
  List<String> barpositiony = [];
  List<String> barwidget_w = [];
  List<String> barwidget_h = [];
  List<String> barindex = [];
  List<String> barqrlength = [];
  String barfirstNumberAsString="0";
  void getAllBarDocuments() {
    String documentName = "barcode"; // Specify the document name you want to check
    String collectionName = "ElementList"; // Specify the name of your collection
    bool documentExists = false;
    firebaseFirestore
        .collection(collectionName)
        .doc(documentName)
        .collection("List")// Replace 'your_collection_name' with the actual collection name
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        barcontentdata = querySnapshot.docs.map((doc) => doc['contentdata'] as String).toList();
        barpositionx = querySnapshot.docs.map((doc) => doc['positionx'] as String).toList();
        barpositiony = querySnapshot.docs.map((doc) => doc['positiony'] as String).toList();

        //

        barwidget_w = querySnapshot.docs.map((doc) => doc['widget_w'] as String).toList();
        barwidget_h = querySnapshot.docs.map((doc) => doc['widget_h'] as String).toList();
        barindex = querySnapshot.docs.map((doc) => doc['index'] as String).toList();

        barqrlength = querySnapshot.docs.map((doc) => doc['length'] as String).toList();

        barfirstNumberAsString = barqrlength[0].toString();
        print(barfirstNumberAsString);
      });
    }).catchError((error) {
      print("Error occurred while fetching documents: $error");
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Display QR Codes"),
        ),
        body: Center(
          child: Stack(
            children: [
              for (var i = 0; i < int.parse(firstNumberAsString); i++)
                Positioned(
                  left: double.parse(positionx[i]), // Parse to double to use Offset
                  top: double.parse(positiony[i]), // Parse to double to use Offset
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      // Move the QR code by updating the position in the list
                      setState(() {
                        double dx = double.parse(positionx[i]) + details.delta.dx;
                        double dy = double.parse(positiony[i]) + details.delta.dy;
                        positionx[i] = dx.toString();
                        positiony[i] = dy.toString();
                      });
                    },
                    child: QrImageView(
                      data: contentdata[i], // Use QR code data from contentdata list
                      version: QrVersions.auto,
                      size: 50.0,
                    ),
                  ),
                ),

              for (var i = 0; i < int.parse(barfirstNumberAsString); i++)
                Positioned(
                  left: double.parse(barpositionx[i]), // Parse to double to use Offset
                  top: double.parse(barpositiony[i]), // Parse to double to use Offset
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      // Move the QR code by updating the position in the list
                      setState(() {
                        double dx = double.parse(barpositionx[i]) + details.delta.dx;
                        double dy = double.parse(barpositiony[i]) + details.delta.dy;
                        barpositionx[i] = dx.toString();
                        barpositiony[i] = dy.toString();
                      });
                    },
                    child: BarcodeWidget(
                      data: barcontentdata[i], barcode: Barcode.code128(),
                        width: 50,
                        height: 50

                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
