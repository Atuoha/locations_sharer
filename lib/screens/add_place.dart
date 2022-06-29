import 'package:flutter/services.dart';
import 'package:native_fit/components/img_uploader.dart';
import 'package:native_fit/constants/color.dart';
import 'package:provider/provider.dart';
import '../providers/place.dart';
import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  String title = '';

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
        onPressed: () {},
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: placeData.lightMode ? primaryColor : accentColor,
        title: const Text('Add A Place'),
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
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Title';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: InputDecoration(
                icon: Icon(
                  Icons.title,
                  color: placeData.lightMode ? Colors.black38 : Colors.white,
                ),
                hintText: 'Enter Title',
                hintStyle: TextStyle(
                  color: placeData.lightMode ? Colors.black38 : Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: placeData.lightMode ? primaryColor : accentColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: placeData.lightMode ? primaryColor : accentColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ImageUploader()
          ],
        ),
      ),
    );
  }
}
