


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
class _gettingdataState extends State<gettingdata> {

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
          print('Content Data: $contentData');
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
        body: Column(
          children: [
           Container(
              child: documentExists ==true ?
              QrImageView(data:  contentData,
                  version: QrVersions.auto,
                  size: 80.0):
              Container(
                child: Text("nboy"),

              ),


            )
          ],

        ),
      ),
    );
  }
}