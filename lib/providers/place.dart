import 'package:flutter/cupertino.dart';

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
}
