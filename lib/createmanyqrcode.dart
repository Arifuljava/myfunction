import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_core/firebase_core.dart';


class CreateManyQRCode extends StatefulWidget {
  const CreateManyQRCode({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<CreateManyQRCode> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];
  int? selectedQRCodeIndex;

  List<String> barcodes = [];
  List<Offset> barcodeOffsets = [];
  int? selectedBarcodeIndex;

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

  void _showDeleteAlertDialog(int selectIndex) {
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
                  if (inputText.isEmpty) {
                    // Do nothing
                  } else {
                    print(inputText);
                    qrCodes[selectIndex] = inputText;
                    print(selectIndex);
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

  void generateBarcode() {
    setState(() {
      barcodes.add('Barcode ${barcodes.length + 1}');
      barcodeOffsets.add(Offset(0, (barcodes.length * 5).toDouble()));
    });
  }

  void updateBarcodeOffset(int index, Offset offset) {
    setState(() {
      barcodeOffsets[index] = offset;
    });
  }

  void deleteBarcode() {
    if (selectedBarcodeIndex != null) {
      setState(() {
        barcodes.removeAt(selectedBarcodeIndex!);
        barcodeOffsets.removeAt(selectedBarcodeIndex!);
        selectedBarcodeIndex = null;
      });
    }
  }

  void _showDeleteBarcodeAlertDialog(int selectIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputText = '';

        return AlertDialog(
          title: Text('Delete Barcode'),
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
                  if (inputText.isEmpty) {
                    // Do nothing
                  } else {
                    print(inputText);
                    barcodes[selectIndex] = inputText;
                    print(selectIndex);
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
  FirebaseFirestore  firebaseFirestore=FirebaseFirestore.instance;
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    firebaseFirestore = FirebaseFirestore.instance;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Many QR Codes and Barcodes"),
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
                        onTap: () {
                          setState(() {
                            selectedQRCodeIndex = i;
                            selectedBarcodeIndex = null;
                          });
                        },
                        onLongPress: () {
                          selectedQRCodeIndex = i;
                          _showDeleteAlertDialog(selectedQRCodeIndex!);
                        },
                        child: QrImageView(
                          data: qrCodes[i],
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              for (var i = 0; i < barcodes.length; i++)
                Positioned(
                  left: barcodeOffsets[i].dx,
                  top: barcodeOffsets[i].dy,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      Offset newPosition = Offset(
                        barcodeOffsets[i].dx + details.delta.dx,
                        barcodeOffsets[i].dy + details.delta.dy,
                      );
                      updateBarcodeOffset(i, newPosition);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedBarcodeIndex == i ? Colors.blue : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedBarcodeIndex = i;
                            selectedQRCodeIndex = null;
                          });
                        },
                        onLongPress: () {
                          selectedBarcodeIndex = i;
                          _showDeleteBarcodeAlertDialog(selectedBarcodeIndex!);
                        },
                        child: BarcodeWidget(
                          data: barcodes[i],
                          width: 50,
                          height: 50, barcode: Barcode.code128(),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 110,
                child: ElevatedButton(
                  onPressed: (){
                    generateQRCode();
                    qrcodeflag=2;
                    print("Clikced");
                  },
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
                  onLongPress: () {
                    print("Long");
                  },
                  child: Text("Save Information"),
                ),
              ),
              Positioned(
                bottom: 30,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedQRCodeIndex == null) {
                      print("Select a QR code to delete");
                    } else {
                      print(selectedQRCodeIndex);
                      deleteQRCode();
                    }
                  },
                  child: Text("Delete QR Code"),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        generateBarcode();
                        barcode_flag=2;
                      },
                      child: Text("Create Barcode"),
                    ),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        print(barcodes.length);
                        for (var j = 0; j < barcodes.length; j++) {
                          print(barcodes[j]);
                          print(barcodeOffsets[j].dx);
                          print(barcodeOffsets[j].dy);
                        }
                      });
                    }, child: Text("Get Information")),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        if (selectedBarcodeIndex == null) {
                          print("Select a QR code to delete");
                        } else {
                          print(selectedBarcodeIndex);
                          deleteBarcode();
                        }
                      });
                    }, child: Text("Delete Barcode"))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: (){
                    if(qrcodeflag==2)
                      {
                        for(var i=0;i<qrCodes.length;i++)
                          {
                           //
                            print(qrCodes[i]);
                            if(i==0)
                              {
                                AddElement("ElementList", "qrcode",'qrcode',qrCodes.length);
                                addData("ElementList", "qrcode", qrCodes[i],( qrCodeOffsets[i].dx).toString(), ( qrCodeOffsets[i].dy).toString(), (50).toString(), (50).toString(), qrCodes.length,i);

                              }
                            else{
                              addData("ElementList", "qrcode", qrCodes[i],( qrCodeOffsets[i].dx).toString(), ( qrCodeOffsets[i].dy).toString(), (50).toString(), (50).toString(), qrCodes.length,i);

                            }
                          }

                      }

                    if(barcode_flag==2)
                    {
                      for(var i=0;i<barcodes.length;i++)
                      {
                        //
                        print(barcodes[i]);
                        if(i==0)
                        {
                          AddElement("ElementList", "barcode",'barcode',barcodes.length);
                          addData("ElementList", "barcode", barcodes[i],( barcodeOffsets[i].dx).toString(), ( barcodeOffsets[i].dy).toString(), (50).toString(), (50).toString(), barcodes.length,i);

                        }
                        else{
                          addData("ElementList", "barcode", barcodes[i],( barcodeOffsets[i].dx).toString(), ( barcodeOffsets[i].dy).toString(), (50).toString(), (50).toString(), barcodes.length,i);

                        }
                      }

                    }

                  },
                  child: Text("Save All information"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

int barcode_flag=1;
int qrcodeflag=1;
Future<void> addData(String databasename, String documentname, String contentData,String positionx,String positiony,String widget_w,String widget_h,int howmanyelement,int index ) async {
  try {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Specify the name of your collection
    firebaseFirestore.collection(databasename).doc(documentname).collection("List").doc((index).toString()).set({
      "contentdata": contentData,
      "positionx":positionx,
      "positiony":positiony,
      "widget_w":widget_w,
      "widget_h":widget_h,
      "index":(index).toString(),
      "length":(howmanyelement).toString()

    });
    print("Added");
  } catch (e) {
    print("Error: $e");
  }
}
Future<void> AddElement(String databasename, String documentname, String contentData,int howmanyelement ) async {
  try {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Specify the name of your collection
    firebaseFirestore.collection(databasename).doc(documentname).set({
      "contentdata": contentData,
      "howmanyelement":(howmanyelement).toString(),


    });
    print("Added");
  } catch (e) {
    print("Error: $e");
  }
}
//generate bar code

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
              Container(
                alignment: Alignment.bottomRight,
                child: Column(

                  children: [
                    ElevatedButton(onPressed: (){}, child: Text("Create Bar Code"))
                  ],
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

