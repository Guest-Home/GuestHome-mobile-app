import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';
import '../../../../../../config/color/color.dart';

class PropertyCard extends StatefulWidget {
  const PropertyCard({super.key, required this.propertyEntity});

  final PropertyEntity propertyEntity;

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: ColorConstant.cardGrey.withValues(alpha: 1.6),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 5,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.25,
                  child: CarouselView(
                      elevation: 0,
                      padding: EdgeInsets.all(0),
                      reverse: true,
                      backgroundColor: ColorConstant.cardGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemExtent: MediaQuery.of(context).size.width,
                      children: List.generate(
                        widget.propertyEntity.houseImage.length,
                        (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: CachedNetworkImage(
                            imageUrl:
                                widget.propertyEntity.houseImage[index].image,
                            placeholder: (context, url) => Icon(
                              Icons.photo,
                              color: ColorConstant.inActiveColor,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height*0.25,
                          ),
                        ),
                      )),
                ),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.propertyEntity.houseImage.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color:
                                  ColorConstant.cardGrey.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      ),
                    ))
              ],
            ),
            ListTile(
              title: Text(
                widget.propertyEntity.typeofHouse,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 19),
              ),
              subtitle: Text(
                widget.propertyEntity.description,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.inActiveColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: ColorConstant.primaryColor.withValues(alpha: 0.8),
                  ),
                  Text(
                    widget.propertyEntity.specificAddress,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorConstant.secondBtnColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: ColorConstant.cardGrey.withValues(alpha: 0.9),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 7,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color:
                            ColorConstant.primaryColor.withValues(alpha: 0.8),
                      ),
                      Text(
                        widget.propertyEntity.numberOfRoom.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorConstant.secondBtnColor,fontSize: 14),
                      ),
                    ],
                  ),
                  RichText(
                      text: TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                        text: '${widget.propertyEntity.price}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorConstant.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: ' /night',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.inActiveColor),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
