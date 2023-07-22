/*class _QrcodeContainerState extends State<QrcodeContainer> {
  double qrcodeSize = 100.0;
  double minQrcodeSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
            border: Border.all(
              color: Colors.blueAccent
            )
          ),
          child: QrImageView(
            data: widget.qrcodeData,
            backgroundColor: Colors.white,
            version: QrVersions.auto,
            size: qrcodeSize,
          ),
        ),
        Positioned(
          right: -32,
          bottom: -36,
          child: GestureDetector(
            onPanUpdate: _handleResizeGesture,
            child: const SizedBox(
              width: 64,
              height: 64,
              child: Icon(
                Icons.touch_app,
                color: Colors.grey,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newQrcodeSize = qrcodeSize + details.delta.dx;

      qrcodeSize =
      newQrcodeSize >= minQrcodeSize ? newQrcodeSize : minQrcodeSize;
    });
  }
}*/
import 'package:flutter/material.dart';
import 'package:myfunction/created_lavel_main.dart';
import 'package:myfunction/variable.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'barcode_editing_container.dart';

class QrcodeContainer extends StatefulWidget {

  final String qrcodeData;

  QrcodeContainer({super.key, required this.qrcodeData, });

  @override
  State<QrcodeContainer> createState() => _QrcodeContainerState();
}

class _QrcodeContainerState extends State<QrcodeContainer> {
  double qrcodeSize = 100.0;
  double minQrcodeSize = 50.0;



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < qrCodes.length; i++)
          Container(
            decoration: BoxDecoration(
              border: qrcodeIconBorder ? Border.all(color: selectedQRCodeIndex == i ? Colors.blue : Colors.transparent,
                width: 2.0,) : null,
              //border: qrcodeIconBorder ? Border.all(color: Colors.blue,width: 2) : null,
            ),
            child: QrImageView(
              data: widget.qrcodeData,
              backgroundColor: Colors.transparent,
              version: QrVersions.auto,
              size: qrcodeSize,
            ),
          ),
        Positioned(
          right: -32,
          bottom: -36,
          child: GestureDetector(
            onPanUpdate: _handleResizeGesture,
            child: Visibility(
              visible:qrcodeIconBorder,
              child: const SizedBox(
                width: 64,
                height: 64,
                child: Icon(
                  Icons.touch_app,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newQrcodeSize = qrcodeSize + details.delta.dx;
      qrcodeSize =
      newQrcodeSize >= minQrcodeSize ? newQrcodeSize : minQrcodeSize;
    });
  }
}