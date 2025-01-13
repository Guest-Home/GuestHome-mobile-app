import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';

class LocationMap extends StatelessWidget {
  const LocationMap({
    super.key, required this.loc,
  });

  final String loc;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Placeholder(
          fallbackHeight:200,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: ColorConstant.secondBtnColor,
                child: Icon(
                  Icons.location_on_sharp,
                  size: 17,
                  color: Colors.white,
                ),
              ),
              Text(loc,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: ColorConstant.secondBtnColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
