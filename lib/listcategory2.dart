/*

import 'package:flutter/material.dart';



class listcategory2 extends StatefulWidget {
  const listcategory2({Key? key}) : super(key: key);

  @override
  State<listcategory2> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<listcategory2> {
  final List<String> emails = [
    "Animals", "Beauty products", "Border", "Celebration", "Certification", "Communication", "Daily", "Direction",
    "Education", "Entertainment", "Foods and Drinks", "Home Appliance", "Human face", "Music", "Nature", "Rank", "Sports",
    "Transport", "Wash", "Weather", "Wedding", "sfasdfs", "dsafdsf", "Try", "new one icon", "Try for it", "Windows",
    "New one to try", "Mir Sult", "Rasel", "Bangladesh", "China", "Target", "try", "last one"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Categories List'),
        ),
        body: ListView.builder(
          itemCount: emails.length,
          itemBuilder: (BuildContext context, int index) {
            return ListViewItem(
              email: emails[index],
              onPressed: () {
                // Pass data to MyPage widget
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => retrivingdata2(data: emails[index]),
                  ),
                );
                 */
              },
            );
          },
        ),
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  final String email;
  final VoidCallback? onPressed;

  ListViewItem({required this.email, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Border radius
        ),
        child: Text(
          email,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

void main() {
  runApp(listcategory2());
}
 */

//second
/*
import 'package:flutter/material.dart';

class listcategory2 extends StatefulWidget {
  const listcategory2({Key? key}) : super(key: key);

  @override
  State<listcategory2> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<listcategory2> {
  final List<String> emails = [
    "Animals", "Beauty products", "Border", "Celebration", "Certification", "Communication", "Daily", "Direction",
    "Education", "Entertainment", "Foods and Drinks", "Home Appliance", "Human face", "Music", "Nature", "Rank", "Sports",
    "Transport", "Wash", "Weather", "Wedding", "sfasdfs", "dsafdsf", "Try", "new one icon", "Try for it", "Windows",
    "New one to try", "Mir Sult", "Rasel", "Bangladesh", "China", "Target", "try", "last one"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Categories List'),
        ),
        body: ListView.builder(
          itemCount: emails.length ~/ 2, // Divide by 2 to display two elements in one row
          itemBuilder: (BuildContext context, int index) {
            final int itemIndex = index * 2;
            return Row(
              children: [
                Expanded(
                  child: ListViewItem(
                    email: emails[itemIndex],
                    onPressed: () {
                      // Pass data to MyPage widget
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => retrivingdata2(data: emails[itemIndex]),
                        ),
                      );
                       */
                    },
                  ),
                ),
                SizedBox(width: 10), // Add some space between the items
                Expanded(
                  child: ListViewItem(
                    email: emails[itemIndex + 1],
                    onPressed: () {
                      // Pass data to MyPage widget
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => retrivingdata2(data: emails[itemIndex + 1]),
                        ),
                      );
                       */
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  final String email;
  final VoidCallback? onPressed;

  ListViewItem({required this.email, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Border radius
        ),
        child: Text(
          email,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

void main() {
  runApp(listcategory2());
}

 */

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:myfunction/retrivingdata2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;
class listcategory2 extends StatefulWidget {
  const listcategory2({Key? key}) : super(key: key);

  @override
  State<listcategory2> createState() => _ListCategoryState();
}
final List<String> emails = [
  "Animals",
  "Beauty products",
  "Border",
  "Celebration",
  "Certification",
  "Communication",
  "Daily",
  "Direction",
  "Education",
  "Entertainment",
  "Foods and Drinks",
  "Home Appliance",
  "Human face",
  "Music",
  "Nature",
  "Rank",
  "Sports",
  "Transport",
  "Wash",
  "Weather",
  "Wedding",
  "sfasdfs",
  "dsafdsf",
  "Try",
  "new one icon",
  "Try for it",
  "Windows",
  "New one to try",
  "Mir Sult",
  "Rasel",
  "Bangladesh",
  "China",
  "Target",
  "try",
  "last one"
];

class _ListCategoryState extends State<listcategory2> {
  // final url = 'http://localhost:5000/tht/allIcons';
  final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
  List<String> emails = [];
  List<String> imageUrls = []; // List to store the image URLs






  Future<void> fetchEmails() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;

        print('Number of emails: ${categories.length}');

        setState(() {
          // Extract email addresses and image URLs and add them to the respective lists
          emails = categories.map((category) => category['categoryName'] as String).toList();
          imageUrls = categories
              .map((category) => category['icon'] as String?)
              .where((icon) => icon != null)
              .map((icon) => 'https://grozziie.zjweiting.com:8033/tht/images/$icon')
              .toList();
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEmails();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Categories List'),
        ),
        body: ListView.builder(
          itemCount: emails.length ~/ 2, // Divide by 2 to display two elements in one row
          itemBuilder: (BuildContext context, int index) {
            final int itemIndex = index * 2;
            final bool isLastItem = itemIndex + 1 >= emails.length;

            return Row(
              children: [
                Expanded(
                  child: ListViewItem(
                    email: emails[itemIndex],
                    onPressed: () async{
                      // Pass data to MyPage widget

                      for (int i = 0; i < emails.length; i++) {
    if (emails[i] == emails[itemIndex]) {
      String dataget = imageUrls[i];
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      bool isDataFound = false;

      checkDocumentExists(dataget).then((value) {
        isDataFound = value;
        if (isDataFound) {
          print('Document with email "ariful@gmail.com" exists.');

        } else {
          print('Document with email "ariful@gmail.com" does not exist.');
          addData(dataget,emails[itemIndex]);
          print("Data Added");
          // elementsMatchingCondition.add(element);
        }
      }).catchError((error) {
        print('An error occurred: $error');
      });

      print(imageUrls[i]);
    }

                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => retrivingdata2(data: emails[itemIndex]),
                        ),
                      );

                      /*

                       */


                    },
                  ),
                ),
                SizedBox(width: 10), // Add some space between the items
                Expanded(
                  child: isLastItem
                      ? SizedBox() // Empty SizedBox for the last item to maintain alignment
                      : ListViewItem(
                    email: emails[itemIndex + 1],
                    onPressed: () {
                      // Pass data to MyPage widget

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => retrivingdata2(data: emails[itemIndex + 1]),
                              ),
                            );

                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  final String email;
  final VoidCallback? onPressed;

  ListViewItem({required this.email, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool isLastItem =
        email == emails[emails.length - 1]; // Check if it's the last item

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: isLastItem ? 10 : 0, // Set bottom margin only for the last item
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(

          email,
          style: TextStyle(fontSize: 12.0),
          textAlign: TextAlign.center, // Align the text in the center
        ),
      ),
    ),
    );
  }
}

void main() {
  runApp(listcategory2());
}
Future<void> addData(String dataaddtobe, String databasename) async{
  try{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    firebaseFirestore.collection(databasename)
        .add({
      "data": ""+dataaddtobe
    });


  }catch(e)
  {
    print("Error : "+e.toString());
  }
}