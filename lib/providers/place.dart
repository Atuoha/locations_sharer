import 'package:flutter/cupertino.dart';
import 'dart:io';

import '../models/place.dart';

class PlaceData extends ChangeNotifier {
  var lightMode = true;
  void toggleMode() {
    lightMode = !lightMode;
    notifyListeners();
  }

  final List _places = [];

  List getPlaces() {
    return [..._places];
  }

  List favoritePlaces = [];

  void toggleToFav(String id) {
    var place = _places.firstWhere((place) => place.id == id);
    switch (checkFav(id)) {
      case true:
        favoritePlaces.remove(place);
        break;

      case false:
        favoritePlaces.add(place);
        break;
    }
    notifyListeners();
  }

  bool checkFav(String id) {
    return favoritePlaces.any((place) => place.id == id);
  }

  void addPlace(String title, File image) {
    var place = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: null,
    );
    _places.add(place);
    print(_places);
    notifyListeners();
  }
}
