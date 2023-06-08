import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greate_places/models/place.dart';
import 'package:greate_places/providers/great_places.dart';
import 'package:greate_places/widgets/location_input.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import '../models/place.dart';
class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static const routeName='/add-place';
  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}



class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController=TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;



  void _selectImage(File pickedImage){
    _pickedImage=pickedImage;
  }
  void _selectPlace(double lat,double lng){
    _pickedLocation=PlaceLocation(latitude: lat, longitude: lng, address:'');
  }
  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage==null||_pickedLocation==null){
      return;
    }
    Provider.of<GreatPlaces>(context,listen: false).addPlace(_titleController.text,_pickedImage!,_pickedLocation!);
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Add a New Place'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
                child:Padding(padding: EdgeInsets.all(10),
                child: Column(
            children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                ),
              SizedBox(height: 10,),
              ImageInput(_selectImage),
              SizedBox(height: 10,),
              LocationInput(_selectPlace),

            ],
          ),),
              )),
          ElevatedButton.icon(
            icon: Icon(Icons.add,color: Colors.black,),
            label:Text('Add Place',style: TextStyle(color: Colors.black),),
            onPressed:_savePlace,
              style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
                primary: Theme.of(context).colorScheme.secondary,

              ),

          )
        ],
      ),
    );




  }
}
