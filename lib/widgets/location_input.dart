import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';
class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  void _showPreview(double lat,double lng){
    final staticMapImageUrl=LocationHelper.generateLocationPreviewImage(latitude:lat,longitude:lng);
    setState(() {
      _previewImageUrl=staticMapImageUrl;

    });
  }
  Future<void>_getCurrentUserLocation() async{
    try{
      final location = Location();
      final locdata = await location.getLocation();
      _showPreview(locdata.latitude!, locdata.longitude!);
      widget.onSelectPlace(locdata.latitude, locdata.longitude);
    }catch(error) {
      return;
    }
  }
Future<void>_selecteOnMap() async{

   final selectedLocation= await Navigator.of(context).push<LatLng>(MaterialPageRoute(
       fullscreenDialog: true,
       builder: (context)=>MapScreen(isSelecting: true,)),);

   if(selectedLocation==null){
     return;
   }
   _showPreview(selectedLocation.latitude,selectedLocation.longitude);
   widget.onSelectPlace(selectedLocation.latitude,selectedLocation.longitude);
}



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 170,width: double.infinity,alignment: Alignment.center,decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey)),
            child:_previewImageUrl==null ?Text('No Location Chosen',textAlign:TextAlign.center )
        : Image.network(_previewImageUrl!,fit: BoxFit.cover,width: double.infinity,)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon:Icon(Icons.location_on),
              label:Text('Current Location'),
              onPressed:_getCurrentUserLocation,
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(
                                                      Theme.of(context).primaryColor,),),),

            TextButton.icon(
              icon:Icon(Icons.map),
              label:Text('Select on Map'),
              onPressed:_selecteOnMap,
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor,),),),




          ],
        )
      ],
    );
  }
}
