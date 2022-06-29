import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/color.dart';
import '../providers/place.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({Key? key}) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  XFile? _storedImage;

  Future<void> _selectCamera() async {
    // ignore: unused_local_variable
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = pickedFile;
    });
  }

  Future<void> _selectGallary() async {
    // ignore: unused_local_variable
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    var placeData = Provider.of<PlaceData>(context);

    Future showCamera() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 3,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: placeData.lightMode ? primaryColor : accentColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30)),
          backgroundColor: placeData.lightMode ? Colors.white : Colors.black38,
          title: Center(
            child: Text(
              'Choose an option',
              style: TextStyle(
                color: placeData.lightMode ? Colors.black38 : Colors.white,
              ),
            ),
          ),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: placeData.lightMode ? primaryColor : accentColor,
              ),
              label: const Text(
                'Choose from gallary',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: _selectGallary,
              icon: const Icon(
                Icons.image,
                color: Colors.white,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: placeData.lightMode ? primaryColor : accentColor,
              ),
              label: const Text(
                'Choose from camera',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: _selectCamera,
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: placeData.lightMode ? primaryColor : accentColor,
              width: 1,
            ),
          ),
          // ignore: unnecessary_null_comparison
          child: _storedImage != null
              ? Image.file(
                  File(_storedImage!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/img_place.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          label: const Text(
            'Upload a Photo',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            primary: placeData.lightMode ? primaryColor : accentColor,
          ),
          icon: const Icon(
            Icons.camera,
            size: 40,
            color: Colors.white,
          ),
          onPressed: showCamera,
        )
      ],
    );
  }
}
