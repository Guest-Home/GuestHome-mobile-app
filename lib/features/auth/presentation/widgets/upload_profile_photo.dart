import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../config/color/color.dart';

class UploadProfilePhoto extends StatelessWidget {
  const UploadProfilePhoto({
    super.key,
    required this.ontTap,
  });
  final VoidCallback ontTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(27),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorConstant.cardGrey, width: 2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file,
              color: ColorConstant.primaryColor.withValues(alpha: 0.9),
            ),
            RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: tr("Click to upload profile picture"),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          decoration: TextDecoration.underline)),

                ])),
            Text(
              "PNG,JPG or PDF (max 3MB)",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorConstant.secondBtnColor.withValues(alpha: 0.6)),
            )
          ],
        ),
      ),
    );
  }
}