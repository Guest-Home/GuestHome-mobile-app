import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
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
  int photoIndex=0;
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
                  child:  CarouselSlider.builder(
                    options:CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.36,
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
                          photoIndex=index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                    itemCount: widget.propertyEntity.houseImage.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: widget.propertyEntity.houseImage[itemIndex].image,
                            placeholder: (context, url) =>
                                RepaintBoundary(child: CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height*0.25,
                          ),
                        ),

                  ),

                ),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child:widget.propertyEntity.houseImage.length>=2? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 18,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:
                                Colors.black.withValues(alpha: 0.4),
                              ),
                              child: Row(
                                children: List.generate(
                                    widget.propertyEntity.houseImage.length,
                                        (index) => AnimatedContainer(
                                      duration:Duration(milliseconds: 800),
                                      width: 7,
                                      height: 7,
                                      margin:
                                      EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: index == photoIndex
                                              ? Colors.white
                                              : ColorConstant.cardGrey
                                              .withValues(
                                              alpha: 0.4)),
                                    )),
                              ))
                        ]):SizedBox())
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
