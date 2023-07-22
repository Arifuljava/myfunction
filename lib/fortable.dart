
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(fortableApp());
}

class fortableApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: fortable(),
    );
  }
}

class fortable extends StatefulWidget {
  const fortable({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<fortable> {
  List<TableData> generateTable = [TableData('Initial QR Code', Offset(0, 0))];
  List<Offset> tableffsets = [Offset(0, 0)];
  int? selectedTableCodeIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Many Table"),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            for (var i = 0; i < generateTable.length; i++)
              Positioned(
                left: tableffsets[i].dx,
                top: tableffsets[i].dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    Offset newPosition = Offset(
                      tableffsets[i].dx + details.delta.dx,
                      tableffsets[i].dy + details.delta.dy,
                    );
                    generateTable[i].updateQRCodeOffset(i, newPosition, tableffsets);
                    setState(() {});
                  },
                  child: Transform.translate(
                    offset: tableffsets[i],
                    child: Container(
                      width: 100,
                      height: 100,
                      color: selectedTableCodeIndex == i ? Colors.red : Colors.blue,
                      child: Center(
                        child: Text(generateTable[i].qrCodeText),
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 110,
              child: ElevatedButton(
                onPressed: () {
                  Offset offset = Offset(0, 0);
                  TableData("II", offset).generateQRCode(generateTable, tableffsets);
                  setState(() {});
                },
                child: Text("Create Table"),
              ),
            ),
            Positioned(
              bottom: 70,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save information
                },
                child: Text("Save Information"),
              ),
            ),
            Positioned(
              bottom: 30,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Delete Table Code
                },
                child: Text("Delete Table Code"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableData {
  String qrCodeText;
  Offset tableOffset;

  TableData(this.qrCodeText, this.tableOffset);

  void updateQRCodeOffset(int index, Offset offset, List<Offset> tableOffsets) {
    tableOffsets[index] = offset;
  }

  void deleteQRCode(int index, List<TableData> generateTable, List<Offset> tableOffsets) {
    generateTable.removeAt(index);
    tableOffsets.removeAt(index);
  }

  void generateQRCode(List<TableData> generateTable, List<Offset> tableOffsets) {
    generateTable.add(TableData('QR Code ${generateTable.length + 1}', Offset(0, (generateTable.length * 5).toDouble())));
    tableOffsets.add(Offset(0, (generateTable.length * 5).toDouble()));
  }
}



/*
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class fortable extends StatefulWidget {
  const fortable({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<fortable> {
  List<TableData> generateTable = [];
  List<Offset> tableffsets = [];
  int? selectedTableCodeIndex;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Many Table"),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              for (var i = 0; i < generateTable.length; i++)
                Positioned(
                  left: tableffsets[i].dx,
                  top: tableffsets[i].dy,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      Offset newPosition = Offset(
                        tableffsets[i].dx + details.delta.dx,
                        tableffsets[i].dy + details.delta.dy,
                      );
                      generateTable[i].updateQRCodeOffset(i, newPosition, tableffsets);
                      setState(() {});
                    },
                    child: Transform.translate(
                      offset: tableffsets[i],
                      child: Container(
                        width: 100,
                        height: 100,
                        color: selectedTableCodeIndex == i ? Colors.red : Colors.blue,
                        child: Center(
                          child: Text(generateTable[i].qrCodeText),
                        ),

                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 110,
                child: ElevatedButton(
                  onPressed: (){
                    Offset offset = Offset(0, 0);
                    TableData("II",offset).generateQRCode(generateTable, tableffsets);
                    setState(() {});

                  },
                  child: Text("Create Table"),
                ),
              ),
              Positioned(
                bottom: 70,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: Text("Save Information"),
                ),
              ),
              Positioned(
                bottom: 30,
                child: ElevatedButton(
                  onPressed: (){

                  },
                  child: Text("Delete Table Code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class TableData {
  String qrCodeText;
  Offset tableOffset;

  TableData(this.qrCodeText, this.tableOffset);


  void updateQRCodeOffset(int index, Offset offset, List<Offset> tableOffsets) {
    tableOffsets[index] = offset;
  }

  void deleteQRCode(int index, List<TableData> generateTable, List<Offset> tableOffsets) {
    generateTable.removeAt(index);
    tableOffsets.removeAt(index);
  }
  void generateQRCode(List<TableData> generateTable, List<Offset> tableOffsets) {
    generateTable.add(TableData('QR Code ${generateTable.length + 1}', Offset(0, (generateTable.length * 5).toDouble())));
  }

}

 */

/*
import 'package:flutter/material.dart';

class fortable extends StatefulWidget {
  const fortable({Key? key}) : super(key: key);

  @override
  _CreateManyQRCodeState createState() => _CreateManyQRCodeState();
}

class _CreateManyQRCodeState extends State<fortable> {
  List<String> qrCodes = [];
  List<Offset> qrCodeOffsets = [];
  int? selectedQRCodeIndex;

  void generateQRCode() {
    setState(() {
      qrCodes.add('QR Code ${qrCodes.length + 1}');
      qrCodeOffsets.add(Offset(0, (qrCodes.length * 5).toDouble()));
    });
  }

  void generateQRCodeTable() {
    setState(() {
      qrCodes.clear();
      qrCodeOffsets.clear();
      // Generating a 2x2 table
      for (var i = 0; i < 4; i++) {
        // You can add some default data here if needed
        qrCodes.add('Data ${i + 1}');
        qrCodeOffsets.add(Offset((i % 2) * 150, (i ~/ 2) * 150));
      }
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
          title: Text("2x2 Table"),
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
                      width: 100,
                      height: 100,
                      color: Colors.grey, // You can customize the cell appearance here
                      child: Center(
                        child: Text(
                          qrCodes[i],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 150,
                left: 16,
                child: ElevatedButton(
                  onPressed: generateQRCodeTable,
                  child: Text("Create Table"),
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
                  child: Text("Delete Data"),
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
