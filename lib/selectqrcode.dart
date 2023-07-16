


import 'package:flutter/material.dart';

class selectqrcode extends StatefulWidget {
  const selectqrcode({super.key});

  @override
  State<selectqrcode> createState() => _selectqrcodeState();
}

class _selectqrcodeState extends State<selectqrcode> {
  int selectedQRCodeIndex = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR Code Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BarcodeImage(
                imagePath: 'assets/images/barcode.png',
                isSelected: selectedQRCodeIndex == -1,
                  onTap: () {
                    setState(() {
                      selectedQRCodeIndex = 0;
                    });
                  }

              ),
              QRCodeImage(
                imagePath: 'assets/qrcode.png',
                isSelected: selectedQRCodeIndex == 0,
                onTap: () {
                  setState(() {
                    selectedQRCodeIndex = 0;
                  });
                },
              ),
              //qrcode 2
              QRCodeImage1(
                imagePath: 'assets/qrcode.png',
                isSelected: selectedQRCodeIndex == 1,
                onTap: () {
                  setState(() {
                    selectedQRCodeIndex = 1;
                  });
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}

class BarcodeImage extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const BarcodeImage({required this.imagePath, required this.isSelected,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle barcode image tap event
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Image.asset(
          imagePath,
          width: 200.0,
          height: 100.0,
        ),
      ),
    );
  }
}
//
class QRCodeImage1 extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const QRCodeImage1({required this.imagePath, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Image.asset(
          imagePath,
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }
}
//
class QRCodeImage extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const QRCodeImage({required this.imagePath, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Image.asset(
          imagePath,
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }
}