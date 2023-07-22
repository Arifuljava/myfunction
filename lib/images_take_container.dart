import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagesTakeContainer extends StatefulWidget {
  const ImagesTakeContainer({super.key});

  @override
  ImagesTakeContainerState createState() => ImagesTakeContainerState();
}

late ImagePicker imagePicker;

class ImagesTakeContainerState extends State<ImagesTakeContainer> {

  XFile? _imageFile;

  double imageContainerWidth = 100.0;
  double imageContainerHeight = 100.0;

  // Minimum height & width for the barcode
  double minImageContainerWidth = 50.0;
  double minImageContainerHeight = 50.0;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  Future<void> selectImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      cropImage(File(pickedFile.path));
    }
  }

  Future<void> takePicture() async {
    print('Dolon++++++++++1');
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      cropImage(File(pickedFile.path));
    }
  }

  Future<void> cropImage(File imageFile) async {
    final imageCropper = ImageCropper(); // Create an instance of ImageCropper
    final croppedFile = await imageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        // Allow user to set custom aspect ratio
        showCropGrid: true, // Show grid in the crop overlay
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop Image',
      ),
    );

    if (croppedFile != null) {
      setState(() {
        _imageFile = XFile(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_imageFile != null)
          Container(
            margin: const EdgeInsets.all(5),
            height: imageContainerHeight,
            width: imageContainerWidth,
            child: Image.file(
              File(_imageFile!.path),
              fit: BoxFit.cover,
            ),
          ),
        Positioned(
          right: -32,
          bottom: -35,
          child: GestureDetector(
            onPanUpdate: _handleResizeGesture,
            child: const SizedBox(
              width: 64,
              height: 64,
              child: Icon(
                Icons.touch_app,
                color: Colors.grey,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleResizeGesture(DragUpdateDetails details) {
    setState(() {
      final newWidth = imageContainerWidth + details.delta.dx;
      final newHeight = imageContainerHeight + details.delta.dy;
      imageContainerWidth = newWidth >= minImageContainerWidth
          ? newWidth
          : minImageContainerWidth;
      imageContainerHeight = newHeight >= minImageContainerHeight
          ? newHeight
          : minImageContainerHeight;
    });
  }
}