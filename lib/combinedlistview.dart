
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CombinedListView extends StatefulWidget {
  const CombinedListView({Key? key}) : super(key: key);

  @override
  State<CombinedListView> createState() => _CombinedListViewState();
}
List<String> emails = [];
List<String> imageUrls = [];
String selectedEmail = '';
class _CombinedListViewState extends State<CombinedListView> {
  final List<String> categoryList = [
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
          title: Text('Icon Categories List'),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(categoryList.length, (int index) {
                  final String email = categoryList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEmail = email;
                        print(email);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
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
            Expanded(
              child: ListView.builder(
                itemCount: emails.length,
                itemBuilder: (BuildContext context, int index) {
                  final String email = emails[index];
                  return GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        children: selectedEmail == "Border"
                            ? [
                          Image.network(
                            imageUrls[index],
                            width: 48,
                            height: 48,
                          ),
                          SizedBox(height: 10),
                          Text(email, style: TextStyle(fontSize: 16.0)),
                        ]
                            : [],
                      ),
                    ),
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

class retrievingData extends StatelessWidget {
  final String data;

  retrievingData({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieving Data'),
      ),
      body: Center(
        child: Text(data),
      ),
    );
  }
}
