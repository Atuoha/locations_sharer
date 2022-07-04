import 'package:flutter/cupertino.dart';
import 'package:native_fit/helpers/db_helper.dart';
import 'dart:io';

import '../models/place.dart';

class PlaceData extends ChangeNotifier {
  var lightMode = true;
  void toggleMode() {
    lightMode = !lightMode;
    notifyListeners();
  }

  List _places = [];

  List getPlaces() {
    return [..._places];
  }

  // fetching sqlite
  Future<void> fetchPlacesFromDB() async {
    final data = await DBHelper.fetch('locations');
    _places = data
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: null,
            image: File(
              item['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  final List _favoritePlaces = [];

  List getFavPlaces() {
    return [..._favoritePlaces];
  }

  Place getPlaceById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  void toggleToFav(String id) {
    var place = _places.firstWhere((place) => place.id == id);
    switch (checkFav(id)) {
      case true:
        _favoritePlaces.remove(place);
        break;

      case false:
        _favoritePlaces.add(place);
        break;
    }
    notifyListeners();
  }

  bool checkFav(String id) {
    return _favoritePlaces.any((place) => place.id == id);
  }

  void deletePlace(String id) {
    _places.removeWhere((place) => place.id == id);
    _favoritePlaces.removeWhere((place) => place.id == id);
    notifyListeners();
  }

  void addPlace(String title, File image) {
    var place = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: null,
    );
    _places.add(place);
    notifyListeners();
    DBHelper.insert('places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
    });
  }
}
