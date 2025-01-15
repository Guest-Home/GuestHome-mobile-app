import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/color/color.dart';

class AmenitieTypeCard extends StatelessWidget {
  const AmenitieTypeCard({
    super.key,
    required this.icon,
    required this.title,
  });

  final String icon;
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
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              semanticsLabel: title,
              fit: BoxFit.cover,
            ),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorConstant.secondBtnColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
