


import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class selectwithwithcustom extends StatefulWidget {
  const selectwithwithcustom({super.key});

  @override
  State<selectwithwithcustom> createState() => _selectwithwithcustomState();
}
String selectedEmail = '';
final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
class _selectwithwithcustomState extends State<selectwithwithcustom> {

  final List<String> emails111 = [
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
          print(imageUrls);
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
          title: Text('Horizontal Scroll View'),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(emails111.length, (int index) {
                  final String email = emails111[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEmail = email;
                        print(email);
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


                          if (emails[i] == selectedEmail) {
                            print("true");
                            elementsMatchingCondition.add(element);
                            String dataget = imageUrls[i];



                            print(imageUrls[i]);


                          } else {
                            // remainingElements.add(element);
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
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.black26,


            )


          ],

        ),
      ),
    );
  }
}

