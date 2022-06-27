import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_fit/constants/color.dart';
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
      appBar: AppBar(
        backgroundColor:  placeData.lightMode ? primaryColor : accentColor,
        leading: const Icon(
          Icons.pin_drop,
          color: Colors.white,
        ),
        title: const Text('Places'),
        actions: [
           GestureDetector(
            onTap: () {
              placeData.toggleMode();
            },
            child: Icon(
              placeData.lightMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child:  Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                Icons.add,
                color:  placeData.lightMode ? primaryColor : accentColor,
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
