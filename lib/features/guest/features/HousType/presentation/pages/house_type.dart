import 'package:flutter/material.dart';
import 'package:minapp/config/color/color.dart';

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
                    itemExtent: MediaQuery.of(context).size.width - 60,
                    children: List.generate(
                      3,
                      (index) => Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            color: ColorConstant.cardGrey,
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
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
            sectionTitle(context, "What are you looking for?"),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                    mainAxisExtent: 100),
                itemCount: 12,
                itemBuilder: (context, index) => HouseTypeCard(
                      iconData: Icons.house,
                      title: "Private Rooms",
                    ))
          ],
        ),
      ),
    );
  }

  Text sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
