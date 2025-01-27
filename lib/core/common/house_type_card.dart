import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/color/color.dart';

class HouseTypeCard extends StatelessWidget {
  const HouseTypeCard({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
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
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              semanticsLabel: title,
              fit: BoxFit.cover,
            ),
            Text(
              tr(title),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorConstant.secondBtnColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
