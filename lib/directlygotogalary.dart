



import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;


class directlygotogalary extends StatefulWidget {
  const directlygotogalary({super.key});

  @override
  State<directlygotogalary> createState() => _directlygotogalaryState();
}
final List<String> category = [
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

String selectedCategory = "";
String selectedIconUrl = "";
List<String> emails1 = [];
List<String> imageUrls = []; // List to store the image URLs


class _directlygotogalaryState extends State<directlygotogalary> {

  final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';

  Future<bool> checkDocumentExists(String email, databasename) async {
    final collectionRef = FirebaseFirestore.instance.collection(databasename);
    final querySnapshot =
    await collectionRef.where('data', isEqualTo: email).get();
    return querySnapshot.size > 0;
  }

  Future<void> addData(String dataaddtobe, String databasename) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      firebaseFirestore.collection(databasename).add({
        "data": "" + dataaddtobe
      });
    } catch (e) {
      print("Error : " + e.toString());
    }
  }

  Future<void> fetchEmails() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;
        print('Number of emails: ${categories.length}');
        setState(() {
          // Extract email addresses and image URLs and add them to the respective lists
          emails1 = categories
              .map((category) => category['categoryName'] as String)
              .toList();
          imageUrls = categories
              .map((category) => category['icon'] as String?)
              .where((icon) => icon != null)
              .map((icon) =>
          'https://grozziie.zjweiting.com:8033/tht/images/$icon')
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Categories List'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey,
              child: selectedIconUrl.isNotEmpty
                  ? Image.network(selectedIconUrl)
                  : null,
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.grey,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(
                  children: List.generate(
                    category.length,
                        (index) => ListViewItem(
                      email: category[index],
                      onPressed: () async {
                        setState(() {
                          selectedCategory = category[index];
                          selectedIconUrl = '';
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 300,
              width: 400,
              color: Colors.black12,
              child: getIconContent(selectedCategory),
            ),
          ],
        ),
      ),
    );
  }
  Widget getIconContent(String selectedCategory) {
    if (selectedCategory == "Border") {
      print(selectedCategory);

      // Return the content for animal icons
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[200],
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIconUrl = imageUrls[index];
                });
              },
              child: Image.network(imageUrls[index]
              ,),
            ),
          );
        },
      );
    } else {
      // Return default content
      return Center(
        child: Text(
          'Select a category to see its icons',
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }
  //
  /*Widget getIconContent22(String selectedCategory) {
    if (selectedCategory == "Border") {
      print(selectedCategory);

      // Return the content for animal icons
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[200],
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIconUrl = imageUrls[index];
                });
              },
              child: Image.network(imageUrls[index]
                ,),
            ),
          );
        },
      );
    } else {
      // Return default content
      return Center(
        child: Text(
          'Select a category to see its icons',
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }*/
}

class ListViewItem extends StatelessWidget {
  final String email;
  final VoidCallback? onPressed;

  ListViewItem({required this.email, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool isLastItem =
        email == category[category.length - 1]; // Check if it's the last item

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
