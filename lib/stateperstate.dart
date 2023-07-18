



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class stateperstate extends StatefulWidget {
  const stateperstate({super.key});

  @override
  State<stateperstate> createState() => _stateperstateState();
}

class _stateperstateState extends State<stateperstate> {


  Timer? _timer;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Start the timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the state variable
      setState(() {
        _counter++;



      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
body: Center(
  child: Text('Counter value: $_counter'),
),
      ),
    );
  }
}


