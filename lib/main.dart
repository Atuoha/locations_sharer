import 'package:flutter/material.dart';
import '/providers/place.dart';
import 'package:provider/provider.dart';
import '/constants/color.dart';
import '/screens/home_screen.dart';

void main() {
  runApp(const LocationSharer());
}

class LocationSharer extends StatelessWidget {
  const LocationSharer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context)=> PlaceData(),
      child: MaterialApp(    
        debugShowCheckedModeBanner: false,
        title: 'Location Sharer',
        theme: ThemeData(
          primaryColor: accentColor,
        ),
        home: const HomeScreen(),
        routes: {
          
        },
      ),
    );
  }
}
