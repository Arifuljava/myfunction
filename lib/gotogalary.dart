





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_manager/file_manager.dart';
import 'package:file_manager/file_manager.dart' as file_manager;
class gotogalary extends StatefulWidget {


  const gotogalary({super.key});

  @override
  State<gotogalary> createState() => _gotogalaryState();
}

class _gotogalaryState extends State<gotogalary> {
  late List<CameraDescription> cameras;


  List<XFile>_imageList=[];
  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null) {
      setState(() {
        _imageList = selectedImages;
      });
    }
  }


  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    // You can store the cameras list and use it later when needed.
  }
  Future<void> _openGallery() async {
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    // Process the selected images
    if (selectedImages != null) {
      // Do something with the selected images
    }
  }
  Future<void> openGalleryDirectory() async {
    if (await Permission.storage.request().isGranted) {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final galleryDirectory = Directory('${directory.path}/Pictures');
        // Do something with the gallery directory
        print(galleryDirectory.path);

      }
    } else {
      // Handle the case when the user denies permission
      print('Permission denied');
    }
  }

  //file manager

  @override
  Widget build(BuildContext context) {
   return  MaterialApp(
     home:  Scaffold(
       appBar: AppBar(
         title: Text("Go to image Section",style: TextStyle(fontSize: 12),),
       ),
       body: Center(
         child: Column(
           children: [
             ElevatedButton(onPressed: () async{
               print("Clicked");
               final picker = ImagePicker();
               print(picker);
               openGalleryDirectory();

             }, child: Text("Go to Galary",style: TextStyle(fontSize: 12),)),

                 

           ],
         ),
       ),
     ),
   );
  }
}
