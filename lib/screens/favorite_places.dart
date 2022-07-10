import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_fit/constants/color.dart';
import 'package:provider/provider.dart';
import '../components/single_place.dart';
import '../providers/place.dart';
import 'place_details.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorites';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<PlaceData>(context).getFavPlaces();
    }
    setState(() {
      isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    var placeData = Provider.of<PlaceData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: placeData.lightMode ? primaryColor : accentColor,
        title: const Text('Favorite Locations'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                placeData.toggleMode();
              },
              child: Icon(
                placeData.lightMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: placeData.lightMode ? Colors.white : Colors.black38,
      body: Consumer<PlaceData>(
        builder: (context, data, child) => data.getFavPlaces().isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    placeData.lightMode
                        ? 'assets/images/b_light.png'
                        : 'assets/images/b_dark.png',
                  ),
                  Text(
                    'No Favorite Place Found! Try Adding one',
                    style: TextStyle(
                      color:
                          placeData.lightMode ? Colors.black54 : Colors.white,
                    ),
                  )
                ],
              )
            : GridView.count(
                padding: const EdgeInsets.all(20),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: data
                    .getFavPlaces()
                    .map(
                      (data) => GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          PlaceDetails.routeName,
                          arguments: {
                            'id': data.id,
                          },
                        ),
                        child: SinglePlace(
                          id: data.id,
                          title: data.title,
                          imageAsset: data.image,
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
