import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:native_fit/screens/map_screen.dart';
import 'package:provider/provider.dart';
import '../constants/color.dart';
import '../helpers/location_helper.dart';
import '../providers/place.dart';

class LocationUploader extends StatefulWidget {
  const LocationUploader({Key? key}) : super(key: key);

  @override
  State<LocationUploader> createState() => _LocationUploaderState();
}

class _LocationUploaderState extends State<LocationUploader> {
  String locationUrl = '';

  @override
  Widget build(BuildContext context) {
    var placeData = Provider.of<PlaceData>(context);

    Widget kElevatedButton(String label, IconData icon, Function() onPressed) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          primary: placeData.lightMode ? primaryColor : accentColor,
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    Future _getCurrentLocation() async {
      final location = await Location().getLocation();
      setState(() {
        locationUrl = LocationHelper.generatedStaticMapPreview(
          location.latitude,
          location.longitude,
        );
      });
      print(location.latitude);
      print(location.longitude);
    }

    Future<void> selectFromMap() async {
      final selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
          builder: (context) => const MapScreen(
            isSelecting: false,
          ),
        ),
      );

      if (selectedLocation == null) {
        return;
      }
      setState(() {
        locationUrl = LocationHelper.generatedStaticMapPreview(
          selectedLocation.latitude,
          selectedLocation.longitude,
        );
      });
      print(selectedLocation.latitude);
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: placeData.lightMode ? primaryColor : accentColor,
              width: 2,
            ),
          ),
          height: 200,
          child: locationUrl.isEmpty
              ? Center(
                  child: Image.asset(
                    'assets/images/map_place.png',
                    fit: BoxFit.cover,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    locationUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kElevatedButton(
              'Current Location',
              Icons.location_on,
              () => _getCurrentLocation(),
            ),
            const SizedBox(width: 5),
            kElevatedButton(
              'Select From Map',
              Icons.map,
              () => selectFromMap(),
            ),
          ],
        )
      ],
    );
  }
}
