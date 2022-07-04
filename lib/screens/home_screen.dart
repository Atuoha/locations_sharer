import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_fit/constants/color.dart';
import 'package:native_fit/screens/add_place.dart';
import 'package:native_fit/screens/favorite_places.dart';
import 'package:native_fit/screens/place_details.dart';
import 'package:provider/provider.dart';

import '../components/single_place.dart';
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
      extendBodyBehindAppBar: true,
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
        // backgroundColor: placeData.lightMode ? primaryColor : accentColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.pin_drop,
          color: placeData.lightMode ? primaryColor : accentColor,
        ),
        title: Text(
          'Location Sharer',
          style: TextStyle(
            color: placeData.lightMode ? primaryColor : accentColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                FavoriteScreen.routeName,
              ),
              child: Icon(
                Icons.favorite,
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
      backgroundColor: placeData.lightMode ? Colors.white : Colors.black38,
      body: Consumer<PlaceData>(
        builder: (context, data, child) => data.getPlaces().isEmpty
            ? Center(
                child: Column(
                  children: [
                    Image.asset(
                      placeData.lightMode
                          ? 'assets/images/c_light.png'
                          : 'assets/images/c_dark.png',
                    ),
                    Text(
                      'No Places Found! Try Adding one',
                      style: TextStyle(
                        color:
                            placeData.lightMode ? Colors.black54 : Colors.white,
                      ),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          placeData.lightMode
                              ? 'assets/images/a_light.png'
                              : 'assets/images/b_dark.png',
                        ),
                      ),
                    ),
                  ),
                  GridView.count(
                    padding: const EdgeInsets.all(20),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: data
                        .getPlaces()
                        .map(
                          (data) => GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                              PlaceDetails.routeName,
                              arguments: {
                                'id': data.id,
                              },
                            ),
                            child: SinglePlace(
                              id: data.id,
                              title: data.title,
                              imageAsset: data.image,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
      ),
    );
  }
}
