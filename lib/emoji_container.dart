

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myfunction/variable.dart';



String onethree="";
String myselectwithimage="";
String mydetctor="";
String selectedIconUrl = "";
String myclickeddata='';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
List<Map<String, dynamic>> dataList = [];

class EmojiContainer extends StatefulWidget {
  const EmojiContainer({Key? key});

  @override
  EmojiContainerState createState() => EmojiContainerState();
}
final List<String> categories = [
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
final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
List<String> emails = [];
List<String> imageUrls = [];
String selectedCategory = "";


class EmojiContainerState extends State<EmojiContainer> {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  double emojiWidth = 50.0;
  // Minimum height & width for the barcode
  double minEmojiWidth = 30.0;


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

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
  Timer? _timer;
  int _counter = 0;

  String documentName = "abc@gmail.com";
  String collectionName = "Detectorrr";
  @override
  void initState() {
    super.initState();
    fetchEmails();
    initializeFirebase();


    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the state variable
      setState(() {
        _counter++;
        checkDocumentExists();

      });
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchEmails();
    initializeFirebase();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the state variable
      setState(() {
        _counter++;
        checkDocumentExists();
      });
    });
  }

  bool documentExists = false;
  void checkDocumentExists() {
    firebaseFirestore
        .collection(collectionName)
        .doc(documentName)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        setState(() {
          documentExists = true;
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          // Access the individual fields from the retrieved data
          onethree = data['data'];

          print('Content Data: $onethree');
        });
      } else {
        setState(() {
          documentExists = false;
        });
      }
    }).catchError((error) {
      print("Error occurred while checking document: $error");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
          height: emojiWidth,
          width: emojiWidth,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: emojiIconBorderWidget ? Border.all(color: Colors.blue,width: 2) : null,
          ),

          child: selectedIconUrl.isNotEmpty
              ? Image.network(selectedIconUrl)
              : null,
        ),
        Positioned(
          right: -32,
          bottom: -35,
          child: GestureDetector(
            onPanUpdate: _handleResizeGesture,
            child: Visibility(
              visible: emojiIconBorder,
              child: const SizedBox(
                width: 64,
                height: 64,
                child: Icon(
                  Icons.touch_app,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ] ,
    );
  }

  ListView getCategories() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return ListViewItem(
          email: categories[index],
          selected: selectedCategory == categories[index],
          onPressed: () {
            setState(() {
              selectedCategory = categories[index];
              print(selectedCategory);
              print("Clicked");
            });
          },
        );
      },
    );
  }

  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newWidth = emojiWidth + details.delta.dx;
      final newHeight = emojiWidth + details.delta.dy;
      emojiWidth = newWidth >= minEmojiWidth ? newWidth : minEmojiWidth;
      emojiWidth = newHeight >= minEmojiWidth ? newHeight : minEmojiWidth;
    });
  }
}

class ListViewItem extends StatelessWidget {
  final String email;
  final VoidCallback? onPressed;
  final bool selected;

  ListViewItem({required this.email, this.onPressed, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Center(
          child: Text(
            email,
            style: selected? TextStyle(fontSize: 16.0,color: Colors.blue,fontWeight: FontWeight.bold):TextStyle(fontSize: 16.0,color: Colors.black),
          ),
        ),
      ),
    );
  }
}



class FirestoreListView2 extends StatefulWidget {
  final String data2;
  final List<String> emails;
  final List<String> imageUrls;

  const FirestoreListView2({Key? key, required this.data2, required this.emails, required this.imageUrls})
      : super(key: key);

  @override
  FirestoreListViewState createState() => FirestoreListViewState();
}

class FirestoreListViewState extends State<FirestoreListView2> {



  Timer? _timer;
  int _counter = 0;
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
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
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
  @override
  void initState() {
    super.initState();


    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the state variable
      setState(() {
        _counter++;
        fetchEmails();
        initializeFirebase();
        print(_counter.toString());

        mydetctor=widget.data2.toString();
        widget.data2;
        fetchData(mydetctor);
        //  print("gettt");

        //print(widget.data2);
      });
    });

  }
  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer?.cancel();
    super.dispose();
  }
  Future<void> fetchData(String colletiondata) async {
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
    //print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    // Fetch emojis that match the selected category
    List<String> selectedCategoryEmails = [];
    List<String> selectedCategoryImageUrls = [];

    for (int i = 0; i < widget.emails.length; i++) {
      if (widget.emails[i] == widget.data2) {
        selectedCategoryEmails.add(widget.emails[i]);
        selectedCategoryImageUrls.add(widget.imageUrls[i]);
      }
    }

    return Container(
      height: 200,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: selectedCategoryEmails.length,
        itemBuilder: (BuildContext context, int index) {
          String email = selectedCategoryEmails[index];
          String imageUrl = selectedCategoryImageUrls[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIconUrl = imageUrl;
                print('Selected Icon URL: $selectedIconUrl');
                addData1(selectedIconUrl);
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.network(
                imageUrl,
              ),
            ),
          );
        },
      ),
    );
  }

}
Future<void> addData1(String dataaddtobe) async{
  try{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    firebaseFirestore.collection("Detectorrr")
        .doc("abc@gmail.com")

        .set({
      "data": ""+dataaddtobe
    });
    print("Added");

  }catch(e)
  {
    print("Error : "+e.toString());
  }
}