



/*
import 'package:flutter/material.dart';
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
class horizontallylist extends StatefulWidget {
  const horizontallylist({super.key});

  @override
  State<horizontallylist> createState() => _horizontallylistState();
}
TextEditingController textt=new TextEditingController();
 String selectedEmail = 'Animals';
class _horizontallylistState extends State<horizontallylist> {
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


//data get

  final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
  List<String> emails1 = [];
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
          emails1 = categories.map((category) => category['categoryName'] as String).toList();
          imageUrls = categories
              .map((category) => category['icon'] as String?)
              .where((icon) => icon != null)
              .map((icon) => 'https://grozziie.zjweiting.com:8033/tht/images/$icon')
              .toList();
          print(imageUrls);
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEmails();
    initializeFirebase();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Horizontal Scroll View'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.black26,
              child: MaterialApp(
                home: Scaffold(
                  body: Column(
                    children: [
                      FirestoreListView1(myyy: "Animals")

                    ],
                  ),
                ),
              ),

            ),


            SizedBox(height: 20),

            Container(
              height: 50,
              width: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List<Widget>.generate(emails.length, (int index) {
                      final String email = emails[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedEmail = email;
                            textt.text="HHHHHH";
                            print(emails[index]);
                            for (int i = 0; i < emails.length; i++) {

    if (emails[i] == emails[index]) {
      String dataget = imageUrls[i];
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      bool isDataFound = false;

      checkDocumentExists(dataget,selectedEmail).then((value) {
        isDataFound = value;
        if (isDataFound) {
          print('Document with email "ariful@gmail.com" exists.');


        } else {
          print('Document with email "ariful@gmail.com" does not exist.');
          addData(dataget,emails[index]);
          print("Data Added");

          // elementsMatchingCondition.add(element);
        }
      }).catchError((error) {
        print('An error occurred: $error');
      });

      print(imageUrls[i]);

    }
                            }

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedEmail == email
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                          child: Text(email),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),


          ],
        ),
      ),
    );
  }


}

Future<bool> checkDocumentExists(String email, String selectedEmail) async {
  final collectionRef = FirebaseFirestore.instance.collection(selectedEmail);
  final querySnapshot = await collectionRef.where('data', isEqualTo: email).get();

  return querySnapshot.size > 0;
}

Future<void> addData(String dataaddtobe, String email) async{
  try{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    firebaseFirestore.collection(email)
        .add({
      "data": ""+dataaddtobe
    });


  }catch(e)
  {
    print("Error : "+e.toString());
  }
}

class FirestoreListView1 extends StatefulWidget {
  final String  myyy;

  FirestoreListView1({required this.myyy});
  @override
  _FirestoreListViewState1 createState() => _FirestoreListViewState1();
}

class _FirestoreListViewState1 extends State<FirestoreListView1> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();

    print("se");

  }
  Future<void> fetchData() async {
    List<Map<String, dynamic>> data = await getFirestoreData();
    setState(() {
      dataList = data;
    });
  }
  Future<List<Map<String, dynamic>>> getFirestoreData() async {
    List<Map<String, dynamic>> dataList = [];


    try {
      QuerySnapshot snapshot = await _firestore.collection(selectedEmail.toString()).get();

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    return dataList;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> item = dataList[index];
            return GestureDetector(
              onTap: () {
                // Handle onTap event here
                print('Container tapped at index $index');
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                child: Image.network(
                  item['data'],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ) ,
    );
  }

}

 */

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: horizontallylist(),
    );
  }
}
String selectedEmail="";

class horizontallylist extends StatefulWidget {
  const horizontallylist({Key? key}) : super(key: key);

  @override
  State<horizontallylist> createState() => _horizontallylistState();
}

class _horizontallylistState extends State<horizontallylist> {
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

  //data get
  final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
  List<String> emails1 = [];
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
          emails1 = categories.map((category) => category['categoryName'] as String).toList();
          imageUrls = categories
              .map((category) => category['icon'] as String?)
              .where((icon) => icon != null)
              .map((icon) => 'https://grozziie.zjweiting.com:8033/tht/images/$icon')
              .toList();
          print(imageUrls);
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    fetchEmails();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Horizontal Scroll View'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.black26,
              child: FirestoreListView1(myyy: "Animals",),

            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List<Widget>.generate(emails.length, (int index) {
                      final String email = emails[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // Handle onTap event here
                            print('Container tapped at index $index');
                            // Update the selectedEmail and perform other necessary operations
                            selectedEmail = email;


                            for (int i = 0; i < emails.length; i++) {

                              if (emails[i] == emails[index]) {
                                String dataget = imageUrls[i];
                                FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                                bool isDataFound = false;

                                checkDocumentExists(dataget,selectedEmail).then((value) {
                                  isDataFound = value;
                                  if (isDataFound) {
                                    print('Document with email "ariful@gmail.com" exists.');
                                   return  MaterialApp(
                                      home: Scaffold(
                                        body: Column(
                                          children: [
                                            FirestoreListView1(myyy: ""+selectedEmail,)
                                          ],
                                        ),
                                      ),
                                    );


                                  } else {
                                    print('Document with email "ariful@gmail.com" does not exist.');
                                    addData(dataget,emails[index]);
                                    print("Data Added");
                                    MaterialApp(
                                      home: Scaffold(
                                        body: Column(
                                          children: [
                                            FirestoreListView1(myyy: ""+selectedEmail,)
                                          ],
                                        ),
                                      ),
                                    );

                                    // elementsMatchingCondition.add(element);
                                  }
                                }).catchError((error) {
                                  print('An error occurred: $error');
                                });

                                print(imageUrls[i]);

                              }
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                          child: Text(email),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class FirestoreListView1 extends StatefulWidget {
  final String myyy;

  FirestoreListView1({required this.myyy});

  @override
  _FirestoreListViewState1 createState() => _FirestoreListViewState1();
}

class _FirestoreListViewState1 extends State<FirestoreListView1> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    print(widget.myyy);
  }

  Future<void> fetchData() async {
    List<Map<String, dynamic>> data = await getFirestoreData();
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData() async {
    List<Map<String, dynamic>> dataList = [];

    try {
      QuerySnapshot snapshot = await _firestore.collection(widget.myyy).get();

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> item = dataList[index];
                  return GestureDetector(
                    onTap: () {
                      // Handle onTap event here
                      print('Container tapped at index $index');
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      child: Image.network(
                        item['data'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
Future<bool> checkDocumentExists(String email, String selectedEmail) async {
  final collectionRef = FirebaseFirestore.instance.collection(selectedEmail);
  final querySnapshot = await collectionRef.where('data', isEqualTo: email).get();

  return querySnapshot.size > 0;
}

Future<void> addData(String dataaddtobe, String email) async{
  try{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    firebaseFirestore.collection(email)
        .add({
      "data": ""+dataaddtobe
    });


  }catch(e)
  {
    print("Error : "+e.toString());
  }
}