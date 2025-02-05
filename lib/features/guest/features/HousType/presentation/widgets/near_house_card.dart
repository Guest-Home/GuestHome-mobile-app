
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/guest_property_entity.dart';
import '../../../../../../config/color/color.dart';

class NearHouseCard extends StatefulWidget {
  const NearHouseCard({
    super.key,
    required this.width,
    required this.height,
    required this.property,
  });

  final double width;
  final double? height;

  final ResultEntity property;

  @override
  State<NearHouseCard> createState() => _NearHouseCardState();
}

class _NearHouseCardState extends State<NearHouseCard> {
  int indexItem=0;
  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: widget.width,
      height: MediaQuery.of(context).size.height*0.6,
      margin: EdgeInsets.only(bottom:10),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: widget.property.tumbleImage??"",
                  placeholder: (context, url) =>
                      RepaintBoundary(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.image),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.6,
                ),

              ),

          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Text(widget.property.houses![0].title!,
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
                      "${widget.property.rating}/5.0",
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
                Text(widget.property.houses![0].subDescription!.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style:Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorConstant.secondBtnColor
                                  .withValues(alpha: 0.4)
                          )),
                      TextSpan(
                          text: " @${widget.property.userAccount!.firstName} ${widget.property.userAccount!.lastName??""}",
                          style:Theme.of(context).textTheme.bodySmall!.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color:ColorConstant.secondBtnColor
    )
                         )
                    ])),

                // RichText(
                //     text: TextSpan(children: [
                //       TextSpan(
                //           text: "${widget.property.price} ${widget.property.unit} ",
                //           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w700,
                //               color: ColorConstant.secondBtnColor)),
                //       TextSpan(
                //           text: tr("/ day"),
                //           style: TextStyle(
                //               color: ColorConstant.secondBtnColor
                //                   .withValues(alpha: 0.7))),
                //     ])),
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
                        "${widget.property.houses![0].city!}, ${widget.property.houses![0].specificAddress!}",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorConstant.secondBtnColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: Text("See details",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                 color: ColorConstant.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14
              ),),
            ),

        ],
      ),

    );
  }
}
