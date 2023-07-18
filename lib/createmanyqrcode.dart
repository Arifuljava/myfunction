

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
int flag=0;

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];
  GlobalKey _widgetKey = GlobalKey();
  List<double> widgetWidths = [];
  List<double> widgetHeights = [];
  List<int> widgetWidths22 = [];

  void measureWidget(int index) {
    final RenderBox? widgetBox =
    _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (widgetBox != null) {
      setState(() {
        widgetWidths[index] = widgetBox.size.width;
        widgetHeights[index] = widgetBox.size.height;
      });
    }
  }


  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      widgetWidths22.add(50);
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
    });
  }

  void updateQRCodeOffset(int index, Offset offset) {
    setState(() {
      qrCodeOffsets[index] = offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Many QR Codes"),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              for (var i = 0; i < qrCodes.length; i++)
                Positioned(
                  left: qrCodeOffsets[i].dx,
                  top: qrCodeOffsets[i].dy,
                  child: Draggable(
                    child: QrImageView(
                      key: UniqueKey(),
                      data: qrCodes[i],
                      size:  50.00,
                    ),
                    feedback: QrImageView(
                      data: qrCodes[i],
                      size: 50,
                    ),
                    onDraggableCanceled: (velocity, offset) {
                      updateQRCodeOffset(i, offset);
                    },
                  ),
                ),
              Positioned(
                bottom: 70,
                child: ElevatedButton(
                  onPressed: (){
                    generateQRCode();
                    flag=1;
                  },
                  child: Text("Create QR Code"),
                ),
              ),
              Positioned(
                bottom: 10,
                child: ElevatedButton(
                  onPressed: (){
                    print(qrCodes.length);
                    print(flag);
                    for (var j = 0; j < qrCodes.length; j++)
                      {
                        print(qrCodes[j]);
                        print(qrCodeOffsets[j].dx);
                        print(qrCodeOffsets[j].dy);


                      }


                  },
                  child: Text("Save Information"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];
  GlobalKey _widgetKey = GlobalKey();
  List<double> widgetWidths = [];
  List<double> widgetHeights = [];

  void measureWidget(int index, Size size) {
    setState(() {
      widgetWidths[index] = size.width;
      widgetHeights[index] = size.height;
    });
  }

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
      widgetWidths.add(0); // Add a default value for the width
      widgetHeights.add(0); // Add a default value for the height
    });
  }

  void updateQRCodeOffset(int index, Offset offset) {
    setState(() {
      qrCodeOffsets[index] = offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Many QR Codes"),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              for (var i = 0; i < qrCodes.length; i++)
                Positioned(
                  left: qrCodeOffsets[i].dx,
                  top: qrCodeOffsets[i].dy,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        measureWidget(i, constraints.biggest);
                      });
                      return Draggable(
                        child: QrImageView(
                          key: UniqueKey(),
                          data: qrCodes[i],
                          size: 50.0,
                        ),
                        feedback: QrImageView(
                          data: qrCodes[i],
                          size: 50.0,
                        ),
                        onDraggableCanceled: (velocity, offset) {
                          updateQRCodeOffset(i, offset);
                        },
                      );
                    },
                  ),
                ),
              Positioned(
                bottom: 70,
                child: ElevatedButton(
                  onPressed: generateQRCode,
                  child: const Text("Create QR Code"),
                ),
              ),
              Positioned(
                bottom: 10,
                child: ElevatedButton(
                  onPressed: () {
                    print(qrCodes.length);
                    for (var j = 0; j < qrCodes.length; j++) {
                      print(qrCodes[j]);
                      print(qrCodeOffsets[j].dx);
                      print(qrCodeOffsets[j].dy);
                      if (j < widgetWidths.length && j < widgetHeights.length) {
                        print(widgetWidths[j]);
                        print(widgetHeights[j]);
                      }
                    }
                  },
                  child: const Text("Save Information"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 */

