import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_fit/constants/color.dart';
import 'package:native_fit/screens/add_place.dart';
import 'package:provider/provider.dart';

import '../providers/place.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
        onPressed: () {
          Navigator.of(context).pushNamed(AddPlace.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: placeData.lightMode ? primaryColor : accentColor,
        leading: const Icon(
          Icons.pin_drop,
          color: Colors.white,
        ),
        title: const Text('Favorite Places'),
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
      body: Column(
        children: const [
          Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
