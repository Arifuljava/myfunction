



import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class convertcontainer extends StatefulWidget {
  const convertcontainer({super.key});

  @override
  State<convertcontainer> createState() => _convertcontainerState();
}

class _convertcontainerState extends State<convertcontainer> {
  final GlobalKey containerKey = GlobalKey();
  Uint8List? capturedImageData;
  Future<ui.Image> captureContainer() async {
    RenderRepaintBoundary boundary =
    containerKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
    return image;
  }
  void loadImage() async {
    ui.Image capturedImage = await captureContainer();
    ByteData? byteData = await capturedImage.toByteData(format: ui.ImageByteFormat.png);
    setState(() {
      capturedImageData = byteData?.buffer.asUint8List();
    });
  }
  void convertWidgetToImage() async {
    RenderRepaintBoundary boundary =
    containerKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    print(image);
    // Use the `image` object as per your requirement
  }
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: Text("Convert Container"),
       ),
       body: Column(
         children: [
           Container(
             margin: EdgeInsets.all(10),
             child: RepaintBoundary(
               
               key: containerKey,
               child: Container(
                 height: 250,
                 width: double.infinity,
                 color: Colors.blue,
                 child: Container(
                   alignment: Alignment.center,
                   child: Text(
                     "Hello",style: TextStyle(fontSize: 20,color: Colors.white),

                   ),
                 ),
               ),
             ),
           ),
           SizedBox(
             child: Container(
                 child: ElevatedButton(onPressed: () async{
                   ui.Image capturedImage = await captureContainer();
                   print("Image : ");
                   print(capturedImage);
                   convertWidgetToImage();




                 }, child: Text("Convert to bitmap"))),
           ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),

          )

         ],
       ),
     ),
   );
  }
}

