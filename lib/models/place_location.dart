class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = '',
  });
}
