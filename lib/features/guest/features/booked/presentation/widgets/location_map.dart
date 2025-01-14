import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../config/color/color.dart';

class LocationMap extends StatelessWidget {
   LocationMap({
    super.key, required this.loc, required this.latitude, required this.longtiude,
  });

  final String loc;
  final String latitude;
  final String longtiude;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          height:
          MediaQuery.of(context).size.height / 2,
          child:
          ClipRRect(
            borderRadius:BorderRadius.circular(10) ,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(latitude), double.parse(longtiude)),
                zoom: 14.4746,
              ),
              onMapCreated:
                  (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: ColorConstant.secondBtnColor,
                child: Icon(
                  Icons.location_on_sharp,
                  size: 17,
                  color: Colors.white,
                ),
              ),
              Text(loc,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: ColorConstant.secondBtnColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
