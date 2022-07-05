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

  // fetching from sqlite
  Future<void> fetchAndSetData() async {
    final data = await DBHelper.fetchData('user_places');
    _places = data
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            isFavorite: place['isFavorite'],
            location: null,
            image: File(
              place['image'],
            ),
          ),
        )
        .toList();

    // adding items with isFavorite == 1 to _favoitePlaces
    _favoritePlaces = data.map((place) {
      if (place['isFavorite'] == 1) {
        Place(
          id: place['id'],
          title: place['title'],
          isFavorite: place['isFavorite'],
          location: null,
          image: File(
            place['image'],
          ),
        );
      }
    }).toList();
    notifyListeners();
  }

  List _favoritePlaces = [];

  List getFavPlaces() {
    return [..._favoritePlaces];
  }

  Place getPlaceById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  // SQLLITE VERSION
  void toggleToFav(String id) {
    var status = 0;
    switch (checkFav(id)) {
      case true:
        status = 0;
        break;
      case false:
        status = 1;
        break;
      default:
    }
    DBHelper.toggleFavorite(id, status);
    notifyListeners();

    print(status);
  }

  bool checkFav(String id) {
    var place = _places.firstWhere((place) => place.id == id);
    bool status = false;
    switch (place.isFavorite) {
      case 0:
        status = false;
        break;

      case 1:
        status = true;
        break;
      default:
    }
    return status;
  }

  void deletePlace(String id) {
    _places.removeWhere((place) => place.id == id);
    _favoritePlaces.removeWhere((place) => place.id == id);
    notifyListeners();

    // deletion from database
    DBHelper.delete('user_places', id);
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

    // insertion to database
    DBHelper.insert(
      'user_places',
      {
        'id': place.id,
        'title': place.title,
        'image': place.image.path,
      },
    );
  }
}
