import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/guest_property_entity.dart';

import '../../../../../../config/color/color.dart';

class HouseGroupCard extends StatefulWidget {
  const HouseGroupCard({super.key, required this.width, this.height, required this.houseEntity, this.rating, required this.userAccountEntity});

  final double width;
  final double? height;
  final int? rating;
  final HouseEntity houseEntity;
  final UserAccountEntity userAccountEntity;
  @override
  State<HouseGroupCard> createState() => _HouseGroupCardState();
}

class _HouseGroupCardState extends State<HouseGroupCard> {
  int indexItem=0;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: widget.width,
      height: MediaQuery.of(context).size.height*0.6,
      margin: EdgeInsets.only(bottom:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
            Stack(
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
                  itemCount:   widget.houseEntity.houseImage!.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                       ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: widget.houseEntity.houseImage![itemIndex].image!,
                            placeholder: (context, url) => Icon(
                              Icons.photo,
                              color: Colors.black12,
                            ),
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
                      child: widget.houseEntity.houseImage!.length>=2?
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
                                      widget.houseEntity.houseImage!.length,
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
            )
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal:8), // Adjust padding
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Text(widget.houseEntity.title!,
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
                      "${widget.rating}/5.0",
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
                Text(widget.houseEntity.subDescription!.toString(),
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
                          text: " @${widget.userAccountEntity.firstName} ${widget.userAccountEntity.lastName??""}",
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
                              text: "${widget.houseEntity.price} ${widget.houseEntity.unit} ",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.secondBtnColor)),
                          TextSpan(
                              text: tr("/ ${tr("day")}"),
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
                        "${tr(widget.houseEntity.city!)}, ${widget.houseEntity.specificAddress!}",
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
