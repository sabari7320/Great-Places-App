import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/dp_helper.dart';
import '../helpers/location_helper.dart';
 class GreatPlaces with ChangeNotifier {
  List<place> _items = [];

  List<place> get items {
   return [..._items];
  }

  place findById(String id){
   return _items.firstWhere((place)=>place.id==id);
  }


  Future<void> addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) async{

   final address= await LocationHelper.getPlaceAddress(pickedLocation.latitude,pickedLocation.longitude);
   final updatedLocation=PlaceLocation(latitude:pickedLocation.latitude, longitude:pickedLocation.longitude,address: address);
   final newPlace = place(id: DateTime.now().toString(),
       image: pickedImage,
       title: pickedTitle,
       location: updatedLocation);
   _items.add(newPlace);
   notifyListeners();
   DBHelper.insert('places', {'id':newPlace.id,'title':newPlace.title,'image':newPlace.image,'loc_lat':newPlace.location.latitude,'loc_lng':newPlace.location.longitude,'address':newPlace.location.address});
  }
Future<void> fetchAndSetPlaces() async{
   final dataList=DBHelper.getData('user_places');
   _items=dataList.map((item)=>place(id: item['id'], title: item['title'], location:PlaceLocation(latitude: item['loc_lat'],longitude: item['loc_lng'],address: item['address']), image:File(item['image']))).toList();
}
 }