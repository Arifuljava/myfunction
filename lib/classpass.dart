



import 'package:flutter/material.dart';
import 'package:myfunction/mylisttt.dart';
List<String>list1=["ff","tt","uuu"];
class classpass extends StatefulWidget {
  const classpass({super.key});

  @override
  State<classpass> createState() => _classpassState();
}

class _classpassState extends State<classpass> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Class Pass"),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: (){
              setState(() {
                list1[0]="taaa";
                print("First");
                _classpassState2();
                print(list1);
              });

            }, child: Text("Add Element"))
          ],
        ),
      ),

    );
  }
}

class classpass2 extends StatefulWidget {
const classpass2({super.key});

@override
State<classpass2> createState() => _classpassState2();
}


class _classpassState2 extends State<classpass2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      list1[1]="Tamim";
      print("Added");
    });

  }
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(

     ),

   );
  }

}