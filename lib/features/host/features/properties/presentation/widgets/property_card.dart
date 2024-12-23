import 'package:flutter/material.dart';
import '../../../../../../config/color/color.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: ColorConstant.cardGrey.withValues(alpha: 1.6),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 5,
          children: [
            Placeholder(
              fallbackHeight: 200,
            ),
            ListTile(
              title: Text(
                'Property Name',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'House Description goes here.Lorem ipsum dolor sit amet consectetur. Posuere vulputate gravida diam id feugiat. Suscipit et nunc tortor vivamus mattis sed est.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: ColorConstant.primaryColor,
                ),
                Text(
                  'Addis Ababa, Ethiopia',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorConstant.inActiveColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              color: ColorConstant.inActiveColor.withValues(alpha: 0.2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 7,
                  children: [
                    Icon(
                      Icons.other_houses_rounded,
                      color: ColorConstant.primaryColor,
                    ),
                    Text(
                      '10',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: ColorConstant.primaryColor),
                    ),
                  ],
                ),
                RichText(
                    text: TextSpan(
                  text: 'Price: ',
                  children: [
                    TextSpan(
                      text: 'ETB 1000',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '/night',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: ColorConstant.inActiveColor),
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
