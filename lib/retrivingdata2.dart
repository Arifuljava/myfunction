


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


  @override
  void initState() {
    super.initState();

    initializeFirebase();
    detector = widget.data.toString();



    print(detector);


  }



  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }



  @override
  Widget build(BuildContext context) {


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
        title: Text(detector + " Icons "),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust the cross axis count as per your requirement
        ),
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> item = dataList[index];
          return Container(
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
              fit: BoxFit
                  .cover, // Adjust the fit property as per your requirement
            ),
          );
        },
      ),
    );
  }
}