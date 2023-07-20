

import 'dart:ffi';

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
  String documentName = "qrcode"; // Specify the document name you want to check
  String collectionName = "ElementList"; // Specify the name of your collection
  bool documentExists = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      initializeFirebase();
     // checkDocumentExists();
      getAllDocuments();
    });
  }
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    firebaseFirestore = FirebaseFirestore.instance;
  }


  List<String> howManyElementList = [];
  List<String> positionx = [];
  List<String> positiony = [];
  List<String> widget_w = [];
  List<String> widget_h = [];
  List<String> index = [];
  void getAllDocuments() {
    firebaseFirestore
        .collection(collectionName)
        .doc(documentName)
    .collection("List")// Replace 'your_collection_name' with the actual collection name
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        howManyElementList = querySnapshot.docs.map((doc) => doc['contentdata'] as String).toList();
        positionx = querySnapshot.docs.map((doc) => doc['positionx'] as String).toList();
        positiony = querySnapshot.docs.map((doc) => doc['positiony'] as String).toList();

        //

        widget_w = querySnapshot.docs.map((doc) => doc['widget_w'] as String).toList();
        widget_h = querySnapshot.docs.map((doc) => doc['widget_h'] as String).toList();
        index = querySnapshot.docs.map((doc) => doc['index'] as String).toList();


        print(index.length);
      });
    }).catchError((error) {
      print("Error occurred while fetching documents: $error");
    });
  }



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
