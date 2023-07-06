


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;

class retrivingdata2 extends StatefulWidget {
  final String data;
  const retrivingdata2({Key? key,required this.data}) : super(key: key);

  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}
late   String detector = "";
class _MyFirebaseAppState extends State<retrivingdata2> {
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
    super.initState();
    fetchEmails();
    initializeFirebase();
    detector = widget.data.toString();
    print(imageUrls);


    print(detector);


  }



  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }



  @override
  Widget build(BuildContext context) {
    final elementsMatchingCondition = <Widget>[];
    final remainingElements = <Widget>[];

    for (int i = 0; i < emails.length; i++) {
      final element = Container(
        margin: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            // Handle the tap/click event here
            // You can navigate to a new screen, show a dialog, or perform any desired action
            print('Image tapped! Index: $i');
          },
          child: Column(
            children: [
              Image.network(
                imageUrls[i],
                width: 48,
                height: 48,
              ),
              const SizedBox(height: 10),
              Text(emails[i]),
            ],
          ),
        ),
      );

      if (emails[i] == detector) {

        String dataget = imageUrls[i];


        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        bool isDataFound = false;

        checkDocumentExists(dataget).then((value) {
          isDataFound = value;
          if (isDataFound) {
            print('Document with email "ariful@gmail.com" exists.');

          } else {
            print('Document with email "ariful@gmail.com" does not exist.');
            addData(dataget);
            print("Data Added");
            // elementsMatchingCondition.add(element);
          }
        }).catchError((error) {
          print('An error occurred: $error');
        });

        print(imageUrls[i]);
      } else {
        // remainingElements.add(element);
      }
    }

    return MaterialApp(
      title: detector+' Icon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirestoreListView(),
    );
  }
}
Future<void> addData(String dataaddtobe) async{
  try{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    firebaseFirestore.collection(detector)
        .add({
      "data": ""+dataaddtobe
    });


  }catch(e)
  {
    print("Error : "+e.toString());
  }
}
Future<bool> checkDocumentExists(String email) async {
  final collectionRef = FirebaseFirestore.instance.collection(detector);
  final querySnapshot = await collectionRef.where('data', isEqualTo: email).get();

  return querySnapshot.size > 0;
}

class FirestoreListView extends StatefulWidget {
  @override
  _FirestoreListViewState createState() => _FirestoreListViewState();
}

class _FirestoreListViewState extends State<FirestoreListView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
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
      QuerySnapshot snapshot = await _firestore.collection(detector).get();

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
    return Scaffold(
      appBar: AppBar(
        title: Text(detector+" Icons "),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust the cross axis count as per your requirement
        ),
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> item = dataList[index];
          return Image.network(
            item['data'],
            width: 30,
            height: 30,
          );
        },
      ),
    );
  }
}
