import 'package:flutter/services.dart';
import 'package:native_fit/components/img_uploader.dart';
import 'package:native_fit/constants/color.dart';
import 'package:native_fit/models/place_location.dart';
import 'package:provider/provider.dart';
import '../components/location_uploader.dart';
import '../providers/place.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  var textController = TextEditingController();
  File imageFile = File('');
  PlaceLocation? selectedLocation;

  void selectedImage(File pickedFile) {
    setState(() {
      imageFile = pickedFile;
    });
  }

  void selectLocation(double lat, double lng) {
    selectedLocation = PlaceLocation(
      latitude: lat,
      longitude: lng,
    );
  }

  void submitDetails() {
    // ignore: unnecessary_null_comparison
    if (textController.text.isEmpty || imageFile == null || selectedLocation == null) {
      return;
    } else {
      // Adding Place to List
      Provider.of<PlaceData>(
        context,
        listen: false,
      ).addPlace(
        textController.text,
        imageFile,
        selectedLocation!
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    var placeData = Provider.of<PlaceData>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: placeData.lightMode ? primaryColor : accentColor,
        onPressed: submitDetails,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: placeData.lightMode ? primaryColor : accentColor,
        title: const Text('Add A Location'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                placeData.toggleMode();
              },
              child: Icon(
                placeData.lightMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: placeData.lightMode ? Colors.white : Colors.black38,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: textController,
                style: TextStyle(
                  color: placeData.lightMode ? Colors.black38 : Colors.white,
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.title,
                    color: placeData.lightMode ? Colors.black38 : Colors.white,
                  ),
                  hintText: 'Enter Location Title',
                  hintStyle: TextStyle(
                    color: placeData.lightMode ? Colors.black38 : Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: placeData.lightMode ? primaryColor : accentColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: placeData.lightMode ? primaryColor : accentColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              LocationUploader(selectLocation: selectLocation),
              const SizedBox(height: 10),
              ImageUploader(selectedImage: selectedImage),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
