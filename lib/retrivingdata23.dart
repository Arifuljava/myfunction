


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;


late   String detector = "";
class ShowIconContainer extends StatefulWidget {
  final String data;
  const ShowIconContainer({Key? key,required this.data}) : super(key: key);

  @override
  _ShowIconContainerState createState() => _ShowIconContainerState();
}
final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
List<String> emails = [];
List<String> imageUrls = [];

class _ShowIconContainerState extends State<ShowIconContainer> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Firestore ListView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: FirestoreListView(),
    );
  }
}


Future<void> addData(String dataaddtobe) async{
  try{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    firebaseFirestore.collection(mydetctor)
        .add({
      "data": ""+dataaddtobe
    });


  }catch(e)
  {
    print("Error : "+e.toString());
  }
}
String mydetctor="";
Future<bool> checkDocumentExists(String email) async {
  final collectionRef = FirebaseFirestore.instance.collection(mydetctor);
  final querySnapshot = await collectionRef.where('data', isEqualTo: email).get();

  return querySnapshot.size > 0;
}


class FirestoreListView extends StatefulWidget {
  final String data2;

  const FirestoreListView({super.key, required this.data2});

  @override
  _FirestoreListViewState createState() => _FirestoreListViewState();
}


class _FirestoreListViewState extends State<FirestoreListView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
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
    print("MyDtaa");
    fetchEmails();
    mydetctor=widget.data2.toString();
    widget.data2;
    fetchData(mydetctor);



    print(widget.data2);





  }

  Future<void> fetchData(String colletiondata) async {
    print("Hello");
    print(colletiondata);
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];


    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();
      print(mycollection);

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    print("ariful++++2");
    print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < emails.length; i++) {
      print("ariful++++++4");

      if (emails[i] == mydetctor) {

        String dataget = imageUrls[i];
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust the cross axis count as per your requirement
            ),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = dataList[index];

              print("ariful++++3");
              print(emails.length);
              print(item['data']);
              return Image.network(
                item['data'],

              );

            },
          ),
        ),
      ),
    );
  }
}
//for buty products

class FirestoreListView1 extends StatefulWidget {
  final String data2;

  const FirestoreListView1({super.key, required this.data2});

  @override
  _FirestoreListViewState1 createState() => _FirestoreListViewState1();
}

class _FirestoreListViewState1 extends State<FirestoreListView1> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
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
    print("MyDtaa");
    fetchEmails();
    mydetctor=widget.data2.toString();
    widget.data2;
    fetchData(mydetctor);



    print(widget.data2);





  }

  Future<void> fetchData(String colletiondata) async {
    print("Hello");
    print(colletiondata);
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];


    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();
      print(mycollection);

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    print("ariful++++2");
    print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < emails.length; i++) {
      print("ariful++++++4");

      if (emails[i] == mydetctor) {

        String dataget = imageUrls[i];
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust the cross axis count as per your requirement
            ),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = dataList[index];

              print("ariful++++3");
              print(emails.length);
              print(item['data']);
              return Image.network(
                item['data'],

              );

            },
          ),
        ),
      ),
    );
  }
}
//border


class FirestoreListView2 extends StatefulWidget {
  final String data2;

  const FirestoreListView2({super.key, required this.data2});

  @override
  _FirestoreListViewState2 createState() => _FirestoreListViewState2();
}

class _FirestoreListViewState2 extends State<FirestoreListView2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
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
    print("MyDtaa");
    fetchEmails();
    mydetctor=widget.data2.toString();
    widget.data2;
    fetchData(mydetctor);



    print(widget.data2);





  }

  Future<void> fetchData(String colletiondata) async {
    print("Hello");
    print(colletiondata);
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];


    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();
      print(mycollection);

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    print("ariful++++2");
    print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < emails.length; i++) {
      print("ariful++++++4");

      if (emails[i] == mydetctor) {

        String dataget = imageUrls[i];
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust the cross axis count as per your requirement
            ),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = dataList[index];

              print("ariful++++3");
              print(emails.length);
              print(item['data']);
              return Image.network(
                item['data'],

              );

            },
          ),
        ),
      ),
    );
  }
}
//Celebration

class FirestoreListView3 extends StatefulWidget {
  final String data2;

  const FirestoreListView3({super.key, required this.data2});

  @override
  _FirestoreListViewState3 createState() => _FirestoreListViewState3();
}

