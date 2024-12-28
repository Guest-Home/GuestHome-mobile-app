import 'package:flutter/material.dart';

import '../../config/color/color.dart';

class HouseTypeCard extends StatelessWidget {
  const HouseTypeCard({
    super.key,
    required this.iconData,
    required this.title,
  });

  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorConstant.cardGrey)),
      elevation: 0,
      color: ColorConstant.cardGrey.withValues(alpha: 0.7),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: ColorConstant.primaryColor.withValues(alpha: 0.8),
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ColorConstant.secondBtnColor,),
            ),
          ],
        ),
      ),
    );
  }
}
