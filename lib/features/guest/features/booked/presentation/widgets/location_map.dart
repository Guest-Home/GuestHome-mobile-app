
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../config/color/color.dart';

class LocationMap extends StatelessWidget {
   const LocationMap({
    super.key, required this.loc, required this.latitude, required this.longtiude,
  });

  final String loc;
  final String latitude;
  final String longtiude;


  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Stack(
          children:[
            Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            height:
            MediaQuery.of(context).size.height *0.4,
            child:
            ClipRRect(
              borderRadius:BorderRadius.circular(10) ,
              child:
              RepaintBoundary(
                child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(10),
                    child: FlutterMap(
                        mapController: MapController(),
                        options: MapOptions(
                            initialZoom: 15,
                            backgroundColor: ColorConstant.cardGrey.withValues(alpha: 0.6),
                            initialCenter:LatLng(double.parse(latitude),double.parse(longtiude))),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                            // Plenty of other options available!
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(double.parse(latitude), double.parse(longtiude)),
                                width: 50,
                                height: 50,
                                child:  SvgPicture.asset(
                                  'assets/icons/marker.svg',
                                  semanticsLabel:"marker",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),

                        ])),
              )
            ),
          ),

            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: ()async{
                  await launchUrl(Uri.parse(
                      'google.navigation:q=$latitude,$longtiude'));

                },
                child: CircleAvatar(
                  radius: 26,
                  child: Icon(Icons.directions),
                ),
              ),
            )
             ]
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
