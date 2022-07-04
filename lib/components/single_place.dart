import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color.dart';
import '../providers/place.dart';

class SinglePlace extends StatelessWidget {
  final String id;
  final File imageAsset;
  final String title;
  const SinglePlace({
    Key? key,
    required this.id,
    required this.imageAsset,
    required this.title,
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
          color: primaryColor,
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              imageAsset,
              fit: BoxFit.cover,
              height: 120,
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
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: placeData.lightMode ? Colors.black54 : Colors.white,
              ),
            ),
          ),
              Positioned(
            bottom: 6,
            right: 10,
            child: GestureDetector(
              onTap: () {
                placeData.deletePlace(id);
              },
              child: const Icon(
              Icons.delete_forever,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
