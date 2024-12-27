import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';

class LocationMap extends StatelessWidget {
  const LocationMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Placeholder(
          fallbackHeight: 150,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: ColorConstant.secondBtnColor,
                child: Icon(
                  Icons.location_on_sharp,
                  size: 19,
                  color: Colors.white,
                ),
              ),
              Text(
                "Addis Ababa,Ethiopia",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.secondBtnColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
