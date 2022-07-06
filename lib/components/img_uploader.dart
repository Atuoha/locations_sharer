import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/color.dart';
import '../providers/place.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

enum Source { camera, gallery }

class ImageUploader extends StatefulWidget {
  final Function(File) selectedImage;

  const ImageUploader({
    Key? key,
    required this.selectedImage,
  }) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  XFile? _storedImage;

  // Selecting Image Source
  Future<void> _selectSource(Source source) async {
    final XFile? pickedFile;
    switch (source) {
      case Source.camera:
        pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 600,
        );
        break;

      case Source.gallery:
        pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 600,
        );
        break;
    }

    if (pickedFile == null) {
      return;
    }

    setState(() {
      _storedImage = pickedFile;
    });
    var appDir = await syspaths.getApplicationDocumentsDirectory();
    var fileName = path.basename(pickedFile.path);
    File file = File(pickedFile.path);
    final savedImage = await file.copy('${appDir.path}/$fileName');
    widget.selectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    var placeData = Provider.of<PlaceData>(context);

    Future selectImageSource() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 3,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: placeData.lightMode ? primaryColor : accentColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
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
              onPressed: () {
                _selectSource(Source.gallery);
                Navigator.of(context).pop();
              },
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
              onPressed: () {
                _selectSource(Source.camera);
                Navigator.of(context).pop();
              },
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
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: placeData.lightMode ? primaryColor : accentColor,
              width: 2,
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
          onPressed: selectImageSource,
        )
      ],
    );
  }
}
