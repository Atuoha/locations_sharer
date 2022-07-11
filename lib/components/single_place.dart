import 'dart:io';
import 'package:flutter/material.dart';
import 'package:native_fit/models/place_location.dart';
import 'package:provider/provider.dart';
import '../constants/color.dart';
import '../providers/place.dart';

class SinglePlace extends StatelessWidget {
  final String id;
  final File imageAsset;
  final String title;
  final PlaceLocation location;
  const SinglePlace({
    Key? key,
    required this.id,
    required this.imageAsset,
    required this.title,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var placeData = Provider.of<PlaceData>(
      context,
      listen: false,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: placeData.lightMode ? Colors.white : Colors.black54,
        border: Border.all(
          width: 2,
          color: placeData.lightMode ? primaryColor : accentColor,
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              imageAsset,
              fit: BoxFit.cover,
              height: 90,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
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
          Positioned(
            bottom: 7,
            left: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: placeData.lightMode ? Colors.black54 : Colors.white,
                  ),
                ),
                Wrap(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 15,
                      color: placeData.lightMode ? primaryColor : Colors.white,
                    ),
                    Text(
                      'Nigeria',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            placeData.lightMode ? Colors.black54 : Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 6,
            right: 10,
            child: GestureDetector(
              onTap: () {
                placeData.deletePlace(id);
              },
              child: Icon(
                Icons.delete_forever,
                color: placeData.lightMode ? primaryColor : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
