import 'package:flutter/material.dart';
import 'package:native_fit/screens/favorite_places.dart';
import 'package:native_fit/screens/place_details.dart';
import '/screens/add_place.dart';
import '/providers/place.dart';
import 'package:provider/provider.dart';
import '/constants/color.dart';
import '/screens/home_screen.dart';
import 'screens/startup_screen.dart';

void main() {
  runApp(const LocationSharer());
}

class LocationSharer extends StatelessWidget {
  const LocationSharer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlaceData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Location Sharer',
        theme: ThemeData(
          primaryColor: accentColor,
          // primarySwatch: primaryColor
        ),
        home: const Startup(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          AddPlace.routeName: (context) => const AddPlace(),
          FavoriteScreen.routeName: (context) => const FavoriteScreen(),
          PlaceDetails.routeName: (context) => const PlaceDetails(),
        },
      ),
    );
  }
}
