
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfunction/retrivingdata23.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class mylist extends StatefulWidget {
  const mylist({super.key});

  @override
  State<mylist> createState() => _mylistState();
}
final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
List<String> emails = [];
List<String> imageUrls = [];
String selectedCategory = "";
class _mylistState extends State<mylist> {
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

  final List<String> categories = [
    "Animals", "Beauty products", "Border", "Celebration", "Certification", "Communication", "Daily", "Direction",
    "Education", "Entertainment", "Foods and Drinks", "Home Appliance", "Human face", "Music", "Nature", "Rank", "Sports",
    "Transport", "Wash", "Weather", "Wedding", "sfasdfs", "dsafdsf", "Try", "new one icon", "Try for it", "Windows",
    "New one to try", "Mir Sult", "Rasel", "Bangladesh", "China", "Target", "try", "last one"
  ];

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
  @override
  void initState() {
    super.initState();
    fetchEmails();
    initializeFirebase();
  }
  bool selectindex= false;
  bool selectindex1= false;
  bool selectindex2= false;
  bool selectindex3= false;
  //4-8
  bool selectindex4= false;
  bool selectindex5= false;
  bool selectindex6= false;
  bool selectindex7= false;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < emails.length; i++) {
      if (emails[i] == detector) {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Categories List'),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListViewItem(
                    email: categories[index],
                    onPressed: () {



                      setState(() {
                        selectedCategory = categories[index];
                        if(selectedCategory.toString()=="Animals")
                          {
                            selectindex= true;
                            selectindex1=false;
                            selectindex2=false;
                            selectindex3=false;
                            selectindex4= false;
                            selectindex5= false;
                            selectindex6= false;
                            selectindex7= false;
                            print("ariful++++1");
                            print(selectedCategory);
                            print("Clicked");
                          }
                        else if(selectedCategory.toString()=="Beauty products")
                        {
                          selectindex= false;
                          selectindex1=true;
                          selectindex2=false;
                          selectindex3=false;

                          selectindex4= false;
                          selectindex5= false;
                          selectindex6= false;
                          selectindex7= false;


                          print("ariful++++7");
                          print(selectedCategory);
                          print("Clicked");
                        }
                        //3
                        else if(selectedCategory.toString()=="Border")
                        {
                          selectindex= false;
                          selectindex1=false;
                          selectindex2=true;
                          selectindex3=false;

                          selectindex4= false;
                          selectindex5= false;
                          selectindex6= false;
                          selectindex7= false;

                          print("ariful++++7");
                          print(selectedCategory);
                          print("Clicked");
                        }
                        //4
                        else if(selectedCategory.toString()=="Celebration")
                        {
                          selectindex= false;
                          selectindex1=false;
                          selectindex2=false;
                          selectindex3=true;

                          selectindex4= false;
                          selectindex5= false;
                          selectindex6= false;
                          selectindex7= false;


                          print("ariful++++7");
                          print(selectedCategory);
                          print("Clicked");
                        }
                        //5
                        else if(selectedCategory.toString()=="Certification")
                        {
                          selectindex= false;
                          selectindex1=false;
                          selectindex2=false;
                          selectindex3=false;

                          selectindex4= true;
                          selectindex5= false;
                          selectindex6= false;
                          selectindex7= false;


                          print("ariful++++7");
                          print(selectedCategory);
                          print("Clicked");
                        }
                        //6
                        else if(selectedCategory.toString()=="Communication")
                        {
                          selectindex= false;
                          selectindex1=false;
                          selectindex2=false;
                          selectindex3=false;

                          selectindex4= false;
                          selectindex5= true;
                          selectindex6= false;
                          selectindex7= false;


                          print("ariful++++7");
                          print(selectedCategory);
                          print("Clicked");
                        }
                        //7
                        else if(selectedCategory.toString()=="Daily")
                        {
                          selectindex= false;
                          selectindex1=false;
                          selectindex2=false;
                          selectindex3=false;

                          selectindex4= false;
                          selectindex5= false;
                          selectindex6= true;
                          selectindex7= false;


                          print("ariful++++7");
                          print(selectedCategory);
                          print("Clicked");
                        }
                        //8
                        else if(selectedCategory.toString()=="Direction")
                        {
                          selectindex= false;
                          selectindex1=false;
                          selectindex2=false;
                          selectindex3=true;

                          selectindex4= false;
                          selectindex5= false;
                          selectindex6= false;
                          selectindex7= true;


                          print("ariful++++7");
                          print(selectedCategory);
                          print("Clicked");
                        }
                        //9


                      });


                      /*// Pass data to MyPage widget
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowIconContainer(data: categories[index]),
                        ),
                      );*/

                    },
                  );
                },
              ),
            ),

           if(selectindex)



              Container(
                 height: 300,
                 width: double.infinity,
                 color: Colors.white,
                 child: FirestoreListView(data2: selectedCategory,),

               ),

            if(selectindex1)



              Container(
                height: 300,
                width: double.infinity,
                color: Colors.white,
                child: FirestoreListView1(data2: selectedCategory,),

              ),
            if(selectindex2)



              Container(
                height: 300,
                width: double.infinity,
                color: Colors.white,
                child: FirestoreListView2(data2: selectedCategory,),

              ),
            if(selectindex3)



              Container(
                height: 300,
                width: double.infinity,
                color: Colors.white,
                child: FirestoreListView3(data2: selectedCategory,),

              ),
            if(selectindex4)



              Container(
                height: 300,
                width: double.infinity,
                color: Colors.white,
                child: FirestoreListView4(data2: selectedCategory,),

              ),
            if(selectindex5)



              Container(
                height: 300,
                width: double.infinity,
                color: Colors.white,
                child: FirestoreListView5(data2: selectedCategory,),

              ),
            if(selectindex6)



              Container(
                height: 300,
                width: double.infinity,
                color: Colors.white,
                child: FirestoreListView6(data2: selectedCategory,),

              ),
            if(selectindex7)



              Container(
                height: 300,
                width: double.infinity,
                color: Colors.white,
                child: FirestoreListView7(data2: selectedCategory,),

              )



          ],
        ),
      ),
    );
  }


}


class ListViewItem extends StatefulWidget {
  final String email;
  final VoidCallback? onPressed;

  ListViewItem({required this.email, this.onPressed});

  @override
  _ListViewItemState createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = true;
        });

        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.red : Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Center(
          child: Text(
            widget.email,
            style: TextStyle(
              fontSize: 16.0,
              color:  Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}