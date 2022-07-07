const googleAPI = '';

class LocationHelper {
  static String generatedStaticMapPreview(double? latitiude, double? longitiude) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitiude,$longitiude&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%$latitiude,$longitiude&key=$googleAPI';
  }
}
