


import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
int flag=1;
int flag1=2;
String qrdata="123456";
String brcodedata="1234";

class elementsave extends StatefulWidget {
  const elementsave({super.key});

  @override
  State<elementsave> createState() => _elementsaveState();
}
TextEditingController controller=new TextEditingController();
class _elementsaveState extends State<elementsave> {
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  @override
  void initState() async{
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    firebaseFirestore=FirebaseFirestore.instance;

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Save Data"),

        ),
        body: Column(
          children: [
            Row(
              children: [
                BarcodeWidget(data: brcodedata, barcode: Barcode.code128(), width: 200,
                  height: 100,
                  drawText: true,

                ),
               QrImageView(data: qrdata,
                   version: QrVersions.auto,
                   size: 80.0)


              ],
            ),
            Column(
              children: [
                ElevatedButton(onPressed: (){
                  if(flag==1)
                    {
                      addData("ElementList",qrdata,"qr");
                    }


                }, child:Text("Save"))
              ],
            )
          ],
        ),
      ),
    );
  }
}


Future<void> addData(String dataaddtobe, String databasename,String documentname) async {
  try {
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
     // Specify the name of your collection

    firebaseFirestore.collection(dataaddtobe)
        .doc(documentname) // Set the custom document name here
        .set({
      "contentdata": databasename // Specify the data to be added
    });
    print("added");
  } catch (e) {
    print("Error : " + e.toString());
  }
}