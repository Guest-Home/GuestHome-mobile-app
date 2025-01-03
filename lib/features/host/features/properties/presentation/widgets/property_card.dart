import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';
import '../../../../../../config/color/color.dart';

class PropertyCard extends StatelessWidget {
   PropertyCard({
    super.key,
    required this.propertyEntity
  });

  PropertyEntity propertyEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: ColorConstant.cardGrey.withValues(alpha: 1.6),
      elevation: 0,
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child:CachedNetworkImage(
                      imageUrl:"https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg",
                      placeholder: (context, url) =>CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height:200,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                      left: 0,
                      right: 0,
                      child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(propertyEntity.houseImage.length,(index) => Container(width: 10,
                              height:10,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(color:ColorConstant.cardGrey,borderRadius: BorderRadius.circular(40)),),),))
                ],
              ),
              ListTile(
                title: Text(propertyEntity.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(propertyEntity.description),
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: ColorConstant.primaryColor,
                  ),
                  Text(
                    propertyEntity.specificAddress,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorConstant.inActiveColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                color: ColorConstant.inActiveColor.withValues(alpha: 0.2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 7,
                    children: [
                      Icon(
                        Icons.house_outlined,
                        color: ColorConstant.primaryColor,
                      ),
                      Text(
                        propertyEntity.numberOfRoom.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorConstant.primaryColor),
                      ),
                    ],
                  ),
                  RichText(
                      text: TextSpan(
                    text: 'Price: ',
                    children: [
                      TextSpan(
                        text: '${propertyEntity.unit} ${propertyEntity.price}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '/night',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorConstant.inActiveColor),
                      ),
                    ],
                  )),
                ],
              ),
            ],
        ),
      ),
    );
  }
}
