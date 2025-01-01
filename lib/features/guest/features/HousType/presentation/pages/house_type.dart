import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/constants/house_type_icons.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';

import '../../../../../../core/common/house_type_card.dart';

class HouseType extends StatelessWidget {
  const HouseType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Guest Home",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(Icons.notifications_none),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: CarouselView(
                    itemExtent: MediaQuery.of(context).size.width,
                    children: List.generate(
                      1,
                      (index) => Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            color: ColorConstant.cardGrey,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg",
                                placeholder: (context, url) =>
                                    CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 20,
                            right: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Discover the ultimate solution for all your property needs with our app.",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
            SecctionHeader(
              title: "What are you looking for?",
              isSeeMore: false,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                    mainAxisExtent: 100),
                itemCount: houseTypeList.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () => context.goNamed("houseTypeDetail"),
                      child: HouseTypeCard(
                        image: houseTypeIcons[houseTypeList[index]]!,
                        title: houseTypeList[index],
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
