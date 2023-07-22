/*
import 'package:flutter/material.dart';

class TableContainer extends StatefulWidget {
  const TableContainer({Key? key}) : super(key: key);

  @override
  TableContainerState createState() => TableContainerState();
}

List<List<TextEditingController>> controllers = [
  [TextEditingController(), TextEditingController()],
  [TextEditingController(), TextEditingController()],
];

double tableWidth = 100.0;
double tableHeight = 80.0;

// Minimum height & width for the barcode
double minTableWidth = 80.0;
double minTableHeight = 50.0;

List<List<bool>> editMode = [
  [false, false],
  [false, false],
];

class TableContainerState extends State<TableContainer> {

  @override
  void dispose() {
    for (var row in controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: tableWidth,
          height: tableHeight,
          color: Colors.transparent,
          child: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder.all(width: 2, color: Colors.black),
            children: [
              for (var rowIndex = 0; rowIndex < controllers.length; rowIndex++)
                TableRow(
                  children: [
                    for (var colIndex = 0;
                        colIndex < controllers[rowIndex].length;
                        colIndex++)
                      TableCell(
                        child: SizedBox(
                          height: tableHeight / controllers.length,
                          child: GestureDetector(
                            onDoubleTap: () {
                              setState(() {
                                editMode[rowIndex][colIndex] = true;
                              });
                            },
                            child: editMode[rowIndex][colIndex]
                                ? TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    controller: controllers[rowIndex][colIndex],
                                    autofocus: true,
                                    onEditingComplete: () {
                                      setState(() {
                                        editMode[rowIndex][colIndex] = false;
                                      });
                                    },
                                  )
                                : Text(
                                    controllers[rowIndex][colIndex].text,
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
    );
  }

  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newWidth = tableWidth + details.delta.dx;
      final newHeight = tableHeight + details.delta.dy;
      tableWidth = newWidth >= minTableWidth ? newWidth : minTableWidth;
      tableHeight = newHeight >= minTableHeight ? newHeight : minTableHeight;
    });
  }

}*/


import 'package:flutter/material.dart';


class TableData {
  List<List<TextEditingController>> controllers;
  List<List<bool>> editMode;

  TableData({
    required int rows,
    required int cols,
  })  : controllers = List.generate(
    rows,
        (rowIndex) => List.generate(cols, (colIndex) => TextEditingController()),
  ),
        editMode = List.generate(
          rows,
              (rowIndex) => List.generate(cols, (colIndex) => false),
        );
}


class TableContainer extends StatefulWidget {
  const TableContainer({Key? key}) : super(key: key);

  @override
  TableContainerState createState() => TableContainerState();
}


List<TableData> tableDataList = [
  TableData(rows: 2, cols: 2),
  TableData(rows: 2, cols: 2),
];


List<List<TextEditingController>> controllers = [
  [TextEditingController(), TextEditingController()],
  [TextEditingController(), TextEditingController()],
];

double tableWidth = 100.0;
double tableHeight = 80.0;
// Minimum height & width for the barcode
double minTableWidth = 80.0;
double minTableHeight = 50.0;

List<List<bool>> editMode = [
  [false, false],
  [false, false],
];

class TableContainerState extends State<TableContainer> {

  @override
  void dispose() {
    for (var tableData in tableDataList) {
      for (var row in tableData.controllers) {
        for (var controller in row) {
          controller.dispose();
        }
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: tableWidth,
          height: tableHeight,
          color: Colors.transparent,
          child: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder.all(width: 2, color: Colors.black),
            children: [
              for (var rowIndex = 0; rowIndex < tableDataList.length; rowIndex++)
                TableRow(
                  children: [
                    for (var colIndex = 0;
                    colIndex < tableDataList[rowIndex].controllers.length;
                    colIndex++)
                      TableCell(
                        child: SizedBox(
                          height: tableHeight / tableDataList.length,
                          child: GestureDetector(
                            onDoubleTap: () {
                              setState(() {
                                tableDataList[rowIndex].editMode[rowIndex][colIndex] = true;
                              });
                            },
                            child: tableDataList[rowIndex].editMode[rowIndex][colIndex]
                                ? TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              controller:
                              tableDataList[rowIndex].
                              controllers[rowIndex][colIndex],
                              autofocus: true,
                              onEditingComplete: () {
                                setState(() {
                                  tableDataList[rowIndex].editMode[rowIndex][colIndex] = false;
                                });
                              },
                            )
                                : Text(
                              tableDataList[rowIndex].controllers[rowIndex][colIndex].text,
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
    );
  }

  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newWidth = tableWidth + details.delta.dx;
      final newHeight = tableHeight + details.delta.dy;
      tableWidth = newWidth >= minTableWidth ? newWidth : minTableWidth;
      tableHeight = newHeight >= minTableHeight ? newHeight : minTableHeight;
    });
  }

}