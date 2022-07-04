import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_fit/constants/color.dart';
import 'package:provider/provider.dart';
import '../providers/place.dart';
import 'home_screen.dart';

class Startup extends StatelessWidget {
  static const routeName = '/startup';
  const Startup({Key? key}) : super(key: key);

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                placeData.toggleMode();
              },
              child: Icon(
                placeData.lightMode ? Icons.light_mode : Icons.dark_mode,
                color: placeData.lightMode ? primaryColor : Colors.white38,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: placeData.lightMode ? Colors.white : Colors.black38,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            placeData.lightMode
                ? 'assets/images/bg_light.png'
                : 'assets/images/bg_dark.png',
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: placeData.lightMode ? primaryColor : accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            icon: const Icon(
              Icons.pin_drop,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
              HomeScreen.routeName,
            ),
            label: const Text(
              'Start Sharing',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
