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
  final File _storedImage = File('');

  Future<void> _selectCamera() async {
    // ignore: unused_local_variable
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
  }

  Future<void> _selectGallary() async {
    // ignore: unused_local_variable
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
  }

  @override
  Widget build(BuildContext context) {
    var placeData = Provider.of<PlaceData>(context);

    Future showCamera() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
              label: Text(
                'Choose from gallary',
                style: TextStyle(
                  color: placeData.lightMode ? Colors.white : Colors.black38,
                ),
              ),
              onPressed: _selectGallary,
              icon: Icon(
                Icons.image,
                color: placeData.lightMode ? Colors.white : Colors.black38,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: placeData.lightMode ? primaryColor : accentColor,
              ),
              label: Text(
                'Choose from camera',
                style: TextStyle(
                  color: placeData.lightMode ? Colors.white : Colors.black38,
                ),
              ),
              onPressed: _selectCamera,
              icon: Icon(
                Icons.camera_alt,
                color: placeData.lightMode ? Colors.white : Colors.black38,
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
          child: _storedImage.isAbsolute
              ? Image.file(
                  _storedImage,
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
        const SizedBox(height: 20),
        ElevatedButton.icon(
          label: Text(
            'Take a photo',
            style: TextStyle(
              color: placeData.lightMode ? Colors.white : Colors.black38,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: placeData.lightMode ? primaryColor : accentColor,
          ),
          icon: Icon(
            Icons.camera_alt,
            size: 40,
            color: placeData.lightMode ? Colors.white : Colors.black38,
          ),
          onPressed: showCamera,
        )
      ],
    );
  }
}
