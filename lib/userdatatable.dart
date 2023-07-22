/*




import 'package:flutter/material.dart';

class UserDataTable extends StatefulWidget {
  @override
  _UserDataTableState createState() => _UserDataTableState();
}



double tableContainerX = 0;
double tableContainerY = 0;
List<String> tableCodes = ['Table 1'];
List<Offset> tableOffsets = [Offset.zero, Offset(0, 100)];
int selectedTableCodeIndex = 0;


class _UserDataTableState extends State<UserDataTable> {
  List<List<TextEditingController>> controllers = [
    [TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController()],
  ];

  void addRow() {
    setState(() {
      controllers.add(List.generate(
          controllers[0].length, (index) => TextEditingController()));
    });
  }

  void removeRow() {
    if (controllers.length > 2) {
      setState(() {
        controllers.removeLast();
      });
    }
  }

  void addColumn() {
    setState(() {
      for (var row in controllers) {
        row.add(TextEditingController());
      }
    });
  }

  void removeColumn() {
    if (controllers[0].length > 2) {
      setState(() {
        for (var row in controllers) {
          row.removeLast();
        }
      });
    }
  }
  void generateTableCode() {
    setState(() {
      tableCodes.add('Table ${tableCodes.length + 1}');
      tableOffsets.add(Offset(0, (tableCodes.length * 5).toDouble()));
    });
  }

  void deleteTableCode() {
    if (selectedTableCodeIndex != null) {
      setState(() {
        tableCodes.removeAt(selectedTableCodeIndex);
        tableOffsets.removeAt(selectedTableCodeIndex);
        selectedTableCodeIndex = 0;
      });
    }
  }

  @override
  void dispose() {
    for (var row in controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  double tableWidth = 100.0;
  double tableHeight = 80.0;

  // Minimum height & width for the barcode
  double minTableWidth = 80.0;
  double minTableHeight = 50.0;

  List<List<bool>> editMode = [
    [false, false],
    [false, false],
  ];

  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newWidth = tableWidth + details.delta.dx;
      final newHeight = tableHeight + details.delta.dy;
      tableWidth = newWidth >= minTableWidth ? newWidth : minTableWidth;
      tableHeight = newHeight >= minTableHeight ? newHeight : minTableHeight;
    });
  }

  void _showInputDialog(BuildContext context, int rowIndex, int colIndex) {
    String tempInput = controllers[rowIndex][colIndex].text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        tempInput = value; // Update temporary input
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      // Update the table cell with the confirmed input value
                      controllers[rowIndex][colIndex].text = tempInput;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data Table'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  for (var i = 0; i < tableCodes.length; i++)
                    Positioned(
                      left: tableContainerX + tableOffsets[i].dx,
                      top: tableContainerY + tableOffsets[i].dy,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            tableOffsets[i] = Offset(
                              tableOffsets[i].dx + details.delta.dx,
                              tableOffsets[i].dy + details.delta.dy,
                            );
                          });
                        },
                        onTapDown: (details){
                          selectedTableCodeIndex = i;
                          print("CVlicked");
                          print(selectedTableCodeIndex);
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: tableWidth,
                              height: tableHeight,
                              color: Colors.transparent,
                              child: Table(
                                defaultColumnWidth: const IntrinsicColumnWidth(),
                                border: TableBorder.all(
                                    width: 2, color: Colors.black),
                                children: [
                                  for (var rowIndex = 0; rowIndex <
                                      controllers.length; rowIndex++)
                                    TableRow(
                                      children: [
                                        for (var colIndex = 0; colIndex <
                                            controllers[rowIndex]
                                                .length; colIndex++)
                                          TableCell(
                                            child: SizedBox(
                                              height: tableHeight /
                                                  controllers.length,
                                              child: TextButton(
                                                onPressed: () {
                                                  if (selectedTableCodeIndex == i) {
                                                    print("tab");
                                                    //_showInputDialog(context, rowIndex, colIndex);
                                                  }
                                                },
                                                child: Text(
                                                  controllers[rowIndex][colIndex]
                                                      .text,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                ],
                              ),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              color: Colors.black45,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: addRow,
                        child: const Text('Add Row'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: removeRow,
                        child: const Text('Remove Row'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: addColumn,
                        child: const Text('Add Column'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: removeColumn,
                        child: const Text('Remove Column'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          generateTableCode();
                        },
                        child: const Text('Generate Table'),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: () {
                          deleteTableCode();
                        },
                        child: const Text('Delete Table'),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
