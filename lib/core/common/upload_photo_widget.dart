import 'package:flutter/material.dart';

import '../../config/color/color.dart';

class UploadPhoto extends StatelessWidget {
  const UploadPhoto({
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
                  text: "Click to upload ",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorConstant.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      decoration: TextDecoration.underline)),
              TextSpan(
                  text: "or drag and drop",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorConstant.secondBtnColor,fontSize: 14,fontWeight: FontWeight.w400))
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
