
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';

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
    return Container(
      width: widget.width,
      height: MediaQuery.of(context).size.height*0.6,
      margin: EdgeInsets.only(bottom:10),
      child:
      Column(
        children: [
          Expanded(
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    options:CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.6,
                      aspectRatio: 16/9,
                      viewportFraction:1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged:(index, reason) {
                        setState(() {
                          indexItem=index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                    itemCount:   widget.property.houseImage!.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                         ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: widget.property.houseImage![itemIndex].image!,
                              placeholder: (context, url) =>
                                  RepaintBoundary(child: CupertinoActivityIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.6,
                            ),
                          
                        ),
                  ),

                    Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: widget.property.houseImage!.length>=2?
                        Row(
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
                                        widget.property.houseImage!.length,
                                            (index) => Container(
                                          width: 7,
                                          height: 7,
                                          margin: EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:index==indexItem?
                                              Colors.white:ColorConstant.cardGrey.withValues(alpha: 0.4)),
                                        )),
                                  ))
                            ]):SizedBox())
                ],
              )),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Text(widget.property.title!,
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
                      "${widget.property.postedBy!.rating}/5.0",
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
                Text(widget.property.subDescription!.toString(),
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
                          text: " @${widget.property.postedBy!.userAccount!.firstName} ${widget.property.postedBy!.userAccount!.lastName}",
                          style:Theme.of(context).textTheme.bodySmall!.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color:ColorConstant.secondBtnColor
    )
                         )
                    ])),
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "${widget.property.price} ${widget.property.unit} ",
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
                        "${widget.property.city!}, ${widget.property.specificAddress!}",
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
        ],
      ),

    );
  }
}
