import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../constants/color.dart';
import '../models/place_location.dart';
import '../providers/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initLocation;
  const MapScreen({
    Key? key,
    this.initLocation = const PlaceLocation(
      latitude: 5.4412096,
      longitude: 7.0325381,
    ),
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pickedLocation;
  void selectLocation(LatLng location) {
    setState(() {
      pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    var placeData = Provider.of<PlaceData>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
              backgroundColor: placeData.lightMode ? primaryColor : accentColor,
              onPressed: pickedLocation == null
                  ? null
                  : () => Navigator.of(
                        context,
                      ).pop(
                        pickedLocation,
                      ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            )
         ,
      extendBodyBehindAppBar: true,
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initLocation.latitude,
            widget.initLocation.latitude,
          ),
          zoom: 16,
        ),
        // ignore: unnecessary_null_comparison
        markers: pickedLocation == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: pickedLocation!,
                )
              },
        onTap: selectLocation ,
      ),
    );
  }
}
