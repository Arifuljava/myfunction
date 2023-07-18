

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
                        print(qrCodeOffsets[j].dx);

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

