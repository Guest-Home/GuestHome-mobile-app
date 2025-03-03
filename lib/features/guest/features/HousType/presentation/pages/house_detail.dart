import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/constants/house_type_icons.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/guest_property_entity.dart';

import '../../../../../../core/apiConstants/api_url.dart';

class HouseDetail extends StatefulWidget {
  const HouseDetail({super.key, required this.property, required this.token, required this.userAccountEntity, required this.profilePicture});
  final HouseEntity property;
  final UserAccountEntity userAccountEntity;
  final String token;
  final String profilePicture;

  @override
  State<HouseDetail> createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> {
  int photoIndex = 0;
  @override
  Widget build(BuildContext context) {
    final filteredAmenities = widget.property.subDescription!
        .split(',')
        .where((item) => item.trim().isNotEmpty)
        .toList();
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: Column(
        spacing: 15,
        children: [
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.36,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.96,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: true,
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {
                            setState(() {
                              photoIndex = index;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                        itemCount: widget.property.houseImage!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            GestureDetector(
                          onTap: () {
                            showFullScreen(context, itemIndex);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: widget.property.houseImage![itemIndex].image!,
                              placeholder: (context, url) => Icon(
                                Icons.photo,
                                color: Colors.black12,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: widget.property.houseImage!.length>=2?
                          Row(
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
                                          widget.property.houseImage!.length,
                                          (index) => AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 800),
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
                  )),
              ListTile(
                  title: Text(
                    widget.property.title!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  subtitle: SeeMoreText(
                    text: widget.property.description!,
                    maxLines: 4,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 17,
                    ),
                    Expanded(
                      child: Text(
                        "${tr(widget.property.city!)}, ${widget.property.specificAddress!}",
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 10,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: ColorConstant.cardGrey,
                      backgroundImage:
                          widget.profilePicture.isNotEmpty
                              ? CachedNetworkImageProvider(
                                  ApiUrl.baseUrl +
                                      widget.profilePicture,
                                  headers: {
                                    'Authorization': 'Bearer ${widget.token}'
                                  },
                                )
                              : null,
                      child: widget.profilePicture.isEmpty
                          ? Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    ),
                    Text(
                      "${tr("posted by")} ${widget.userAccountEntity.firstName!}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                    )
                  ],
                ),
              ),
              Card(
                elevation: 0,
                color: ColorConstant.cardGrey.withValues(alpha: 0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: ColorConstant.cardGrey.withValues(alpha: 0))),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(
                        tr("Facilities"),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children:
                              List.generate(filteredAmenities.length, (index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 1,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      camenitiesIcon[filteredAmenities[index]]!,
                                      fit: BoxFit.cover,
                                      width: 33,
                                      height: 33,
                                    )),
                                Text(tr(filteredAmenities[index]),
                                  textAlign:TextAlign.start,
                                  overflow:TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10),
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ].animate(interval: 10.ms).fadeIn(),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: ColorConstant.cardGrey.withValues(alpha: 0.9),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 30,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text(
                      "${widget.property.price} ${tr(widget.property.unit!)}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    Text(
                      tr("per day"),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.inActiveColor),
                    )
                  ],
                ),
                Expanded(
                    child: CustomButton(
                        onPressed: () {
                          context.push('/booking', extra: widget.property.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          padding: EdgeInsets.all(18),
                        ),
                        child: Text(
                          tr("Book"),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                        )))
              ],
            ),
          )
        ].animate(interval: 100.ms).fade(),
      ),
    );
  }

  Future<dynamic> showFullScreen(BuildContext context, int itemIndex) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => GestureDetector(
              onTap: () {
                context.pop();
              },
              child: SizedBox(
                // padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: InteractiveViewer(
                    panEnabled: true, // Enable panning
                    scaleEnabled: true,
                    constrained: true,
                    boundaryMargin:
                        EdgeInsets.all(20), // Allow panning outside bounds
                    minScale: 3.0,
                    maxScale: 8.0, // Enable zooming
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: widget.property.houseImage![itemIndex].image!,
                        placeholder: (context, url) =>
                            CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  const SeeMoreText({super.key, required this.text, this.maxLines = 4});

  @override
  SeeMoreTextState createState() => SeeMoreTextState();
}

class SeeMoreTextState extends State<SeeMoreText> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          softWrap: true,
          // maxLines: _isExpanded ? null : widget.maxLines,
          // overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorConstant.secondBtnColor.withValues(alpha: 0.7)),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? tr('See More') : tr('See Less'),
            style: textTheme.bodySmall?.copyWith(
              color: ColorConstant.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
