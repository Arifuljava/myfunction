import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfunction/app_style.dart';
import 'package:myfunction/barcode_editing_container.dart';
import 'package:myfunction/created_lavel_main.dart';
import 'package:myfunction/qrcode_editing_container.dart';

import 'package:qr_flutter/qr_flutter.dart';


//TextEditingController globalController = TextEditingController();
FocusNode globalFocusNode = FocusNode();

class ScannerContainer extends StatefulWidget {
  const ScannerContainer({super.key});

  @override
  ScannerContainerState createState() => ScannerContainerState();
}

String barcodeScanRes = '';
bool showTextResult = false;
bool showBarcode = false;
bool showQRCode = false;
Widget? resultWidget;

class ScannerContainerState extends State<ScannerContainer> {



  double scanContainerWidth = 100.0;
  double scanContainerHeight = 100.0;

  // Minimum height & width for the barcode
  double minScanContainerWidth = 50.0;
  double minScanContainerHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if(showTextResult)
          Text(barcodeScanRes, style: bodySmall),
        if (showBarcode)
          InkWell(
              onTap: (){
                setState(() {
                  showBarcodeContainerFlag = true;
                });
              },
              child: BarcodeContainer(barcodeData: barcodeScanRes,)),
        /*Container(
          height: scanContainerHeight,
          width: scanContainerWidth,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: scanBorderWidget ? Border.all(color: Colors.blue,width: 2) : null,
          ),
          child: ,
        ),
        Positioned(
          right: -32,
          bottom: -35,
          child: GestureDetector(
            onPanUpdate: _handleResizeGesture,
            child: const SizedBox(
              width: 64,
              height: 64,
              child: Icon(
                Icons.touch_app,
                color: Colors.grey,
                size: 35,
              ),
            ),
          ),
        ),*/

        if (showQRCode)
          InkWell(
              onTap: (){
                setState(() {
                  showQrcodeContainerFlag = true;
                });
              },
              child: QrcodeContainer(qrcodeData: barcodeScanRes,))
        /*Container(
              height: scanContainerHeight,
              width: scanContainerHeight,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: scanBorderWidget ? Border.all(color: Colors.blue,width: 2) : null,
              ),
              child: BarcodeWidget(
                color: Colors.black,
                barcode: Barcode.qrCode(),
                data: barcodeScanRes,
                width: scanContainerHeight,
                height: scanContainerHeight,
              )
          ),
        Positioned(
          right: -32,
          bottom: -35,
          child: GestureDetector(
            onPanUpdate: _handleResizeGesture,
            child: const SizedBox(
              width: 64,
              height: 64,
              child: Icon(
                Icons.touch_app,
                color: Colors.grey,
                size: 35,
              ),
            ),
          ),
        ),*/
      ],
    );
  }



  Widget buildResultWidget() {
    if (showBarcode) {
      return BarcodeWidget(
        barcode: Barcode.code128(),
        data: barcodeScanRes,
        width: scanContainerHeight,
        height: scanContainerHeight,
        style: bodySmall,
      );
    } else if (showQRCode) {
      return BarcodeWidget(
        barcode: Barcode.qrCode(),
        data: barcodeScanRes,
        width: scanContainerHeight,
        height: scanContainerHeight,
      );
    } else {
      return Text(barcodeScanRes, style: bodySmall);
    }
  }

  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newWidth = scanContainerWidth + details.delta.dx;
      final newHeight = scanContainerHeight + details.delta.dy;
      scanContainerWidth = newWidth >= minScanContainerWidth
          ? newWidth
          : minScanContainerWidth;
      scanContainerHeight = newHeight >= minScanContainerHeight
          ? newHeight
          : minScanContainerHeight;
    });
  }
}


