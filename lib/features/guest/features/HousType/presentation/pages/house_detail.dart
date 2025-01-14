import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/constants/house_type_icons.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';

import '../../../../../../core/apiConstants/api_url.dart';

class HouseDetail extends StatelessWidget {
  const HouseDetail({super.key, required this.property, required this.token});
  final ResultEntity property;
  final String token;

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height * 0.34,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      CarouselView(
                          itemExtent: MediaQuery.of(context).size.width,
                          children: List.generate(
                            property.houseImage!.length,
                            (index) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: property.houseImage![index].image!,
                                placeholder: (context, url) =>
                                    CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          )),
                      Positioned(
                          bottom: 10,
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
                                      color:
                                          Colors.black.withValues(alpha: 0.4),
                                    ),
                                    child: Row(
                                      children: List.generate(
                                          property.houseImage!.length,
                                          (index) => Container(
                                                width: 7,
                                                height: 7,
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: index == 0
                                                        ? Colors.white
                                                        : ColorConstant.cardGrey
                                                            .withValues(
                                                                alpha: 0.6)),
                                              )),
                                    ))
                              ]))
                    ],
                  )),
              ListTile(
                  title:
                      SecctionHeader(title: property.title!, isSeeMore: false),
                  subtitle: SeeMoreText(
                    text: property.description!,
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
                    Text(
                      property.specificAddress!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
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
                      backgroundImage: CachedNetworkImageProvider(
                        ApiUrl.baseUrl + property.postedBy!.profilePicture!,
                        headers: {'Authorization': 'Bearer $token'},
                      ),
                    ),
                    Text(
                      "${tr("posted by")} ${property.postedBy!.userAccount!.firstName!}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
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
                          children: List.generate(
                              property.subDescription!.split(',').length,
                              (index) {
                            final facilities =
                                property.subDescription!.split(',');
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
                                      camenitiesIcon[facilities[index]]!,
                                      fit: BoxFit.cover,
                                      width: 33,
                                      height: 33,
                                    )),
                                Text(
                                  facilities[index],
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
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: ColorConstant.cardGrey.withValues(alpha: 0.9),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 30,
              children: [
                Row(
                  spacing: 3,
                  children: [
                    Text(
                      "200 ETB",
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
                          context.push('/booking', extra: property.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          padding: EdgeInsets.all(18),
                        ),
                        child: Text(
                          tr("Book"),
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
        ],
      ),
    );
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
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'See More' : 'See Less',
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
