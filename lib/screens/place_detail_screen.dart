import 'package:flutter/material.dart';
import 'package:greate_places/screens/map_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';


class PlaceDetailScreen extends StatelessWidget {
  static const routeName='/place-detail';
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id=ModalRoute.of(context)?.settings.arguments;
    final selectedPlace=Provider.of<GreatPlaces>(context,listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.title),),

      body: Column(
        children: [
          Container(
            height: 250,width: double.infinity,child: Image.file(selectedPlace.image,fit: BoxFit.cover,width: double.infinity,),
          ),
          SizedBox(height: 10,),
          Text(selectedPlace.location.address,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.grey),),
          SizedBox(height:10),
          TextButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(fullscreenDialog: true,
                builder: (ctx)=>MapScreen(
              initiallocation: selectedPlace.location,isSelecting: false,)));
          }, child: Text('View on Map'), style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).primaryColor,),),),

        ],
      ),
    );
  }
}
