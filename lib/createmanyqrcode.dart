

import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class createmanyqrcode extends StatefulWidget {
  const createmanyqrcode({super.key});

  @override
  State<createmanyqrcode> createState() => _createmanyqrcodeState();
}

class _createmanyqrcodeState extends State<createmanyqrcode> {
  List<String> qrCodes = [];

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: Text("Many Qr Code"),
       ),
       body: Center(
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             ElevatedButton(onPressed: (){
               generateQRCode();
             }, child: Text("Create Qr Code")),
             SizedBox(height: 10,),
             Column(
               children: qrCodes.map((qrCode) => QrImageView(data: qrCode,size: 40,)).toList(),
             )

           ],
         ),
       ),
     ),
   );
  }
}
