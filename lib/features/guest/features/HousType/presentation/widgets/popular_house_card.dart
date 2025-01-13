import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';

import '../../../../../../config/color/color.dart';

class PopularHouseCard extends StatelessWidget {
  const PopularHouseCard({
    super.key,
    required this.width,
    required this.height,
    required this.property,
    required this.showBorder,
    required this.showIndicator
  });

  final double width;
  final double? height;
  final bool showBorder;
  final bool showIndicator;
  final ResultEntity property;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: MediaQuery.of(context).size.height*0.6,
      margin: EdgeInsets.only(bottom: 20),
      child:
        Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                CarouselView(
                    elevation: 0,
                    padding: EdgeInsets.all(0),
                    reverse: false,
                    backgroundColor: ColorConstant.cardGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius:showBorder? BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)):BorderRadius.circular(10)),
                    itemExtent: MediaQuery.of(context).size.width,
                    children: List.generate(
                     property.houseImage!.length,
                          (index) => ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl:
                         property.houseImage![index].image!,
                          placeholder: (context, url) => Icon(
                            Icons.photo,
                            color: ColorConstant.inActiveColor,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.6,
                        ),
                      ),
                    )),
                if(showIndicator)
                Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 25,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black.withValues(alpha: 0.4),
                              ),
                              child: Row(
                                children: List.generate(
                                    property.houseImage!.length,
                                    (index) => Container(
                                          width: 7,
                                          height: 7,
                                          margin: EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        )),
                              ))
                        ]))
              ],
            )),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 10,
                children: [
                  Text(property.title!,
                    textAlign:TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600,fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 2,
                    children: [
                      Icon(
                        Icons.star,
                        size: 20,
                        color: ColorConstant.yellow,
                      ),
                      Text(
                        "${property.postedBy!.rating}/5.0",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w700,fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Text(property.subDescription!.toString(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style:Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12,
                   fontWeight: FontWeight.w400,
    color: ColorConstant.secondBtnColor
        .withValues(alpha: 0.4)
    )
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:tr("posted by"),
                           style:Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: ColorConstant.secondBtnColor
                          .withValues(alpha: 0.4)
                  )),
                    TextSpan(
                        text: " @${property.postedBy!.userAccount!.firstName} ${property.postedBy!.userAccount!.lastName}",
                        style: TextStyle(
                            color: ColorConstant.secondBtnColor
                                .withValues(alpha: 1)))
                  ])),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "${property.price} ${property.unit} ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.secondBtnColor)),
                    TextSpan(
                        text: tr("/ day"),
                        style: TextStyle(
                            color: ColorConstant.secondBtnColor
                                .withValues(alpha: 0.7))),
                  ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 20,
                        color: ColorConstant.secondBtnColor,
                      ),
                      Text(
                        "${property.specificAddress!}, ${property.city!}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: ColorConstant.secondBtnColor),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),

    );
  }
}
