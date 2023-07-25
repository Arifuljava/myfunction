
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
    final url = 'https://grozziie.zjweiting.com:8033/tht/check-user';

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
    String email = "arifulpub143@gmail.com";
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
        print("Response");
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
  Future<void> addUserWithEmail() async {
    print("first");
    final String apiUrl = "https://grozziie.zjweiting.com:8033/tht/users/add";

    final Map<String, dynamic> data = {
      "email": "arifulpub14223@gmail.com",
    };

    final headers = {'Content-Type': 'application/json'};
    print("first");
    try {
      print("first");
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonEncode(data));

      print(response);

      if (response.statusCode == 200) {
        print("Data added successfully.");
        // You can handle success here, e.g., show a success message
      } else {
        print("Failed to add data. Status code: ${response.statusCode}");
        // Handle error here, e.g., show an error message
      }
    } catch (e) {
      print("Error occurred: $e");
      // Handle error here, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: Text("Login And Register API"),
       ),
       body: Column(
         children: [
           ElevatedButton(onPressed: () async{
             _checkUser();
             if(_userExists){
               print("User  found");
             }
             else{
               print("User not found");


               addUserWithEmail();


             }
     }, child: Text("Check User"))
         ],

       ),
     ),
   );
  }
}
