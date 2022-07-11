import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../constants/color.dart';
import '../providers/place.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PlaceDetails extends StatefulWidget {
  static const routeName = '/placedetails';
  const PlaceDetails({Key? key}) : super(key: key);

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  Widget build(BuildContext context) {
    var placeData = Provider.of<PlaceData>(context);
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var id = data['id'];
    var place = placeData.getPlaceById(id);
    Size size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SpeedDial(
        overlayOpacity:0.1,
        backgroundColor: placeData.lightMode ? primaryColor : accentColor,
        icon: Icons.chevron_right,
        activeIcon: Icons.chevron_left,
        children: [
          SpeedDialChild(
            labelBackgroundColor:  placeData.lightMode ? primaryColor : accentColor,
            labelStyle: const TextStyle(color: Colors.white),
            label: 'Edit Location',
            child: const Icon(
              Icons.edit,
            ),
          ),
          SpeedDialChild(
            labelBackgroundColor:  placeData.lightMode ? primaryColor : accentColor,
            labelStyle: const TextStyle(color: Colors.white),

            label: 'Delete Location',
            child: const Icon(
              Icons.delete_forever,
            ),
          ),
        ],
      ),

      
      backgroundColor: placeData.lightMode ? Colors.white : Colors.black54,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back,
              color: placeData.lightMode ? primaryColor : accentColor,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                placeData.toggleToFav(id);
              },
              child: Icon(
                placeData.checkFav(id) ? Icons.favorite : Icons.favorite_border,
                color: placeData.lightMode ? primaryColor : Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                placeData.toggleMode();
              },
              child: Icon(
                placeData.lightMode ? Icons.light_mode : Icons.dark_mode,
                color: placeData.lightMode ? primaryColor : Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
              ),
              image: DecorationImage(
                image: FileImage(place.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: placeData.lightMode ? Colors.black54 : Colors.white,
                    fontSize: 40,
                  ),
                ),
                Wrap(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 18,
                      color: placeData.lightMode ? primaryColor : Colors.white,
                    ),
                    Text(
                      'Nigeria',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color:
                            placeData.lightMode ? Colors.black54 : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.4,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  place.location!.latitude,
                  place.location!.latitude,
                ),
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: LatLng(
                    place.location!.latitude,
                    place.location!.latitude,
                  ),
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}