class _FirestoreListViewState3 extends State<FirestoreListView3> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
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
    print("MyDtaa");
    fetchEmails();
    mydetctor=widget.data2.toString();
    widget.data2;
    fetchData(mydetctor);



    print(widget.data2);





  }

  Future<void> fetchData(String colletiondata) async {
    print("Hello");
    print(colletiondata);
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];


    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();
      print(mycollection);

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    print("ariful++++2");
    print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < emails.length; i++) {
      print("ariful++++++4");

      if (emails[i] == mydetctor) {

        String dataget = imageUrls[i];
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust the cross axis count as per your requirement
            ),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = dataList[index];

              print("ariful++++3");
              print(emails.length);
              print(item['data']);
              return Image.network(
                item['data'],

              );

            },
          ),
        ),
      ),
    );
  }
}
//5
class FirestoreListView4 extends StatefulWidget {
  final String data2;

  const FirestoreListView4({super.key, required this.data2});

  @override
  _FirestoreListViewState4 createState() => _FirestoreListViewState4();
}

class _FirestoreListViewState4 extends State<FirestoreListView4> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
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
    print("MyDtaa");
    fetchEmails();
    mydetctor=widget.data2.toString();
    widget.data2;
    fetchData(mydetctor);



    print(widget.data2);





  }

  Future<void> fetchData(String colletiondata) async {
    print("Hello");
    print(colletiondata);
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];


    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();
      print(mycollection);

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    print("ariful++++2");
    print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < emails.length; i++) {
      print("ariful++++++4");

      if (emails[i] == mydetctor) {

        String dataget = imageUrls[i];
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust the cross axis count as per your requirement
            ),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = dataList[index];

              print("ariful++++3");
              print(emails.length);
              print(item['data']);
              return Image.network(
                item['data'],

              );

            },
          ),
        ),
      ),
    );
  }
}
//6
class FirestoreListView5 extends StatefulWidget {
  final String data2;

  const FirestoreListView5({super.key, required this.data2});

  @override
  _FirestoreListViewState5 createState() => _FirestoreListViewState5();
}

class _FirestoreListViewState5 extends State<FirestoreListView5> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
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
    print("MyDtaa");
    fetchEmails();
    mydetctor=widget.data2.toString();
    widget.data2;
    fetchData(mydetctor);



    print(widget.data2);





  }

  Future<void> fetchData(String colletiondata) async {
    print("Hello");
    print(colletiondata);
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];


    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();
      print(mycollection);

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    print("ariful++++2");
    print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < emails.length; i++) {
      print("ariful++++++4");

      if (emails[i] == mydetctor) {

        String dataget = imageUrls[i];
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust the cross axis count as per your requirement
            ),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = dataList[index];

              print("ariful++++3");
              print(emails.length);
              print(item['data']);
              return Image.network(
                item['data'],

              );

            },
          ),
        ),
      ),
    );
  }
}
//7
class FirestoreListView6 extends StatefulWidget {
  final String data2;

  const FirestoreListView6({super.key, required this.data2});

  @override
  _FirestoreListViewState6 createState() => _FirestoreListViewState6();
}

class _FirestoreListViewState6 extends State<FirestoreListView6> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
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
    print("MyDtaa");
    fetchEmails();
    mydetctor=widget.data2.toString();
    widget.data2;
    fetchData(mydetctor);



    print(widget.data2);





  }

  Future<void> fetchData(String colletiondata) async {
    print("Hello");
    print(colletiondata);
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];


    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();
      print(mycollection);

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    print("ariful++++2");
    print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < emails.length; i++) {
      print("ariful++++++4");

      if (emails[i] == mydetctor) {

        String dataget = imageUrls[i];
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust the cross axis count as per your requirement
            ),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = dataList[index];

              print("ariful++++3");
              print(emails.length);
              print(item['data']);
              return Image.network(
                item['data'],

              );

            },
          ),
        ),
      ),
    );
  }
}
//8
class FirestoreListView7 extends StatefulWidget {
  final String data2;

  const FirestoreListView7({super.key, required this.data2});

  @override
  _FirestoreListViewState7 createState() => _FirestoreListViewState7();
}

class _FirestoreListViewState7 extends State<FirestoreListView7> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
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
    print("MyDtaa");
    fetchEmails();
    mydetctor=widget.data2.toString();
    widget.data2;
    fetchData(mydetctor);



    print(widget.data2);





  }

  Future<void> fetchData(String colletiondata) async {
    print("Hello");
    print(colletiondata);
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];


    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();
      print(mycollection);

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    print("ariful++++2");
    print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < emails.length; i++) {
      print("ariful++++++4");

      if (emails[i] == mydetctor) {

        String dataget = imageUrls[i];
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust the cross axis count as per your requirement
            ),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = dataList[index];

              print("ariful++++3");
              print(emails.length);
              print(item['data']);
              return Image.network(
                item['data'],

              );

            },
          ),
        ),
      ),
    );
  }
}