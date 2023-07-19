


import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];
  int? selectedQRCodeIndex;

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
    });
  }

  void updateQRCodeOffset(int index, Offset offset) {
    setState(() {
      qrCodeOffsets[index] = offset;
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
  void _showDeleteAlertDialog(int selectindex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputText = '';

        return AlertDialog(
          title: Text('Delete QR Code'),
          content: TextField(
            onChanged: (value) {
              inputText = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter confirmation text',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  if(inputText==null)
                    {

                    }
                  else
                    {
                      print(inputText);
                      qrCodes[selectindex]=inputText;
                      print(selectindex);
                    }

                });

              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
  bool selectforborder= false;
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
                      Offset newPosition = Offset(
                        qrCodeOffsets[i].dx + details.delta.dx,
                        qrCodeOffsets[i].dy + details.delta.dy,
                      );
                      updateQRCodeOffset(i, newPosition);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedQRCodeIndex == i ? Colors.blue : Colors.transparent,
                          width: 2.0,
                        ),
                      ),

                      child: InkWell(
                        onTap: (){
                          setState(() {
                            selectedQRCodeIndex = i;
                            print(selectedQRCodeIndex);
                            selectforborder=true;

                          });
                        },
                        onLongPress: (){
                          selectedQRCodeIndex = i;
                          _showDeleteAlertDialog(selectedQRCodeIndex!);
                          print("onLong");


                        },

                        child: QrImageView(
                          data: qrCodes[i],
                          size: 50,
                        ),
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
                  onLongPress: (){
                    print("Long");
                  },
                  child: Text("Save Information"),
                ),
              ),
              Positioned(
                bottom: 30,
                child: ElevatedButton(
                  onPressed: (){
                    if(selectedQRCodeIndex==null)
                      {
                        print("Select a widget");
                      }
                    else
                      {
                        print(selectedQRCodeIndex);
                        deleteQRCode();
                      }

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


/*
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];
  List<bool> selectedQRCodeList = [];

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
      selectedQRCodeList.add(false);
    });
  }

  void updateQRCodeOffset(int index, Offset offset) {
    setState(() {
      qrCodeOffsets[index] = offset;
    });
  }

  void deleteQRCode() {
    setState(() {
      qrCodes = qrCodes
          .asMap()
          .entries
          .where((entry) => !selectedQRCodeList[entry.key])
          .map((entry) => entry.value)
          .toList();
      qrCodeOffsets = qrCodeOffsets
          .asMap()
          .entries
          .where((entry) => !selectedQRCodeList[entry.key])
          .map((entry) => entry.value)
          .toList();
      selectedQRCodeList = selectedQRCodeList
          .asMap()
          .entries
          .where((entry) => !selectedQRCodeList[entry.key])
          .map((entry) => entry.value)
          .toList();
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
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                for (var i = 0; i < qrCodeOffsets.length; i++) {
                  if (selectedQRCodeList[i]) {
                    qrCodeOffsets[i] = Offset(
                      qrCodeOffsets[i].dx + details.delta.dx,
                      qrCodeOffsets[i].dy + details.delta.dy,
                    );
                  }
                }
              });
            },
            child: Stack(
              children: <Widget>[
                for (var i = 0; i < qrCodes.length; i++)
                  Positioned(
                    left: qrCodeOffsets[i].dx,
                    top: qrCodeOffsets[i].dy,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedQRCodeList[i] = !selectedQRCodeList[i];
                        });
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
                    onPressed: (){
                      print(selectedQRCodeList);
                    },
                    child: Text("Delete QR Code"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(CreateManyQRCode());
}


 */


/*
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];
  int? selectedQRCodeIndex;

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
    });
  }

  void updateQRCodeOffset(int index, Offset offset) {
    setState(() {
      qrCodeOffsets[index] = offset;
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
                      Offset newPosition = Offset(
                        qrCodeOffsets[i].dx + details.delta.dx,
                        qrCodeOffsets[i].dy + details.delta.dy,
                      );
                      updateQRCodeOffset(i, newPosition);
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
                  onPressed: (){
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
 */


/*
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];
  int? selectedQRCodeIndex;

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
    });
  }

  void updateQRCodeOffset(int index, Offset offset) {
    setState(() {
      qrCodeOffsets[index] = offset;
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
                    onTap: () {
                      setState(() {
                        selectedQRCodeIndex = i;
                      });
                    },
                    child: QrImageView(
                      data: qrCodes[i],
                      size: 50,
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
                  onPressed: deleteQRCode,
                  child: Text("Delete QR Code"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */

/*
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
    });
  }

  void updateQRCodeOffset(int index, Offset offset) {
    setState(() {
      qrCodeOffsets[index] = offset;
    });
  }

  void deleteQRCode(int index) {
    setState(() {
      qrCodes.removeAt(index);
      qrCodeOffsets.removeAt(index);
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
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      Offset newPosition = Offset(
                        qrCodeOffsets[i].dx + details.delta.dx,
                        qrCodeOffsets[i].dy + details.delta.dy,
                      );
                      updateQRCodeOffset(i, newPosition);
                    },
                    child: QrImageView(
                      data: qrCodes[i],
                      size: 50,
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
                    if (qrCodes.isNotEmpty) {
                      deleteQRCode(qrCodes.length - 1);
                    }
                  },
                  child: Text("Delete QR Code"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */

/*
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
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
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      Offset newPosition = Offset(
                        qrCodeOffsets[i].dx + details.delta.dx,
                        qrCodeOffsets[i].dy + details.delta.dy,
                      );
                      updateQRCodeOffset(i, newPosition);
                    },
                    child: QrImageView(
                      data: qrCodes[i],
                      size: 50,
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
                  print("Clicked");
                  },
                  child: Text("Delete QR Code"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */



/*
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
    });
  }

  void moveQRCode(int index, Offset delta) {
    setState(() {
      qrCodeOffsets[index] += delta;
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
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: generateQRCode,
                child: Text("Create QR Code"),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onPanUpdate: (details) {
                  // Calculate the delta movement
                  Offset delta = details.delta;

                  // Iterate through each QR code and update its position
                  for (int i = 0; i < qrCodeOffsets.length; i++) {
                    moveQRCode(i, delta);
                  }
                },
                child: Stack(
                  children: qrCodes
                      .asMap()
                      .map(
                        (index, qrCode) => MapEntry(
                      index,
                      Positioned(
                        left: qrCodeOffsets[index].dx,
                        top: qrCodeOffsets[index].dy,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            // Move the individual QR code
                            moveQRCode(index, details.delta);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            child: QrImageView(
                              data: qrCode,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      .values
                      .toList(),
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





/*

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
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
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: generateQRCode,
                child: Text("Create QR Code"),
              ),
              SizedBox(height: 10),
              Column(
                children: qrCodes
                    .asMap()
                    .map(
                      (index, qrCode) => MapEntry(
                    index,
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: QrImageView(
                        data: qrCode,
                        size: 50,
                      ),
                    ),
                  ),
                )
                    .values
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */


/*
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
 */



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

