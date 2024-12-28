import 'package:flutter/material.dart';

import '../../config/color/color.dart';

class AmenitieTypeCard extends StatelessWidget {
  const AmenitieTypeCard({
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
          spacing:10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size:36,
              color: ColorConstant.primaryColor.withValues(alpha: 0.9),
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ColorConstant.secondBtnColor,fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
