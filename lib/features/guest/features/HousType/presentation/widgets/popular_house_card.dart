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
      margin: EdgeInsets.only(bottom: 5),
      child:
        Column(
          children: [
            Expanded(
                child:
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
                          height:300,
                        ),
                      ),
                    )),
              ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 10,
                children: [
                  Expanded(
                    child: Text(property.title!,
                      textAlign:TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600,fontSize: 14),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 2,
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: ColorConstant.yellow,
                      ),
                      Text(
                        "${property.postedBy!.rating}/5.0",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w700,fontSize: 12),
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
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstant.secondBtnColor))
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
                      Expanded(
                        child: Text(
                          "${property.specificAddress!}, ${property.city!}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: ColorConstant.secondBtnColor),
                        ),
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
