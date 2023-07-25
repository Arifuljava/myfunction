import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ZoomInZoomOut extends StatefulWidget {
  const ZoomInZoomOut({Key? key}) : super(key: key);

  @override
  _ZoomInZoomOutState createState() => _ZoomInZoomOutState();
}

class _ZoomInZoomOutState extends State<ZoomInZoomOut> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];
  int? selectedQRCodeIndex;

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
    });
  }

  void updateQRCodeOffset(int index, double sizeDelta) {
    double newSize = 50 + sizeDelta; // Increase the size based on the vertical drag distance.
    setState(() {
      qrCodeOffsets[index] = Offset(qrCodeOffsets[index].dx, qrCodeOffsets[index].dy);
    });
  }

  void deleteQRCode() {
    if (selectedQRCodeIndex != null) {
      setState(() {
        qrCodes.removeAt(selectedQRCodeIndex!);
        qrCodeOffsets.removeAt(selectedQRCodeIndex!);
        selectedQRCodeIndex = null;
      });
    }
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
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      double sizeDelta = details.delta.dy;
                      updateQRCodeOffset(i, sizeDelta);
                    },
                    child: Transform.translate(
                      offset: qrCodeOffsets[i],
                      child: QrImageView(
                        data: qrCodes[i],
                        size: 50,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 110,
                child: ElevatedButton(
                  onPressed: generateQRCode,
                  child: Text("Create QR Code"),
                ),
              ),
              Positioned(
                bottom: 70,
                child: ElevatedButton(
                  onPressed: () {
                    print(qrCodes.length);
                    for (var j = 0; j < qrCodes.length; j++) {
                      print(qrCodes[j]);
                      print(qrCodeOffsets[j].dx);
                      print(qrCodeOffsets[j].dy);
                    }
                  },
                  child: Text("Save Information"),
                ),
              ),
              Positioned(
                bottom: 30,
                child: ElevatedButton(
                  onPressed: () {
                    print(selectedQRCodeIndex);
                    deleteQRCode();
                  },
                  child: Text("Delete QR Code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(ZoomInZoomOut());
}
