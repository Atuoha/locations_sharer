import 'dart:io';
import 'package:flutter/foundation.dart';
import 'place_location.dart';

class Place with ChangeNotifier {
  final String id;
  final String title;
  final File image;
  final PlaceLocation? location;
  int isFavorite;

  Place({
    required this.id,
    required this.image,
    required this.location,
    required this.title,
    this.isFavorite = 0,
  });

  // toggleFav() {
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  // }
}
