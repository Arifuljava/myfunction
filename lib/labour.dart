



import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class labour extends StatefulWidget {
  const labour({super.key});

  @override
  State<labour> createState() => _labourState();
}

class _labourState extends State<labour> {
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

  String selectedEmail = '';
  String selectedIconUrl = '';

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
    super.initState();
    fetchEmails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Horizontal Scroll View'),
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
                        selectedIconUrl = imageUrls[index];
                        print(email);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedEmail == email ? Colors.blue : Colors.transparent,
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
              child: selectedIconUrl.isNotEmpty
                  ? Image.network(selectedIconUrl)
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
