import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_detail_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
    @override
  Widget build(BuildContext context) {
         return ChangeNotifierProvider(
           create: (BuildContext context)=>GreatPlaces() ,
           child: MaterialApp(
             title:'Great Places',
             theme: ThemeData(
               colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: Colors.amber),),
             home:PlacesListScreen(),
             routes: {
               AddPlaceScreen.routeName:(ctx)=>AddPlaceScreen(),
               PlaceDetailScreen.routeName:(ctx)=>PlaceDetailScreen(),
             },
           ),
         ) ;
  }
}

