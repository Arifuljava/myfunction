


import 'package:flutter/material.dart';

class createtable extends StatefulWidget {
  const createtable({super.key});

  @override
  State<createtable> createState() => _createtableState();
}

class _createtableState extends State<createtable> {
  List<Table> tableList = [];

  @override
  void initState() {
    super.initState();
  }

  Table _createTable() {
    return Table(
      border: TableBorder.all(), // Add border to the table (optional)
      children: [
        TableRow(
          children: [
            TableCell(
              child: Center(
                child: Text('Row 1, Column 1'),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Row 1, Column 2'),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(
                child: Text('Row 2, Column 1'),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Row 2, Column 2'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Table List"),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Add a new table to the list when the button is pressed
                  tableList.add(_createTable());
                });
              },
              child: Text("Add a table"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tableList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    height: 150,
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: tableList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}