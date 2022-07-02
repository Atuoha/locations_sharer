import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/place.dart';

class SinglePlace extends StatelessWidget {
  final String id;
  final String imageAsset;
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
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imageAsset),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Icon(
              placeData.checkFav(id) ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              color: Colors.white,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color:Colors.black
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
