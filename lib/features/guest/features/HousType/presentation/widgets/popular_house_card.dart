import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';

class PopularHouseCard extends StatelessWidget {
  const PopularHouseCard({
    super.key,
    required this.width,
    required this.height,
    required this.hasStatus,
  });

  final double width;
  final double? height;
  final bool hasStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: hasStatus
                ? BorderSide.none
                : BorderSide(
                    color: ColorConstant.cardGrey.withValues(alpha: 0.6))),
        elevation: 0,
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
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
                                color: Colors.black.withValues(alpha: 0.4),
                              ),
                              child: Row(
                                children: List.generate(
                                    3,
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
                children: [
                  Text(
                    "Hasset Pension",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: ColorConstant.yellow,
                      ),
                      Text(
                        "4.0/5.0",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Text("Wifi, Kitchen",
                      style: TextStyle(
                          color: ColorConstant.secondBtnColor
                              .withValues(alpha: 0.4))),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:tr("posted by"),
                        style: TextStyle(
                            color: ColorConstant.secondBtnColor
                                .withValues(alpha: 0.4))),
                    TextSpan(
                        text: " @UserName",
                        style: TextStyle(
                            color: ColorConstant.secondBtnColor
                                .withValues(alpha: 1)))
                  ])),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "300 ETB ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.secondBtnColor)),
                    TextSpan(
                        text: tr("per day"),
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
                        size: 19,
                        color: ColorConstant.secondBtnColor,
                      ),
                      Text(
                        "Addis Ababa,Ethiopia",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.secondBtnColor),
                      )
                    ],
                  )
                ],
              ),
            ),
            if (hasStatus)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  spacing: 100,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr(
                      "Booking Status"),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w800),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                            color: ColorConstant.yellow,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Text(
                          "Pending",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
