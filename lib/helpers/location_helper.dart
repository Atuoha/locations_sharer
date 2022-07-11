import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const googleAPI = '';

class LocationHelper {
  static String generatedStaticMapPreview(
      double? latitiude, double? longitiude) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitiude,$longitiude&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%$latitiude,$longitiude&key=$googleAPI';
  }

  static Future<String> getAddress(double lat, double lng) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleAPI";
    final response = await http.get(Uri.parse(url));
    final result = json.decode(
      response.body,
    )['formatted_address'];

    if (kDebugMode) {
      print(result);
    }
    return result;
  }
}
