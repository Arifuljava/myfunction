
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class loginandregisterapi extends StatefulWidget {
  const loginandregisterapi({super.key});

  @override
  State<loginandregisterapi> createState() => _loginandregisterapiState();
}

class _loginandregisterapiState extends State<loginandregisterapi> {

  bool _userExists = false;

  Future<bool> checkEmailExistence(String email) async {
    final url = 'https://grozziie.zjweiting.com:8033/tht/users';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'email': email},
      );


      if (response.statusCode == 200) {
        // Assuming that the API response returns a boolean value indicating email existence.
        // Adjust this logic based on the API response structure.

        return response.body.toLowerCase() == 'true';
      } else {
        // Handle error response from the API, if needed.
        return false;
      }
    } catch (e) {
      // Handle exceptions, if any.
      return false;
    }
  }

  void _checkUser() async {
    String email = "arif@gmail.com";
    if (email.isNotEmpty) {
      bool exists = await checkEmailExistence(email);

      setState(() {
        _userExists = exists;
        print(_userExists);
      });
    }
  }
  Future<bool> addUser({
    required String name,
    required String email,
    required String password,

  }) async {
    final url = 'https://grozziie.zjweiting.com:8033/tht/users/add';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {

        print(response.body.toLowerCase());
        return response.body.toLowerCase() == 'true';
      } else {

        return false;
      }
    } catch (e) {
      // Handle exceptions, if any.
      return false;
    }
  }
  Future<bool> addusernamy({
    required String name,
    required String image,
    required String phone,
    required String country,
    required String language,
    required String email,
    required String password,
    required String designation,
    required String  isAdmin

  }) async {
    final url = 'https://grozziie.zjweiting.com:8033/tht/users/add';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': name,
          'image':image,
          'phone':phone,
          'country':country,
          'language':language,
          'email': email,
          'password': password,
          'designation':designation,
          'isAdmin':isAdmin
        },
      );

      if (response.statusCode == 200) {

        print(response.body.toLowerCase());
        return response.body.toLowerCase() == 'true';
      } else {

        return false;
      }
    } catch (e) {
      // Handle exceptions, if any.
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: Text("Login And Register API"),
       ),
       body: Center(
         child: Column(
             children: [
               ElevatedButton(onPressed: () async{
                 _checkUser();
                 if(_userExists){
                   print("User  found");
                 }
                 else{
                   print("User not found");
                   /*
                    'name': name,
          'image':image,
          'phone':phone,
          'country':country,
          'language':language,
          'email': email,
          'password': password,
          'designation':designation,
          'isAdmin':isAdmin
                    */

                  /*
                   String name = 'John Doe11';
                   String phone="122222";
                   String country="122222";
                   String language="122222";


                   // Replace this with the name you want to add
                   String email = 'john11@example.com'; // Replace this with the email you want to add
                   String password = 'mysecretpassword'; // Replace this with the password you want to add
                   String image = 'https://example.com/profile.jpg'; // Replace this with the image URL you want to add
                   String designation="122222";
                   String isAdmin="122222";

                   bool isSuccess = await addusernamy(
                     name: name,
                     image: image,
                     phone: phone,
                     country:country,
                     language:language,
                     email: email,
                     password: password,
                       designation:designation,
                       isAdmin:isAdmin

                   );

                   if (isSuccess) {
                     print('User added successfully.');
                   } else {
                     print('Failed to add user.');
                   }

                   */


                 }
               }, child: Text("Check User"))
             ]
         ),


       ),
     ),
   );
  }
}
