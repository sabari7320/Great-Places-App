import 'dart:io';
import 'package:flutter/foundation.dart';



class PlaceLocation{
  final double latitude;
  final double longitude;
  final String address;
 const PlaceLocation({
    required this.latitude,required this.longitude,required this.address
});
}




class place{
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  place({ required this.id,required this.title,required this.location,required this.image});
}
