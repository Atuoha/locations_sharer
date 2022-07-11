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
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    var placeData = Provider.of<PlaceData>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // extendBodyBehindAppBar: true,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.pin_drop,
          color: placeData.lightMode ? primaryColor : Colors.white,
        ),
        title: Text(
          'Location Sharer',
          style: TextStyle(
              color: placeData.lightMode ? primaryColor : Colors.white,
              fontWeight: FontWeight.bold),
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
                color: placeData.lightMode ? primaryColor : Colors.white,
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
                color: placeData.lightMode ? primaryColor : Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: placeData.lightMode ? Colors.white : Colors.black38,
      body: Column(
        children: [
          Container(
            height: size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  placeData.lightMode
                      ? 'assets/images/a_light.png'
                      : 'assets/images/a_dark.png',
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: placeData.fetchAndSetData(),
                builder: (context, snapshot) => Consumer<PlaceData>(
                      builder: (context, data, child) =>
                          data.getPlaces().isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        placeData.lightMode
                                            ? 'assets/images/c_light.png'
                                            : 'assets/images/c_dark.png',
                                        width: 150),
                                    Text(
                                      'No Place Found! Try Adding one',
                                      style: TextStyle(
                                        color: placeData.lightMode
                                            ? Colors.black54
                                            : Colors.white,
                                      ),
                                    )
                                  ],
                                )
                              : GridView.count(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  children: data
                                      .getPlaces()
                                      .map(
                                        (data) => GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pushNamed(
                                            PlaceDetails.routeName,
                                            arguments: {
                                              'id': data.id,
                                            },
                                          ),
                                          child: SinglePlace(
                                            id: data.id,
                                            title: data.title,
                                            location: data.location,
                                            imageAsset: data.image,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                    )
                // : Center(
                //     child: CircularProgressIndicator(
                //       color: placeData.lightMode ? primaryColor : accentColor,
                //     ),
                //   ),
                ),
          ),
        ],
      ),
    );
  }
}
