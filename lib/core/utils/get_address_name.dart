

import 'package:geocoding/geocoding.dart';

class GetAddressName{

    Future<String?> getAddress(double lat,double long)async{
      List<Placemark> placemarks = await placemarkFromCoordinates(lat,long);
       if(placemarks.isNotEmpty){
         String address="${placemarks[0].name!},${placemarks[0].subLocality!},${placemarks[0].administrativeArea!},${placemarks[0].country!}";
         return address;
       }
       return "";
    }
}