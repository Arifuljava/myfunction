


import 'package:flutter/material.dart';

class positionied extends StatefulWidget {
  const positionied({super.key});

  @override
  State<positionied> createState() => _positioniedState();
}

class _positioniedState extends State<positionied> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Positioned Container Example'),
        ),
        body: Stack(
          children: [
            Positioned(
              left: 100, // X coordinate
              top: 200, // Y coordinate
              child: Container(
                width: 200,
                height: 100,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
