import 'package:flutter/cupertino.dart';
import 'package:native_fit/helpers/db_helper.dart';
import 'package:native_fit/models/place_location.dart';
import 'dart:io';
import '../helpers/location_helper.dart';
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

  final List _favoritePlaces = [];

  List getFavPlaces() {
    return [..._favoritePlaces];
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
            location: PlaceLocation(
              latitude: place['lat'],
              longitude: place['lng'],
              address: place['address'],
            ),
            image: File(
              place['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  Place getPlaceById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  // SQLLITE VERSION
  void toggleToFav(String id) {
    var place = _places.firstWhere((place) => place.id == id);
    var status = place.isFavorite;
    switch (checkFav(id)) {
      case true:
        status = 0;
        _favoritePlaces.removeWhere((place) => place.id == id);
        break;
      case false:
        status = 1;
        _favoritePlaces.add(place);
        break;
      default:
    }
    DBHelper.toggleFavorite(id, status);
    notifyListeners();
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
    // print(status);
    return status;
  }

  void deletePlace(String id) {
    _places.removeWhere((place) => place.id == id);
    _favoritePlaces.removeWhere((place) => place.id == id);
    notifyListeners();

    // deletion from database
    DBHelper.delete('user_places', id);
  }

  Future<void> addPlace(
    String title,
    File image,
    PlaceLocation selectedLocation,
  ) async {
    final address = await LocationHelper.getAddress(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );

    final updatedAddress = PlaceLocation(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
      address: address,
    );

    var place = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updatedAddress,
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
        'lat': place.location!.latitude,
        'lng': place.location!.longitude,
        'address': place.location!.address,
      },
    );
  }
}
