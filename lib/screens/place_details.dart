import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants/color.dart';
import '../providers/place.dart';

class PlaceDetails extends StatefulWidget {
  static const routeName = '/placedetails';
  const PlaceDetails({Key? key}) : super(key: key);

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  Widget build(BuildContext context) {
    var placeData = Provider.of<PlaceData>(context);
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var id = data['id'];
    var place = placeData.getPlaceById(id);
    Size size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      backgroundColor: placeData.lightMode ? Colors.white : Colors.black54,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back,
              color: placeData.lightMode ? primaryColor : accentColor,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                placeData.toggleToFav(id);
              },
              child: Icon(
                placeData.checkFav(id) ? Icons.favorite : Icons.favorite_border,
                color: placeData.lightMode ? primaryColor : accentColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                placeData.toggleMode();
              },
              child: Icon(
                placeData.lightMode ? Icons.light_mode : Icons.dark_mode,
                color: placeData.lightMode ? primaryColor : accentColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
              ),
              image: DecorationImage(
                image: FileImage(place.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                place.title,
                style: TextStyle(
                  color: placeData.lightMode ? Colors.black54 : Colors.white,
                  fontSize: 28,
                ),
              ))
        ],
      ),
    );
  }
}
